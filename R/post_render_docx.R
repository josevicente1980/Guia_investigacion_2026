# Post-render DOCX: ajustes visuales seguros para Word.
# 1) código alineado a la izquierda;
# 2) tablas académicas legibles, con columnas equilibradas y encabezados visibles;
# 3) reconstrucción ZIP compatible con OOXML (rutas internas con /).

archivo_docx <- file.path(
  "reportes",
  "Investigacion_reproducible_con_R_y_Quarto.docx"
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
# 2. Estilo de tablas: sobrio, académico y sin rejilla vertical pesada.
# -------------------------------------------------------------------------

patron_tabla <- paste0(
  "(?s)<w:style\\b[^>]*",
  "w:styleId=\"Table\"",
  "[^>]*>.*?</w:style>"
)

m_tabla <- regexpr(
  patron_tabla,
  xml_estilos,
  perl = TRUE
)

if (m_tabla[1] >= 0) {
  bloque_tabla <- regmatches(xml_estilos, m_tabla)

  # Elimina reglas firstRow/lastRow previas para evitar estilos contradictorios.
  bloque_tabla <- gsub(
    "(?s)<w:tblStylePr\\b[^>]*w:type=\"(?:firstRow|lastRow)\"[^>]*>.*?</w:tblStylePr>",
    "",
    bloque_tabla,
    perl = TRUE
  )

  estilo_filas <- paste0(
    "<w:tblStylePr w:type=\"firstRow\">",
      "<w:tcPr>",
        "<w:shd w:val=\"clear\" w:fill=\"EDEDED\"/>",
        "<w:tcBorders>",
          "<w:top w:val=\"single\" w:sz=\"8\" w:space=\"0\" w:color=\"666666\"/>",
          "<w:bottom w:val=\"single\" w:sz=\"8\" w:space=\"0\" w:color=\"666666\"/>",
        "</w:tcBorders>",
      "</w:tcPr>",
      "<w:rPr><w:b/></w:rPr>",
    "</w:tblStylePr>",
    "<w:tblStylePr w:type=\"lastRow\">",
      "<w:tcPr><w:tcBorders>",
        "<w:bottom w:val=\"single\" w:sz=\"8\" w:space=\"0\" w:color=\"666666\"/>",
      "</w:tcBorders></w:tcPr>",
    "</w:tblStylePr>"
  )

  bloque_tabla <- sub(
    "</w:style>$",
    paste0(estilo_filas, "</w:style>"),
    bloque_tabla,
    perl = TRUE
  )

  regmatches(xml_estilos, m_tabla) <- bloque_tabla
}

writeLines(
  xml_estilos,
  archivo_estilos,
  useBytes = TRUE
)

# -------------------------------------------------------------------------
# 3. Columnas: corrige anchos extremos generados por Pandoc/Word.
#    Solo se modifican tablas con dos o más columnas.
# -------------------------------------------------------------------------

xml_documento <- leer_xml(archivo_documento)

patron_grid <- "(?s)<w:tblGrid>.*?</w:tblGrid>"
m_grid <- gregexpr(
  patron_grid,
  xml_documento,
  perl = TRUE
)

grids <- regmatches(
  xml_documento,
  m_grid
)[[1]]

if (length(grids) > 0 && !identical(grids, character(0))) {
  grids_nuevos <- vapply(
    grids,
    function(g) {
      cols <- gregexpr(
        "<w:gridCol\\b[^>]*/>",
        g,
        perl = TRUE
      )[[1]]

      n <- if (cols[1] < 0) 0L else length(cols)

      if (n < 2L) {
        return(g)
      }

      ancho <- floor(7920 / n)

      gsub(
        "(<w:gridCol\\b[^>]*w:w=\")[0-9]+(\"[^>]*/>)",
        paste0("\\1", ancho, "\\2"),
        g,
        perl = TRUE
      )
    },
    character(1)
  )

  regmatches(
    xml_documento,
    m_grid
  ) <- list(grids_nuevos)
}

writeLines(
  xml_documento,
  archivo_documento,
  useBytes = TRUE
)

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
  stop("No fue posible reemplazar el DOCX renderizado.")
}

message(
  paste(
    "Post-render DOCX: código a la izquierda;",
    "tablas con encabezado académico y columnas equilibradas;",
    "archivo OOXML reconstruido correctamente."
  )
)
