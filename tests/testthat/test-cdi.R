context("CDI plot")

test_that("running mean stops when it should", {
  
  expect_error( runningmean(0, c(0,0)) )
  
})

test_that("running mean with constant x or position", {
  
  n <- 100
  x <- rnorm(n)
  pos <- rep(0, n)
  expect_equal( runningmean(pos, x, window=1), rep(mean(x), n) )
  
})
