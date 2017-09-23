context("prueba")
library(readxl)

ventas <- read_excel("test_ventas.xlsx")

test_that("multiplication works", {
  expect_equal(2 * 2, 4)
  expect_equal(3 * 2, 6)
  expect_equal(4 * 2, 8)
})

# test_that("El archivo ventas contiene lo que esperamos", {
#   expect_match("RAMIREZ", ventas$`Vendedor Nombre`[1])
#   expect_match("PÉREX", ventas$`Vendedor Apellido`[1])
# })
#
# test_that("El calculo de NPS da el resultado esperado", {
#   # esta es una illustración del las "abreviaciones" (short cuts) de
#   # testthat
#   valores_nps <- calcula_nps(ventas)
#
#   expect_that(unique(valores_nps$mes) == c(5,6,7,8,4), is_true())
#   expect_true(unique(valores_nps$mes) == c(5,6,7,8,4))
#
#   # No funcionan bien. Pero testthat tiene compare()
#   compare(unique(valores_nps$mes),c(5,6,7,8,4))
#
#   # lo que permite entonces:
#   expect_equal(unique(valores_nps$mes),c(5,6,7,8,4))
# })
