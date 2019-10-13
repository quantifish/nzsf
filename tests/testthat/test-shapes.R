context("Dimensions of shapes")

test_that("number of QMAs", {
  
  expect_equal(nrow(get_qma("COC")), 13)
  expect_equal(nrow(get_qma("CRA")), 10)
  expect_equal(nrow(get_qma("PAU")), 11)
  expect_equal(nrow(get_qma("PHC")), 1)
  expect_equal(nrow(get_qma("PPI")), 10)
  expect_equal(nrow(get_qma("SCA")), 13)
  
  expect_equal(nrow(get_qma("HAK")), 4)
  expect_equal(nrow(get_qma("HOK")), 2)
  expect_equal(nrow(get_qma("JMA")), 4)
  expect_equal(nrow(get_qma("LIN")), 8)
  expect_equal(nrow(get_qma("ORH")), 8)
  expect_equal(nrow(get_qma("OEO")), 5)
  expect_equal(nrow(get_qma("SBW")), 5)
  expect_equal(nrow(get_qma("SWA")), 4)
  
})

test_that("number of shapes", {
  
  expect_equal(nrow(get_marine_reserves()), 44)
  expect_equal(nrow(get_depth(resolution = "low")), 4571)
  expect_equal(nrow(get_depth(resolution = "med")), 14859)
  expect_equal(nrow(get_depth(resolution = "high")), 17157)
  expect_equal(nrow(get_coast(resolution = "low")), 725)
  expect_equal(nrow(get_coast(resolution = "med")), 1699)
  expect_equal(nrow(get_coast(resolution = "high")), 9261)
  
})
