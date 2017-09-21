# Data Latam - Curso Profesional pruebas R
# anotate a las noticias Data Latam en http://eepurl.com/cMbJK9

# stop() y stopifnot() --------
# Metodos para parar código en mitad de camino:

stop()

stop("Este es mi propio mensaje de error")

if (!2 == 3 ){
  stop("Desde cuando 2 equivale 3?")
}

if (2 == 2 ){
  stop("Por dicha para R 2 equivale 2
        pero eso no es un error")
}

# Parar código en mitad de camino:

stopifnot(2 == 3)

stopifnot(2 == 2)

stopifnot(2 == 2, "A" == "A")

stopifnot(2 == 2, "A" == "A", all(1:10 < 9))


# Ejemplo en un script -----
library(readxl)
library(dplyr)
library(lubridate)
library(stringr)
library(ggplot2)
library(ggridges)

ventas <- read_excel("../datos/ventas-1.xlsx")

# Categorias del NPS 
categorias_nps <- ventas %>% 
  mutate(categoria = ifelse(nps >= 0 & nps < 7, "Detractor",
                            ifelse(nps >= 6 & nps < 9, "Neutral", 
                                   "Promotor")))

# Miremos si podemos usar stopifnot para verificar que no hay nada diferente
# a los valores esperados en la columna categoria
# 
# Un forma podria ser
stopifnot(c("Detractor", "Neutral", "Promotor", "Otro") %in% 
            c("Detractor", "Neutral", "Promotor"))
# La otra 
stopifnot(c("Detractor", "Neutral", "Promotor") %in% 
            c("Detractor", "Neutral", "Promotor", "Otro"))

# Osea podemos estar listos para la oportunidad de que no todas las columnas
# esten llenas
# 
stopifnot(unique(categorias_nps$categoria) %in% 
            c("Detractor", "Neutral", "Promotor"))

# Porque da un error?
# 
unique(categorias_nps$categoria)

# Porque no tomamos en cuenta los NA
# Si lo hacemos la prueba pasa otra vez
stopifnot(unique(categorias_nps$categoria) %in% 
            c("Detractor", "Neutral", "Promotor", NA))

# Ojo que  no es asi (porque no?)
stopifnot(unique(categorias_nps$categoria) %in% 
            c("Detractor", "Neutral", "Promotor", "NA"))


# Extendamos el calculo de las Categorias del NPS 
# Necesitmamos una columnas nuevas
vendedores_NPS <- ventas %>% 
  mutate(categoria = ifelse(nps >= 0 & nps < 7, "Detractor",
                            ifelse(nps >= 6 & nps < 9, "Neutral", 
                                   "Promotor"))) %>% 
  mutate(mes = month(Fecha)) %>% 
  group_by(`Vendedor ID`, mes) %>% 
  summarise(total_prom = sum(str_count(categoria, "Promotor"), na.rm = TRUE),
            total_det = sum(str_count(categoria, "Detractor"), na.rm = TRUE),
            total = sum(!is.na(categoria))) %>% 
  mutate(nps_promedio = ((total_prom / total) * 100) - ((total_det / total) * 100)) %>% 
  select_all()

# Tenemos los valores de NPS, pero no tenemos los nombres. Estos tenemos
# que sacar de otro lado.

vendedores_Nombres <- ventas %>%
  select(`Vendedor Nombre`, `Vendedor Apellido`, `Vendedor ID`) %>% 
  distinct()

vendedores <- vendedores_Nombres %>% 
  left_join(vendedores_NPS, by = c("Vendedor ID"="Vendedor ID"))

# Se ve bien! 
# Pero ....

View(vendedores)

# Ahora antes de unirlos, hagamos unas pruebas para asegurarnos de que todo
# es como lo esperamos. Pero primero introducimos testit
# Pruebas con testit ----
library(testit)

for (i in 1:20) {
  cat("El valor de i es", i, "\n")
  stopifnot(!i == 3)
}

for (i in 1:20) {
  cat("El valor de i es", i, "\n")
  assert("i no equivale 3", i != 3)
}

has_warning(1 + 1)
has_warning(1:2 + 1:3)

has_error(2 - 3)
has_error(1 + "a")

# Entonces podemos exigir caracteristicas antes de unir las tablas
assert("Todos los vendedores tienen Nombre", 
       !is.na(vendedores_Nombres$`Vendedor Nombre`))

assert("Todos los vendedores tienen Apellido", 
       !is.na(vendedores_Nombres$`Vendedor Apellido`))

assert("Todos los vendedores tienen ID", 
       !is.na(vendedores_Nombres$`Vendedor ID`))

# La pregunta ahora es: Que es esencial. En este caso diría que el tener
# Los ID completo es lo más importante, asi que tenemos que hacer algo para que
# esta prueba pase:
# 

vendedores_Nombres <- vendedores_Nombres %>% 
  filter(!is.na(`Vendedor ID`))

assert("Todos los vendedores tienen ID", 
       !is.na(vendedores_Nombres$`Vendedor ID`))

vendedores <- vendedores_Nombres %>% 
  left_join(vendedores_NPS, by = c("Vendedor ID"="Vendedor ID"))

# Ahora para comparar valores

vendedores <- vendedores_Nombres %>% 
  left_join(vendedores_NPS, by = c("Vendedor ID"="Vendedor ID")) %>% 
  filter(!is.nan(nps_promedio))

ggplot(data = vendedores, aes(x = mes, y = nps_promedio)) + geom_violin()

## base para valores nps -----
nps_joy <- ventas %>% 
  filter(!is.na(nps)) %>% 
  group_by(`Vendedor ID`) %>% 
  mutate(promedio = mean(nps)) %>% 
  filter(promedio < 9) %>%
  arrange(promedio) %>% 
  ungroup() %>% 
  mutate(`Vendedor ID` = factor(`Vendedor ID`, unique(`Vendedor ID`)))

ggplot(data = nps_joy, aes(x = nps, y = `Vendedor ID`, fill = `Vendedor ID`)) + 
  geom_density_ridges() +
  theme(axis.title.y = element_blank(),
        legend.position='none')

ggplot(data = nps_joy, aes(x = nps, y = `Vendedor ID`, fill = `Vendedor ID`)) + 
  geom_density_ridges(stat = "binline", bins = 10, draw_baseline = FALSE) + 
  theme(axis.title.y = element_blank(),
        legend.position='none')

# Ahora cambio los datos ----
ventas <- read_excel("../datos/ventas-2.xlsx")


# Como pruebo que esta correcto usando lo que vimos antes?
# Para evitar la bomba en RStudio la siguiente prueba funciona
stopifnot(class(ventas$nps) == "numeric")


