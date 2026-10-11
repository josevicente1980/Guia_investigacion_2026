# Auditoría reproducible del entorno R/Quarto -------------------------------

dir_resultados <- file.path(
  "00_conocimiento_editorial", "auditorias", "resultados"
)
dir.create(dir_resultados, recursive = TRUE, showWarnings = FALSE)

paquetes_requeridos <- unique(c(
  "dplyr", "tidyr", "tibble", "haven", "readr", "here", "knitr",
  "ggplot2", "scales", "gt", "broom", "plm", "sf", "spdep",
  "spatialreg", "moments", "leaflet", "maps", "htmlwidgets",
  "patchwork", "car", "spData", "lme4", "mlmRev", "broom.mixed",
  "frontier", "modelsummary", "gapminder", "bibliometrix", "quarto",
  "tinytex"
))

instalado <- vapply(
  paquetes_requeridos,
  requireNamespace,
  logical(1),
  quietly = TRUE
)

version_paquete <- vapply(
  paquetes_requeridos,
  function(pkg) {
    if (!requireNamespace(pkg, quietly = TRUE)) return(NA_character_)
    as.character(utils::packageVersion(pkg))
  },
  character(1)
)

tabla_paquetes <- data.frame(
  paquete = paquetes_requeridos,
  instalado = instalado,
  version = version_paquete,
  stringsAsFactors = FALSE
)

utils::write.csv(
  tabla_paquetes,
  file.path(dir_resultados, "entorno_paquetes.csv"),
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

quarto_cli <- tryCatch(
  system2("quarto", "--version", stdout = TRUE, stderr = TRUE),
  error = function(e) NA_character_
)

resumen_entorno <- c(
  "# Auditoría local del entorno",
  "",
  paste0("Fecha: ", Sys.Date()),
  paste0("R: ", R.version.string),
  paste0(
    "Quarto CLI: ",
    ifelse(length(quarto_cli) && !is.na(quarto_cli[1]), quarto_cli[1], "NO DETECTADO")
  ),
  paste0("Paquetes requeridos: ", length(paquetes_requeridos)),
  paste0("Paquetes disponibles: ", sum(instalado)),
  paste0("Paquetes faltantes: ", sum(!instalado))
)

if (any(!instalado)) {
  resumen_entorno <- c(
    resumen_entorno,
    "",
    "## Paquetes faltantes",
    "",
    paste0("- ", paquetes_requeridos[!instalado])
  )
}

writeLines(
  resumen_entorno,
  file.path(dir_resultados, "resumen_entorno.md"),
  useBytes = TRUE
)

if (any(!instalado)) {
  stop(
    "Faltan paquetes requeridos para reproducir el libro: ",
    paste(paquetes_requeridos[!instalado], collapse = ", "),
    call. = FALSE
  )
}

if (!length(quarto_cli) || is.na(quarto_cli[1])) {
  stop("No se detectó Quarto CLI en el entorno.", call. = FALSE)
}

message(
  "Pre-render: entorno verificado (",
  length(paquetes_requeridos),
  " paquetes y Quarto CLI)."
)
