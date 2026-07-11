test_that("plot helpers honour requested projections", {
  reserves <- plot_marine_reserves(proj = 4326)
  expect_equal(sf::st_crs(reserves[[1]]$data), sf::st_crs(4326))

  cra_labels <- suppressWarnings(geom_cra(qma = "CRA1", proj = 4326))
  expect_equal(sf::st_crs(cra_labels$data), sf::st_crs(4326))

  point <- sf::st_sfc(sf::st_point(c(174, -41)), crs = 4326)
  clipped <- plot_clip(point, proj = proj_nzsf())
  expect_equal(sf::st_crs(clipped$crs), sf::st_crs(proj_nzsf()))
  expect_gt(abs(clipped$limits$x[1]), 1000)
})

test_that("selector helpers reject unsupported inputs clearly", {
  expect_error(get_qma("BOGUS"), "Unsupported `qma`")
  expect_error(get_qma(c("CRA", "PAU")), "single, non-missing")
  expect_error(get_statistical_areas("BOGUS"), "Unsupported `area`")
  expect_error(plot_clip(42), "`x` must be")
  expect_error(geom_cra(feature = "polygon"), "should be")
  expect_error(get_coast(resolution = "extreme"), "Unsupported `resolution`")
  expect_error(get_coast(keep = 0), "`keep` must be")
  expect_error(geom_ccamlr(feature = "ice"), "Unsupported `feature`")
  expect_error(geom_ccsbt(feature = "ocean"), "Unsupported `feature`")
})

test_that("plot_raster preserves valid zero values", {
  points <- data.frame(
    x = c(0.25, 0.75, 0.25, 0.75),
    y = c(0.25, 0.25, 0.75, 0.75),
    value = c(0, 1, 0, 1)
  )
  points <- sf::st_as_sf(points, coords = c("x", "y"), crs = 4326)

  layer <- plot_raster(
    data = points,
    field = "value",
    fun = "sum",
    nrow = 2,
    ncol = 2
  )

  expect_true(any(layer$data$layer == 0))
})

test_that("standard grids support raster and polygon outputs", {
  area <- get_statistical_areas("CRA", proj = proj_nzsf())
  bbox <- sf::st_bbox(area[1, ])

  polygon_grid <- get_standard_grid(
    cell_size = 64,
    bounding_box = bbox,
    return_raster = FALSE
  )
  raster_grid <- get_standard_grid(
    cell_size = 64,
    bounding_box = bbox,
    return_raster = TRUE
  )

  expect_s3_class(polygon_grid, "sf")
  expect_s4_class(raster_grid, "RasterLayer")
  expect_gt(nrow(polygon_grid), 0)
  expect_gt(raster::ncell(raster_grid), 0)
})
