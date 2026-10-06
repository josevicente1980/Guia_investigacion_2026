# Auditoría reproducible del libro
# Proyecto: Guia_investigacion_2026
# Objetivo: auditar estructura, citas y bibliografía con base R.

anio_corte <- as.integer(format(Sys.Date(), "%Y"))
umbral_antiguedad <- anio_corte - 5

dir.create("00_conocimiento_editorial/auditorias/resultados",
           recursive = TRUE, showWarnings = FALSE)

qmd <- c(
  "index.qmd",
  "prologo.qmd",
  "como-utilizar-este-libro.qmd",
  list.files("capitulos", pattern = "\\.qmd$", full.names = TRUE),
  "bibliografia.qmd"
)
qmd <- qmd[file.exists(qmd)]

leer <- function(x) paste(readLines(x, warn = FALSE, encoding = "UTF-8"),
                          collapse = "\n")

texto <- vapply(qmd, leer, character(1))

# Retira bloques de código cercados para no confundir ejemplos BibTeX
# con citas reales de Quarto.
quitar_bloques_codigo <- function(txt) {
  gsub("(?s)\x60\x60\x60.*?\x60\x60\x60|(?s)~~~.*?~~~", "", txt, perl = TRUE)
}

# Extrae claves de citas tipo @clave fuera de bloques de código.
extraer_citas <- function(txt) {
  txt <- quitar_bloques_codigo(txt)
  m <- gregexpr("(?<![[:alnum:]_.%+-])@[A-Za-z0-9_:.+/-]+",
                txt, perl = TRUE)
  x <- regmatches(txt, m)[[1]]
  if (length(x) == 1 && identical(x, character(0))) return(character())
  unique(sub("^@", "", x))
}

citas_por_archivo <- lapply(texto, extraer_citas)
citas <- sort(unique(unlist(citas_por_archivo, use.names = FALSE)))

bib_path <- "referencias/referencias.bib"
if (!file.exists(bib_path)) stop("No existe ", bib_path)

bib_lines <- readLines(bib_path, warn = FALSE, encoding = "UTF-8")
inicio <- grep("^\\s*@[A-Za-z]+\\s*\\{", bib_lines)

bib_keys <- sub("^\\s*@[A-Za-z]+\\s*\\{\\s*([^,]+),.*$", "\\1",
                bib_lines[inicio])
bib_keys <- trimws(bib_keys)

bib_duplicadas <- sort(unique(bib_keys[duplicated(bib_keys)]))
bib_keys_unicas <- unique(bib_keys)

# Divide el .bib por entradas para extraer año de manera trazable.
fin <- c(inicio[-1] - 1L, length(bib_lines))
entradas <- Map(function(i, j) bib_lines[i:j], inicio, fin)
names(entradas) <- bib_keys

extraer_anio <- function(lines) {
  z <- grep("^\\s*(year|date)\\s*=", lines, value = TRUE, ignore.case = TRUE)
  if (!length(z)) return(NA_integer_)
  y <- regmatches(z[1], regexpr("[12][0-9]{3}", z[1]))
  if (!length(y) || identical(y, "")) return(NA_integer_)
  as.integer(y)
}

anios <- vapply(entradas, extraer_anio, integer(1))

citas_sin_bib <- setdiff(citas, bib_keys_unicas)
bib_no_citadas <- setdiff(bib_keys_unicas, citas)

tabla_citas <- do.call(rbind, lapply(names(citas_por_archivo), function(f) {
  k <- citas_por_archivo[[f]]
  if (!length(k)) {
    data.frame(archivo = f, clave = NA_character_, stringsAsFactors = FALSE)
  } else {
    data.frame(archivo = f, clave = k, stringsAsFactors = FALSE)
  }
}))

tabla_bib <- data.frame(
  clave = bib_keys,
  anio = unname(anios),
  citada = bib_keys %in% citas,
  mas_de_5_anios = !is.na(anios) & anios < umbral_antiguedad,
  stringsAsFactors = FALSE
)

