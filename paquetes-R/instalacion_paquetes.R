
# Curso Profesional Mejora tu código en R con pruebas atomáticas
# Organizado por: DataLatam
# Impartido por: Frans van Dunné
# Contacto: hola@datalatam.com
# www.datalatam.com
# www.ixpantia.com


# ------- 1. Instalación paquetes necesarios para el taller---------------------

# purrr

install.packages("paquetes/purrr_0.2.3.tar.gz", 
                 repos = NULL, type = "source")

# ggplot2

install.packages("paquetes/ggplot2_2.1.1.tar.gz", 
                 repos = NULL, type = "source")

# dplyr

install.packages("paquetes/dplyr_0.7.3.tar.gz", 
                 repos = NULL, type = "source")

# readr

install.packages("paquetes/readr_1.1.1.tar.gz", 
                 repos = NULL, type = "source")

# testthat

install.packages("paquetes/testthat_1.0.2.tar.gz", 
                 repos = NULL, type = "source")

# tibble

install.packages("paquetes/tibble_1.3.4.tar.gz", 
                 repos = NULL, type = "source")

# tidyr

install.packages("paquetes/tidyr_0.7.1.tar.gz", 
                 repos = NULL, type = "source")

# ------------------- 2. Cargar paquetes en la sesión --------------------------

library(ggplot2)
library(tidyr)
library(tibble)
library(purrr)
library(dplyr)
library(testthat)
library(readr)