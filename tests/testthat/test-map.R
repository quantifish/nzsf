context("NZ map plot")

test_that("running mean with constant x or position", {
  
  library(nzsf)
  plot_nz()
  expect_equal( p, rep(mean(x), n) )
  
})
