# Post-render seguro: copiar la salida Word sin modificar su OOXML.
# La alineación de los bloques de código se resuelve antes de Pandoc
# mediante filters/code-left-docx.lua.

archivo_docx <- file.path(
  ".render_tmp",
  "Investigacion_reproducible_con_R_y_Quarto.docx"
)

if (!file.exists(archivo_docx)) {
  message("Post-render DOCX: no se encontró la salida Word temporal.")
  quit(save = "no", status = 0)
}

dir.create(
  "reportes",
  showWarnings = FALSE,
  recursive = TRUE
)

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
  sello <- format(Sys.time(), "%Y%m%d_%H%M%S")

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
    "Post-render DOCX: el archivo principal estaba abierto; ",
    "se guardó una copia alternativa en ",
    destino_alternativo
  )
} else {
  message(
    "Post-render DOCX: salida final actualizada en ",
    destino_principal
  )
}

message(
  "Post-render DOCX: archivo copiado sin modificar su estructura OOXML."
)
