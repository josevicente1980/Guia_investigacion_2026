# Post-render: corregir exclusivamente los labels de la auditoría de maquetación
# y copiar la salida Word. No se modifican plantillas ni estilos globales.

archivo_docx <- file.path(
  ".render_tmp",
  "Investigacion_reproducible_con_R_y_Quarto.docx"
)

if (!file.exists(archivo_docx)) {
  message("Post-render DOCX: no se encontró la salida Word temporal.")
  quit(save = "no", status = 0)
}

ajuste <- system2(
  "powershell.exe",
  c(
    "-NoProfile", "-ExecutionPolicy", "Bypass", "-File",
    shQuote(file.path("R", "maquetacion_local_docx.ps1")),
    "-Path", shQuote(archivo_docx)
  )
)
if (ajuste != 0L) stop("Falló el ajuste local de maquetación DOCX.")

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
  stop(
    "Post-render DOCX: no se pudo actualizar el archivo principal. ",
    "Cierre el DOCX en Microsoft Word y vuelva a renderizar. ",
    "No se creó ninguna copia alternativa."
  )
} else {
  message(
    "Post-render DOCX: salida final actualizada en ",
    destino_principal
  )
}

message(
  "Post-render DOCX: ajustes locales aplicados; plantillas intactas."
)
