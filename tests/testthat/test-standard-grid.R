projected_bbox <- function(xmin = -200000, ymin = -200000,
                           xmax = 200000, ymax = 200000) {
  sf::st_bbox(
    c(xmin = xmin, ymin = ymin, xmax = xmax, ymax = ymax),
    crs = sf::st_crs(proj_nzsf())
  )
}

test_that("all supported grids share the EPSG:9191 origin", {
  sizes <- c(0.25, 0.5, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024)
  origins <- lapply(sizes, get_standard_grid_origin,
                    bounding_box = projected_bbox())

  for (i in seq_along(sizes)) {
    size_m <- sizes[[i]] * 1000
    expect_equal(origins[[i]]$xmin %% size_m, 0)
    expect_equal(origins[[i]]$xmax %% size_m, 0)
    expect_equal(origins[[i]]$ymin %% size_m, 0)
    expect_equal(origins[[i]]$ymax %% size_m, 0)
  }
})

test_that("custom anchors place grid boundaries on the requested lattice", {
  bbox <- projected_bbox(xmin = 1100, ymin = -2000, xmax = 3100, ymax = 500)
  origin <- get_standard_grid_origin(1, bbox, anchor = c(500, -250))

  expect_equal(origin$xmin, 500)
  expect_equal(origin$xmax, 3500)
  expect_equal(origin$ymin, -2250)
  expect_equal(origin$ymax, 750)
  expect_equal(unname((unlist(origin[c("xmin", "xmax")]) - 500) %% 1000),
               c(0, 0))
  expect_equal(unname((unlist(origin[c("ymin", "ymax")]) + 250) %% 1000),
               c(0, 0))
})

test_that("geographic bounding boxes are transformed before gridding", {
  geographic <- sf::st_bbox(
    c(xmin = 174, ymin = -42, xmax = 176, ymax = -40),
    crs = sf::st_crs(4326)
  )
  projected <- geographic %>%
    sf::st_as_sfc() %>%
    sf::st_transform(proj_nzsf()) %>%
    sf::st_bbox()

  from_geographic <- get_standard_grid(64, geographic, return_raster = TRUE)
  from_projected <- get_standard_grid(64, projected, return_raster = TRUE)

  expect_equal(raster::extent(from_geographic), raster::extent(from_projected))
  expect_equal(raster::res(from_geographic), c(64000, 64000))
})

test_that("raster and polygon grids have matching extents and resolution", {
  bbox <- projected_bbox(xmin = -90000, ymin = -70000,
                         xmax = 80000, ymax = 60000)
  polygons <- get_standard_grid(32, bbox, return_raster = FALSE)
  raster <- get_standard_grid(32, bbox, return_raster = TRUE)
  polygon_extent <- unname(as.numeric(sf::st_bbox(polygons)))
  raster_extent <- c(raster::xmin(raster), raster::ymin(raster),
                     raster::xmax(raster), raster::ymax(raster))

  expect_equal(polygon_extent, raster_extent)
  expect_equal(raster::res(raster), c(32000, 32000))
  expect_true(sf::st_crs(polygons) == sf::st_crs(raster::crs(raster)))
})

test_that("grid inputs are validated", {
  bbox <- projected_bbox()
  no_crs <- sf::st_bbox(c(xmin = 0, ymin = 0, xmax = 1, ymax = 1))
  longlat <- sf::st_bbox(c(xmin = 174, ymin = -42, xmax = 176, ymax = -40),
                         crs = sf::st_crs(4326))

  for (size in list(0, -1, NA_real_, Inf, c(1, 2), "1")) {
    expect_error(get_standard_grid_origin(size, bbox), "cell_size")
  }
  for (anchor in list(1, c(1, NA), c(1, Inf), c("1", "2"))) {
    expect_error(get_standard_grid_origin(1, bbox, anchor = anchor), "anchor")
  }
  expect_error(get_standard_grid_origin(1, longlat), "projected")
  expect_error(get_standard_grid_origin(1, no_crs), "coordinate reference")
  expect_error(get_standard_grid(1, bbox, crs = 4326), "projected")
  expect_error(get_standard_grid(1, bbox, crs = 2277), "metres")
  expect_error(get_standard_grid(1, bbox, return_raster = NA), "return_raster")
  expect_error(get_standard_grid(1, bbox, square = c(TRUE, FALSE)), "square")
  expect_error(get_standard_grid(1, c(0, 0, 1, 1)), "st_bbox")
})
