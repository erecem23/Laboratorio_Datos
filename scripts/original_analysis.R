##configuración de mi entorno de trabajo
setwd("C:/Users/Moren/Desktop")

#1. Carga de paquetes
install.packages("readr")
install.packages("ggplot2")
install.packages("Hmisc")
install.packages("corrplot")
install.packages("corrplot")
install.packages("xlsx")
install.packages("openxlsx")

library(readr)
library(ggplot2)
library(Hmisc)
library(corrplot)
library(plyr)
library(xlsx)
library(openxlsx)

#2. Carga de datos se cargó a través de File> Import
# nombre: Robo_Autos_2022_version_final3

####3. Analisis exploratorio ######
info <- str(Robo_Autos_2022_2023_version_final3)
summary(Robo_Autos_2022_2023_version_final3)
describe(Robo_Autos_2022_2023_version_final3)
cabeza<- head(Robo_Autos_2022_2023_version_final3)
write.xlsx(cabeza,"head.xlsx")

### AJUSTE DE VARIABLES ####
unique(Robo_Autos_2022_2023_version_final3$tramite_tipo)
Robo_Autos_2022_2023_version_final3$tramite_tipo <- as.factor(Robo_Autos_2022_2023_version_final3$tramite_tipo)
levels(Robo_Autos_2022_2023_version_final3$tramite_tipo)
Robo_Autos_2022_2023_version_final3$tramite_fecha <- as.Date(Robo_Autos_2022_2023_version_final3$tramite_fecha, format("%d/%m/%Y"))
Robo_Autos_2022_2023_version_final3$fecha_inscripcion_inicial <- as.Date(Robo_Autos_2022_2023_version_final3$fecha_inscripcion_inicial, format("%d/%m/%Y"))

unique(Robo_Autos_2022_2023_version_final3$titular_domicilio_provincia)
Robo_Autos_2022_2023_version_final3$titular_domicilio_provincia <- as.factor(Robo_Autos_2022_2023_version_final3$titular_domicilio_provincia)
unique(Robo_Autos_2022_2023_version_final3$titular_pais_nacimiento)
Robo_Autos_2022_2023_version_final3$titular_pais_nacimiento <- as.factor(Robo_Autos_2022_2023_version_final3$titular_pais_nacimiento)
Robo_Autos_2022_2023_version_final3$titular_genero <- as.factor(Robo_Autos_2022_2023_version_final3$titular_genero)
Robo_Autos_2022_2023_version_final3$Tipo_Vehiculo <- as.factor(Robo_Autos_2022_2023_version_final3$Tipo_Vehiculo)
Robo_Autos_2022_2023_version_final3$automotor_origen  <- as.factor(Robo_Autos_2022_2023_version_final3$automotor_origen)
Robo_Autos_2022_2023_version_final3$registro_seccional_provincia <- as.factor(Robo_Autos_2022_2023_version_final3$registro_seccional_provincia)
Robo_Autos_2022_2023_version_final3$titular_tipo_persona <- as.factor(Robo_Autos_2022_2023_version_final3$titular_tipo_persona)
Robo_Autos_2022_2023_version_final3$automotor_marca_limpio <- as.factor(Robo_Autos_2022_2023_version_final3$automotor_marca_limpio)
Robo_Autos_2022_2023_version_final3$marca_modelo_limpio <- as.character(Robo_Autos_2022_2023_version_final3$marca_modelo_limpio)

### Deteccion y tratamiento de valores perdidos ####
is.na(Robo_Autos_2022_2023_version_final3)
any(is.na(Robo_Autos_2022_2023_version_final3))
sum(is.na(Robo_Autos_2022_2023_version_final3))
mean(is.na(Robo_Autos_2022_2023))
colSums(is.na(Robo_Autos_2022_2023_version_final3))
colMeans(is.na(Robo_Autos_2022_2023_version_final3), round(2))
missing_data_proportions <- colMeans(is.na(Robo_Autos_2022_2023_version_final3), round(2))
formatted_proportions <- format(missing_data_proportions, digits = 2, scientific = FALSE)

columnas_numericas <- which(sapply(Robo_Autos_2022_2023_version_final3, is.numeric))
cols_mean <- colMeans(Robo_Autos_2022_2023_version_final3[, columnas_numericas], na.rm = TRUE)
for (x in columnas_numericas) {
  Robo_Autos_2022_2023_version_final3[is.na(Robo_Autos_2022_2023_version_final3[,x]), x] <- round(cols_mean[x],2)
}

num_variables <- Robo_Autos_2022_2023_version_final3[,c(8,24,26,29,30,31)]