write.csv(tabla_citas,
          "00_conocimiento_editorial/auditorias/resultados/citas_por_archivo.csv",
          row.names = FALSE, fileEncoding = "UTF-8")
write.csv(data.frame(clave = citas_sin_bib),
          "00_conocimiento_editorial/auditorias/resultados/citas_sin_bibliografia.csv",
          row.names = FALSE, fileEncoding = "UTF-8")
write.csv(data.frame(clave = bib_no_citadas),
          "00_conocimiento_editorial/auditorias/resultados/bibliografia_no_citada.csv",
          row.names = FALSE, fileEncoding = "UTF-8")
write.csv(data.frame(clave = bib_duplicadas),
          "00_conocimiento_editorial/auditorias/resultados/claves_bibtex_duplicadas.csv",
          row.names = FALSE, fileEncoding = "UTF-8")
write.csv(tabla_bib,
          "00_conocimiento_editorial/auditorias/resultados/auditoria_bibliografia.csv",
          row.names = FALSE, fileEncoding = "UTF-8")

n_bib <- nrow(tabla_bib)
n_bib_unicas <- length(bib_keys_unicas)
n_antiguas <- sum(tabla_bib$mas_de_5_anios, na.rm = TRUE)
pct_antiguas <- if (n_bib) 100 * n_antiguas / n_bib else NA_real_

estado_citas <- if (length(citas_sin_bib) == 0) "PASS" else "BLOCK"
estado_duplicadas <- if (length(bib_duplicadas) == 0) "PASS" else "BLOCK"
estado_bib_no_cit <- if (length(bib_no_citadas) == 0) "PASS" else "REVIEW"
estado_antig <- if (!is.na(pct_antiguas) && pct_antiguas <= 20) "PASS" else "REVIEW"

resumen <- c(
  "# Auditoría automática — estructura, citas y bibliografía",
  "",
  paste0("Fecha de ejecución: ", Sys.Date()),
  paste0("Año de corte: ", anio_corte),
  "",
  "## Resumen",
  "",
  paste0("- Archivos QMD auditados: ", length(qmd)),
  paste0("- Claves de cita detectadas: ", length(citas)),
  paste0("- Entradas BibTeX: ", n_bib),
  paste0("- Claves BibTeX únicas: ", n_bib_unicas),
  paste0("- Claves BibTeX duplicadas: ", length(bib_duplicadas),
         " — **", estado_duplicadas, "**"),
  paste0("- Citas sin entrada BibTeX: ", length(citas_sin_bib),
         " — **", estado_citas, "**"),
  paste0("- Entradas BibTeX no citadas: ", length(bib_no_citadas),
         " — **", estado_bib_no_cit, "**"),
  paste0("- Referencias con más de 5 años: ", n_antiguas,
         " de ", n_bib, " (",
         ifelse(is.na(pct_antiguas), "NA", sprintf("%.1f%%", pct_antiguas)),
         ") — **", estado_antig, "**"),
  "",
  "## Criterio",
  "",
  "El porcentaje de referencias con más de cinco años es un control editorial, no una regla de eliminación automática. Las fuentes clásicas, metodológicas, normativas o históricas deben conservarse cuando estén científicamente justificadas.",
  "",
  "## Estado",
  "",
  paste0("- Integridad citas↔BibTeX: **", estado_citas, "**"),
  paste0("- Unicidad de claves BibTeX: **", estado_duplicadas, "**"),
  paste0("- Bibliografía no citada: **", estado_bib_no_cit, "**"),
  paste0("- Antigüedad bibliográfica: **", estado_antig, "**")
)

writeLines(resumen,
           "00_conocimiento_editorial/auditorias/resultados/resumen_auditoria_bibliografia.md",
           useBytes = TRUE)

cat(paste(resumen, collapse = "\n"), "\n")
