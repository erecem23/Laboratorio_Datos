# Vehicle theft in Argentina (2022-2023)
# Portfolio refactor of the original Laboratorio de Datos analysis.
# The original coursework script is preserved in original_analysis.R.

library(readr)
library(dplyr)
library(stringr)
library(lubridate)
library(ggplot2)

clean_vehicle_data <- function(datos) {
  datos %>%
    mutate(
      tramite_fecha = as.Date(tramite_fecha),
      fecha_inscripcion_inicial = as.Date(fecha_inscripcion_inicial),
      automotor_anio_modelo = as.numeric(automotor_anio_modelo),
      titular_anio_nacimiento = as.numeric(titular_anio_nacimiento),
      titular_genero = str_squish(titular_genero),
      automotor_origen = str_squish(automotor_origen),
      registro_seccional_provincia = str_squish(registro_seccional_provincia),
      automotor_marca_limpio = str_to_upper(str_squish(automotor_marca_limpio)),
      marca_modelo_limpio = str_to_upper(str_squish(marca_modelo_limpio)),
      birth_year_flag = if_else(
        !is.na(titular_anio_nacimiento) &
          (titular_anio_nacimiento <= 1934 | titular_anio_nacimiento >= 2005),
        TRUE, FALSE
      )
    )
}

audit_missing <- function(datos) {
  tibble(
    variable = names(datos),
    missing_n = sapply(datos, function(x) sum(is.na(x) | x == "")),
    missing_pct = round(100 * missing_n / nrow(datos), 2)
  ) %>% arrange(desc(missing_n))
}

top_frequencies <- function(datos, variable, n = 15) {
  datos %>% count({{ variable }}, sort = TRUE) %>% slice_head(n = n)
}

# Example usage:
# datos <- read_csv("../data/robo_autos_sample.csv", show_col_types = FALSE)
# datos <- clean_vehicle_data(datos)
# audit_missing(datos)
# top_frequencies(datos, automotor_marca_limpio, 10)
# tabla_origen_genero <- table(datos$automotor_origen, datos$titular_genero)
# chisq.test(tabla_origen_genero)