# Tabla de frecuencias diarias recuperada en el trabajo original
robo_fechas_renombrado <- robo_fechas %>% rename(dia = ...1, fecha = Var1, cantidad = Freq)
correlation <- cor(robo_fechas_renombrado$dia, robo_fechas_renombrado$cantidad)
cat("Coeficiente de correlación de Pearson:", correlation, "\n")
model <- lm(cantidad ~ dia, data = robo_fechas_renombrado)
summary(model)

correlacion <- cor(num_variables,use="pairwise.complete.obs")
corrplot(correlacion, method = "square")

tabla_tipo_v <- table(Robo_Autos_2022_2023_version_final3$Tipo_Vehiculo)
tabla_contingencia <- table(Robo_Autos_2022_2023_version_final3$automotor_origen,Robo_Autos_2022_2023_version_final3$titular_genero)
tabla_fecha_corr <- table(Robo_Autos_2022_2023_version_final3$tramite_fecha)
resultado_chi_cuadrado <- chisq.test(tabla_contingencia)
tabla_contigencia2 <- table(Robo_Autos_2022_2023_version_final3$categoria_abarcativa,Robo_Autos_2022_2023_version_final3$titular_genero)
resultado_chi_cuadrado2 <- chisq.test(tabla_contigencia2)

ggplot(Robo_Autos_2022_2023_version_final3, aes(x = automotor_origen, fill = titular_genero)) +
  geom_bar() +
  labs(title = "Tabla de contingencia: origen del auto vs genero", x = "Origen del automotor", y = "Frecuencia") +
  theme_light()

ggplot(Robo_Autos_2022_2023_version_final3, aes(x = categoria_abarcativa, fill = titular_genero)) +
  geom_bar() +
  labs(title = "Tabla de contingencia: Tipo_Auto vs Genero", x = "Origen del automotor", y = "Frecuencia") +
  theme_light()

Robo_Autos_2022_2023_version_final3$tramite_fecha2 <- weekdays(as.Date(Robo_Autos_2022_2023_version_final3$tramite_fecha2))
frecuencias_dias_ordenadas <- sort(table(Robo_Autos_2022_2023_version_final3$tramite_fecha2), decreasing = TRUE)
Robo_Autos_2022_2023_version_final3$fecha_inscripcion_inicial <- weekdays(as.Date(Robo_Autos_2022_2023_version_final3$fecha_inscripcion_inicial))

###### EXPERIMENTAL: SEPARAR COLUMNAS POR EXPRESIONES REGULARES ########
Robo_Autos_2022_2023_version_final3 <- Robo_Autos_2022_2023_version_final3 %>% separate(automotor_tipo_descripcion, into = c("nueva_columna", "resto"), sep = "[0-9]+\\s*")
tabla_frecuencias <- table(Robo_Autos_2022_2023_version_final3$nueva_columna)
Robo_Autos_2022_2023_version_final3 <- Robo_Autos_2022_2023_version_final3 %>% separate(nueva_columna, into = c("nueva_columna", "resto"), sep = " ")

tipo_vehiculo_agrupado <- rep(NA, length(Robo_Autos_2022_2023_version_final3$automotor_tipo_descripcion))
for (categoria in names(categorias_tipo_vehiculo2)) {
  categoria_vector <- categorias_tipo_vehiculo2[[categoria]]
  tipo_vehiculo_agrupado[categoria_vector] <- categoria
}
Robo_Autos_2022_2023_version_final3$tipo_vehiculo_agrupado <- tipo_vehiculo_agrupado

Robo_Autos_2022_2023_version_final3 <- Robo_Autos_2022_2023_version_final3 %>%
  mutate(categoria_abarcativa = case_when(
    `Tipo_Vehiculo (calculada` %in% c("SEDAN", "FAMILIAR", "HATCHBACK","DESCAPOTABLE","CABRIOLET","CONVERTIBLE","BERLINA","COUPE") ~ "AUTOMOVIL",
    `Tipo_Vehiculo (calculada` %in% c("PICKUP","TODO","cAMIONETA","MINIBUS","RURAL","CAMIONETA") ~ "cAMIONETA",
    `Tipo_Vehiculo (calculada` %in% c("UTILITARIO","fURGÓN","FURGON","CAJA") ~ "UTILITARIO",
    `Tipo_Vehiculo (calculada` %in% c("CAMION","SEMIRREMOLQUE","SEMIACOPLADO","TRACTOR") ~ "CAMION",
    `Tipo_Vehiculo (calculada` %in% c("CHASIS") ~ "CHASIS",
    TRUE ~ "otros"
  ))

datos_filtrados <- Robo_Autos_2022_2023_version_final3 %>% filter(categoria_abarcativa == "otros")
conteo_tipo_vehiculo <- datos_filtrados %>% group_by(Tipo_Vehiculo) %>% summarise(Conteo = n())
