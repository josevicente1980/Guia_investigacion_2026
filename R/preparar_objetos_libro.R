# Preparación eficiente de objetos reutilizados en el libro -------------------

origen <- file.path("datos", "original", "ESPAC_2025", "spss", "sunac2025.sav")
dir_salida <- file.path("datos", "procesado", "ESPAC_2025")
dir.create(dir_salida, recursive = TRUE, showWarnings = FALSE)

archivo_raw <- file.path(dir_salida, "sunac.rds")
archivo_limpio <- file.path(dir_salida, "sunac_limpio.rds")
archivo_transformado <- file.path(dir_salida, "sunac_transformado.rds")

necesita_actualizar <- function(entrada, salida) {
  !file.exists(salida) ||
    file.info(entrada)$mtime > file.info(salida)$mtime
}

if (!file.exists(origen)) {
  stop("No se encontró la fuente ESPAC requerida: ", origen, call. = FALSE)
}

requeridos <- c("haven", "dplyr")
faltantes <- requeridos[!vapply(requeridos, requireNamespace, logical(1), quietly = TRUE)]
if (length(faltantes)) {
  stop("Faltan paquetes para preparar los objetos: ", paste(faltantes, collapse = ", "), call. = FALSE)
}

if (necesita_actualizar(origen, archivo_raw)) {
  message("Pre-render: importando ESPAC una sola vez...")
  sunac_raw <- haven::read_sav(origen)
  saveRDS(sunac_raw, archivo_raw, compress = FALSE)
} else {
  sunac_raw <- readRDS(archivo_raw)
}

if (necesita_actualizar(archivo_raw, archivo_limpio)) {
  message("Pre-render: construyendo objeto limpio...")
  sunac_limpio <- sunac_raw |>
    dplyr::mutate(
      su_tenencia = haven::as_factor(su_tenencia)
    )
  saveRDS(sunac_limpio, archivo_limpio, compress = FALSE)
} else {
  sunac_limpio <- readRDS(archivo_limpio)
}

if (necesita_actualizar(archivo_limpio, archivo_transformado)) {
  message("Pre-render: construyendo base analítica reutilizable...")
  sunac_transformado <- sunac_limpio |>
    dplyr::mutate(
      su_categoria = haven::as_factor(su_categoria),
      provincia = haven::as_factor(ual_prov),
      tamano_upa = dplyr::case_when(
        is.na(supertotal) ~ NA_character_,
        supertotal < 1 ~ "Micro",
        supertotal < 5 ~ "Pequeña",
        supertotal < 20 ~ "Mediana",
        TRUE ~ "Grande"
      ),
      tiene_bosque = dplyr::if_else(
        is.na(us_montesha),
        NA_character_,
        dplyr::if_else(us_montesha > 0, "Sí", "No")
      ),
      tiene_transitorios = dplyr::if_else(
        is.na(us_transiha),
        NA_character_,
        dplyr::if_else(us_transiha > 0, "Sí", "No")
      ),
      pct_bosque = dplyr::if_else(
        !is.na(supertotal) & supertotal > 0,
        (us_montesha / supertotal) * 100,
        NA_real_
      ),
      grupo_tamano = dplyr::case_when(
        is.na(supertotal) ~ NA_character_,
        supertotal < 5 ~ "Pequeños productores",
        TRUE ~ "Medianos y grandes productores"
      )
    )

  # Se conserva la base completa transformada: capítulos posteriores necesitan
  # variables originales y derivadas. No se reduce aquí la unidad de análisis.
  saveRDS(sunac_transformado, archivo_transformado, compress = FALSE)
}

message("Pre-render: objetos ESPAC disponibles y actualizados.")
