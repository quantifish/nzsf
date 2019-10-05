context("Dimensions of shapes")

test_that("number of QMAs", {
  
  expect_equal(nrow(get_qma("CRA")), 10)
  expect_equal(nrow(get_qma("PHC")), 1)
  expect_equal(nrow(get_qma("PAU")), 11)
  expect_equal(nrow(get_qma("COC")), 13)
  expect_equal(nrow(get_qma("HAK")), 4)
  expect_equal(nrow(get_qma("HOK")), 2)
  expect_equal(nrow(get_qma("LIN")), 8)
  
})

test_that("number of shapes", {
  
  expect_equal(nrow(get_marine_reserves()), 44)
  expect_equal(nrow(get_depth()), 4571)
  expect_equal(nrow(get_coast()), 303)
  
})
