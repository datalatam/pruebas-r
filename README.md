# Mejora tu código R con pruebas automáticas

Antes de comenzar con los ejemplos por favor verifica lo siguiente:

1. Que tienes una versión de R actualizada. Vamos a trabajar con la version 3.4.1. 
Para verificar la versión que tienes instalada puedes correr en la consola:

    > R.Version()$version.string

La respuesta debería ser:

    [1] "R version 3.4.1 (2017-06-30)"

Si necesitas actualizar por favor visita la página correspondiente de r-project.org:

    https://cloud.r-project.org/


2. Que tienes una version de RStudio Actualizada. 

En RStudio busca la opción en el menu **Help >About RStudio**. Busca si tienes Versión 1.0.153 o mayor.
Si es menor instala una versión nueva ya sea con **Help > Check for Updates** o visitando las páginas de RStudio para bajar una nueva versión compatible con tu sistema:

    https://www.rstudio.com/products/rstudio/download/#download


3. Que tienes los paquetes necesarios 

Para que estes segur@ de tener todos los paquetes que vamos a utilizar lo mejor es que los instales de antemano. Con las siguientes instrucciones los puedes instalar todos:

    install.packages(c("devtools", "dplyr", "readxl", "lubridate", 
                "stringr", "ggplot2", "ggridges","dplyr","purr",
                "readr","tibble","tidyr"),  dependencies = TRUE)
                
    install.packages(c("testit", "testthat"),  dependencies = TRUE)
    
    devtools::install_github("ropenscilabs/testrmd")
