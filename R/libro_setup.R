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


# Etiquetas legibles para tablas de modelos ------------------------------------

etiquetar_terminos_modelo <- function(x) {
  x <- as.character(x)

  x <- dplyr::recode(
    x,
    "(Intercept)" = "Intercepto",
    "capital" = "Capital",
    "edad_empresa" = "Edad",
    "standLRT" = "Puntaje",
    "value" = "Valor mercado",
    .default = x
  )

  x <- gsub(
    "^capital:tamano_empresa",
    "Capital × ",
    x
  )
  x <- gsub(
    "^tamano_empresa([^:]+):capital$",
    "Capital × \\1",
    x
  )
  x <- gsub(
    "^tamano_empresa",
    "",
    x
  )
  x <- gsub(
    "^region",
    "",
    x
  )

  x
}


formatear_p_tabla <- function(x, digits = 3) {
  ifelse(
    is.na(x),
    NA_character_,
    ifelse(
      x < 0.001,
      "<0,001",
      formatC(
        x,
        format = "f",
        digits = digits,
        decimal.mark = ","
      )
    )
  )
}


formatear_num_tabla <- function(x, digits = 3) {
  vapply(
    x,
    function(z) {
      if (is.na(z)) return(NA_character_)
      if (z != 0 && abs(z) < 0.001) {
        return(
          formatC(
            z,
            format = "e",
            digits = 2,
            decimal.mark = ","
          )
        )
      }
      formatC(
        z,
        format = "f",
        digits = digits,
        decimal.mark = ","
      )
    },
    character(1)
  )
}

formatear_estimacion_ic <- function(estimate, low, high) {
  paste0(
    formatear_num_tabla(estimate, 3),
    " [",
    formatear_num_tabla(low, 3),
    "; ",
    formatear_num_tabla(high, 3),
    "]"
  )
}

# Los chunks de Quarto pueden ejecutarse en un entorno distinto de .GlobalEnv.
# Publicar allí los helpers permite que los chunks encuentren estas funciones
# después de source(), sin duplicar sus implementaciones.
if (requireNamespace("knitr", quietly = TRUE)) {
  .entorno_libro <- environment()
  .entorno_knitr <- knitr::knit_global()
  .helpers_libro <- c(
    "cargar_paquetes_libro",
    "ruta_objeto_libro",
    "leer_objeto_libro",
    "etiquetar_terminos_modelo",
    "formatear_p_tabla",
    "formatear_num_tabla",
    "formatear_estimacion_ic"
  )

  for (.helper in .helpers_libro) {
    assign(
      .helper,
      get(.helper, envir = .entorno_libro, inherits = FALSE),
      envir = .entorno_knitr
    )
  }

  rm(.entorno_libro, .entorno_knitr, .helpers_libro, .helper)
}
