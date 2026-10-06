# Post-render DOCX: ajustes visuales seguros para Word.
# 1) código alineado a la izquierda;
# 2) no altera las propiedades OOXML de las tablas;
# 3) reconstrucción ZIP compatible con OOXML.

archivo_docx <- file.path(
  ".render_tmp",
  "Investigacion_reproducible_con_R_y_Quarto.docx"
)

dir.create(
  "reportes",
  showWarnings = FALSE,
  recursive = TRUE
)

if (!file.exists(archivo_docx)) {
  message("Post-render DOCX: no se encontró salida Word; no se aplican cambios.")
  quit(save = "no", status = 0)
}

dir_tmp <- tempfile("docx_post_")
dir.create(dir_tmp, recursive = TRUE)

on.exit(
  unlink(dir_tmp, recursive = TRUE, force = TRUE),
  add = TRUE
)

utils::unzip(
  archivo_docx,
  exdir = dir_tmp
)

archivo_estilos <- file.path(dir_tmp, "word", "styles.xml")
archivo_documento <- file.path(dir_tmp, "word", "document.xml")

if (!file.exists(archivo_estilos) || !file.exists(archivo_documento)) {
  stop("El DOCX no contiene styles.xml o document.xml.")
}

leer_xml <- function(ruta) {
  paste(
    readLines(ruta, warn = FALSE, encoding = "UTF-8"),
    collapse = "\n"
  )
}

# -------------------------------------------------------------------------
# 1. Código: solo Source Code queda alineado a la izquierda.
# -------------------------------------------------------------------------

xml_estilos <- leer_xml(archivo_estilos)

patron_source <- paste0(
  "(?s)<w:style\\b[^>]*",
  "w:styleId=\"SourceCode\"",
  "[^>]*>.*?</w:style>"
)

m_source <- regexpr(
  patron_source,
  xml_estilos,
  perl = TRUE
)

if (m_source[1] >= 0) {
  bloque_source <- regmatches(xml_estilos, m_source)

  bloque_source <- gsub(
    "<w:jc\\b[^>]*/>",
    "",
    bloque_source,
    perl = TRUE
  )

  if (grepl("<w:pPr\\b[^>]*>", bloque_source, perl = TRUE)) {
    bloque_source <- sub(
      "(<w:pPr\\b[^>]*>)",
      "\\1<w:jc w:val=\"left\"/>",
      bloque_source,
      perl = TRUE
    )
  } else {
    bloque_source <- sub(
      "(<w:style\\b[^>]*>)",
      "\\1<w:pPr><w:jc w:val=\"left\"/></w:pPr>",
      bloque_source,
      perl = TRUE
    )
  }

  regmatches(xml_estilos, m_source) <- bloque_source
}

# -------------------------------------------------------------------------
# 2. Tablas
# -------------------------------------------------------------------------
# No se modifica OOXML de tablas después del render.
#
# Razón: Word valida de forma estricta las propiedades de tabla. Las
# modificaciones globales de tblStylePr/tblGrid pueden producir documentos
# que Word abre únicamente después de una reparación. El formato tabular
# debe resolverse antes de que Pandoc cree el DOCX (en Quarto/R) o mediante
# una plantilla Word válida, nunca reescribiendo las propiedades de cada
# tabla en el archivo ya generado.

# -------------------------------------------------------------------------
# 4. Reconstrucción del DOCX con rutas ZIP válidas.
# -------------------------------------------------------------------------

archivo_zip <- tempfile(
  "docx_post_",
  fileext = ".zip"
)

if (.Platform$OS.type == "windows") {
  ruta_tmp <- normalizePath(
    dir_tmp,
    winslash = "\\",
    mustWork = TRUE
  )

  ruta_zip <- normalizePath(
    dirname(archivo_zip),
    winslash = "\\",
    mustWork = TRUE
  )

  ruta_zip <- file.path(
    ruta_zip,
    basename(archivo_zip)
  )

  ps <- paste0(
    "$ErrorActionPreference='Stop'; ",
    "Add-Type -AssemblyName System.IO.Compression; ",
    "Add-Type -AssemblyName System.IO.Compression.FileSystem; ",
    "$src='", gsub("'", "''", ruta_tmp), "'; ",
    "$dst='", gsub("'", "''", ruta_zip), "'; ",
    "if (Test-Path $dst) { Remove-Item $dst -Force }; ",
    "[System.IO.Compression.ZipFile]::CreateFromDirectory(",
      "$src,$dst,[System.IO.Compression.CompressionLevel]::Optimal,$false",
    ");"
  )

  estado <- system2(
    "powershell",
    c(
      "-NoProfile",
      "-Command",
      shQuote(ps)
    )
  )

  if (!identical(estado, 0L) || !file.exists(archivo_zip)) {
    stop("No fue posible reconstruir el DOCX con PowerShell.")
  }
} else {
  zip_cmd <- Sys.which("zip")

  if (!nzchar(zip_cmd)) {
    stop("No se encontró el comando zip para reconstruir el DOCX.")
  }

  wd_anterior <- getwd()
  on.exit(setwd(wd_anterior), add = TRUE)
  setwd(dir_tmp)

  estado <- system2(
    zip_cmd,
    c("-q", "-r", shQuote(archivo_zip), ".")
  )

  if (!identical(estado, 0L) || !file.exists(archivo_zip)) {
    stop("No fue posible reconstruir el DOCX.")
  }
}

ok <- file.copy(
  archivo_zip,
  archivo_docx,
  overwrite = TRUE
)

if (!ok) {
  stop("No fue posible reemplazar el DOCX temporal postprocesado.")
}

destino_principal <- file.path(
  "reportes",
  "Investigacion_reproducible_con_R_y_Quarto.docx"
)

copiado <- suppressWarnings(
  file.copy(
    archivo_docx,
    destino_principal,
    overwrite = TRUE
  )
)

if (!copiado) {
  sello <- format(
    Sys.time(),
    "%Y%m%d_%H%M%S"
  )

  destino_alternativo <- file.path(
    "reportes",
    paste0(
      "Investigacion_reproducible_con_R_y_Quarto_",
      sello,
      ".docx"
    )
  )

  copiado_alt <- file.copy(
    archivo_docx,
    destino_alternativo,
    overwrite = FALSE
  )

  if (!copiado_alt) {
    stop("No fue posible copiar el DOCX final a la carpeta reportes.")
  }

  message(
    "Post-render DOCX: el archivo principal estaba abierto; se guardó una copia alternativa en ",
    destino_alternativo
  )
} else {
  message(
    "Post-render DOCX: salida final actualizada en ",
    destino_principal
  )
}

message(
  paste(
    "Post-render DOCX: código a la izquierda;",
    "propiedades de tablas preservadas;",
    "archivo OOXML reconstruido correctamente."
  )
)
