# Configuración común del libro -------------------------------------------------

.perfiles_libro <- list(
  datos = c("dplyr", "tidyr", "tibble", "haven", "readr", "here", "knitr"),
  visual = c("dplyr", "tidyr", "tibble", "ggplot2", "scales", "here", "knitr"),
  tablas = c("dplyr", "tidyr", "tibble", "gt", "here", "knitr"),
  modelos = c("dplyr", "tidyr", "tibble", "ggplot2", "broom", "here", "knitr"),
  panel = c("dplyr", "tidyr", "tibble", "ggplot2", "broom", "plm", "knitr"),
  espacial = c("dplyr", "tidyr", "tibble", "ggplot2", "sf", "spdep", "spatialreg", "knitr"),
  comunicacion = c("dplyr", "tidyr", "tibble", "ggplot2", "broom", "knitr")
)

cargar_paquetes_libro <- function(perfiles = "datos", extra = character()) {
  paquetes <- unique(c(unlist(.perfiles_libro[perfiles], use.names = FALSE), extra))
  faltantes <- paquetes[!vapply(paquetes, requireNamespace, logical(1), quietly = TRUE)]

  if (length(faltantes)) {
    stop(
      "Faltan paquetes requeridos para renderizar: ",
      paste(faltantes, collapse = ", "),
      ". Instálelos antes de continuar.",
      call. = FALSE
    )
  }

  invisible(lapply(
    paquetes,
    function(pkg) suppressPackageStartupMessages(
      library(pkg, character.only = TRUE)
    )
  ))
}

ruta_objeto_libro <- function(nombre) {
  here::here("datos", "procesado", "ESPAC_2025", nombre)
}

leer_objeto_libro <- function(nombre) {
  ruta <- ruta_objeto_libro(nombre)
  if (!file.exists(ruta)) {
    stop(
      "No existe el objeto preprocesado: ", ruta,
      ". Ejecute R/pre_render.R o renderice el proyecto completo.",
      call. = FALSE
    )
  }
  readRDS(ruta)
}
