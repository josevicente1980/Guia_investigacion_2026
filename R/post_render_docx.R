# Post-render DOCX: alinear exclusivamente los bloques de código a la izquierda.
# El cuerpo del libro conserva los estilos definidos en plantillas/plantilla.docx.

archivo_docx <- file.path(
  "reportes",
  "Investigacion_reproducible_con_R_y_Quarto.docx"
)

if (!file.exists(archivo_docx)) {
  message("Post-render DOCX: no se encontró salida Word; no se aplican cambios.")
  quit(save = "no", status = 0)
}

dir_tmp <- tempfile("docx_code_left_")
dir.create(dir_tmp, recursive = TRUE)

on.exit(
  unlink(dir_tmp, recursive = TRUE, force = TRUE),
  add = TRUE
)

utils::unzip(
  archivo_docx,
  exdir = dir_tmp
)

archivo_estilos <- file.path(
  dir_tmp,
  "word",
  "styles.xml"
)

if (!file.exists(archivo_estilos)) {
  stop("No se encontró word/styles.xml dentro del DOCX.")
}

xml <- paste(
  readLines(
    archivo_estilos,
    warn = FALSE,
    encoding = "UTF-8"
  ),
  collapse = "\n"
)

patron_estilo <- paste0(
  "(?s)<w:style\\b[^>]*",
  "w:styleId=\"SourceCode\"",
  "[^>]*>.*?</w:style>"
)

m <- regexpr(
  patron_estilo,
  xml,
  perl = TRUE
)

if (m[1] < 0) {
  stop("No se encontró el estilo Source Code en el DOCX renderizado.")
}

bloque <- regmatches(
  xml,
  m
)

# Elimina cualquier alineación previa dentro de Source Code.
bloque <- gsub(
  "<w:jc\\b[^>]*/>",
  "",
  bloque,
  perl = TRUE
)

if (grepl("<w:pPr\\b[^>]*>", bloque, perl = TRUE)) {
  bloque <- sub(
    "(<w:pPr\\b[^>]*>)",
    "\\1<w:jc w:val=\"left\"/>",
    bloque,
    perl = TRUE
  )
} else {
  bloque <- sub(
    "(<w:style\\b[^>]*>)",
    "\\1<w:pPr><w:jc w:val=\"left\"/></w:pPr>",
    bloque,
    perl = TRUE
  )
}

regmatches(
  xml,
  m
) <- bloque

writeLines(
  xml,
  archivo_estilos,
  useBytes = TRUE
)

archivo_zip <- tempfile(
  "docx_code_left_",
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

  comando <- paste0(
    "$ErrorActionPreference='Stop'; ",
    "Compress-Archive -Path '",
    gsub("'", "''", file.path(ruta_tmp, "*")),
    "' -DestinationPath '",
    gsub("'", "''", ruta_zip),
    "' -Force"
  )

  estado <- system2(
    "powershell",
    c(
      "-NoProfile",
      "-Command",
      shQuote(comando)
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
  on.exit(
    setwd(wd_anterior),
    add = TRUE
  )
  setwd(dir_tmp)

  estado <- system2(
    zip_cmd,
    c(
      "-q",
      "-r",
      shQuote(archivo_zip),
      "."
    )
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
  stop("No fue posible reemplazar el DOCX renderizado.")
}

message(
  "Post-render DOCX: bloques Source Code alineados a la izquierda; resto de estilos intacto."
)
