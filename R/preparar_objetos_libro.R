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


# Base pedagógica para los capítulos de modelación -----------------------------
# Se genera de forma determinista para no usar el factor de expansión de la
# ESPAC como predictor sustantivo. Su función es exclusivamente didáctica.

set.seed(20261005)

n_demo <- 1200L

region <- factor(
  sample(
    c("Loja", "Azuay", "Guayas", "Pichincha"),
    n_demo,
    replace = TRUE,
    prob = c(0.28, 0.22, 0.25, 0.25)
  ),
  levels = c("Loja", "Azuay", "Guayas", "Pichincha")
)

tamano_empresa <- factor(
  sample(
    c("Micro", "Pequeña", "Mediana", "Grande"),
    n_demo,
    replace = TRUE,
    prob = c(0.35, 0.35, 0.20, 0.10)
  ),
  levels = c("Micro", "Pequeña", "Mediana", "Grande")
)

capital <- round(
  pmax(
    0.5,
    rlnorm(
      n_demo,
      meanlog = 1.35 +
        0.20 * as.numeric(tamano_empresa),
      sdlog = 0.45
    )
  ),
  2
)

edad_empresa <- pmax(
  1,
  round(rgamma(n_demo, shape = 3.2, scale = 3.0))
)

efecto_region <- c(
  Loja = 0.00,
  Azuay = 0.08,
  Guayas = 0.16,
  Pichincha = 0.20
)

efecto_tamano <- c(
  Micro = 0.00,
  Pequeña = 0.12,
  Mediana = 0.24,
  Grande = 0.36
)

sd_error <- 0.22 + 0.015 * capital

log_productividad <- 1.10 +
  0.18 * capital +
  0.012 * edad_empresa +
  unname(efecto_region[as.character(region)]) +
  unname(efecto_tamano[as.character(tamano_empresa)]) +
  rnorm(n_demo, sd = sd_error)

modelo_demo <- data.frame(
  id = seq_len(n_demo),
  region = region,
  tamano_empresa = tamano_empresa,
  capital = capital,
  edad_empresa = edad_empresa,
  productividad = exp(log_productividad),
  log_productividad = log_productividad
)

modelo_demo$alta_productividad <- as.integer(
  modelo_demo$log_productividad >
    median(modelo_demo$log_productividad, na.rm = TRUE)
)

saveRDS(
  modelo_demo,
  file.path(dir_salida, "modelo_demo.rds"),
  compress = FALSE
)

message("Pre-render: base pedagógica de modelación disponible.")
