#' @import readxl
#' @import dplyr
#' @importFrom lubridate month
#' @import stringr
#' @import ggplot2
#' @import ggridges
NULL

#' Calcula valores NPS
#'
#' @param ventas Los datos de ventas
#'
#' @export
calcula_nps <- function(ventas) {
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

  return(vendedores_NPS)
}
