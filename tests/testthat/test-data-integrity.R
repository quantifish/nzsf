test_that("bundled spatial data have CRSs and valid geometries", {
  package_environment <- as.environment("package:nzsf")
  object_names <- utils::data(package = "nzsf")$results[, "Item"]
  spatial_objects <- list()

  for (object_name in object_names) {
    object <- get(object_name, envir = package_environment)
    if (inherits(object, c("sf", "Raster"))) {
      spatial_objects[[object_name]] <- object
    }
  }

  expect_equal(length(spatial_objects), 49)
  for (object_name in names(spatial_objects)) {
    object <- spatial_objects[[object_name]]
    if (inherits(object, "sf")) {
      expect_false(is.na(sf::st_crs(object)), info = object_name)
      expect_true(all(sf::st_is_valid(object)), info = object_name)
    } else {
      expect_true(nzchar(raster::projection(object)), info = object_name)
    }
  }
})

test_that("depth lookup returns signed GEBCO elevations", {
  points <- sf::st_sfc(
    sf::st_point(c(174, -41)),
    sf::st_point(c(175, -40)),
    crs = 4326
  )
  depths <- lookup_depth(points)

  expect_type(depths, "double")
  expect_length(depths, 2)
  expect_true(all(is.finite(depths)))
  expect_true(all(depths < 0))

  expect_error(lookup_depth(data.frame(x = 174, y = -41)), "sf.*sfc")
  expect_error(lookup_depth(sf::st_sfc(sf::st_point(c(174, -41)))), "coordinate reference")
  line <- sf::st_sfc(sf::st_linestring(matrix(c(174, -41, 175, -40), ncol = 2,
                                               byrow = TRUE)), crs = 4326)
  expect_error(lookup_depth(line), "point geometries")
})

test_that("depth-resolution aliases are explicit", {
  expect_equal(nrow(get_depth(resolution = "medium")), 14859)
  expect_equal(nrow(get_depth(resolution = "small")), 4571)
  expect_error(get_depth(resolution = "typo"), "Unsupported `resolution`")
  expect_error(get_depth(resolution = c("low", "high")), "single, non-missing")
})

test_that("statistical-area selectors return distinct sf layers", {
  eez <- get_statistical_areas("EEZ")
  jma <- get_statistical_areas("JMA")
  fma <- get_statistical_areas("FMA")

  expect_s3_class(eez, "sf")
  expect_s3_class(jma, "sf")
  expect_s3_class(fma, "sf")
  expect_equal(nrow(eez), 1)
  expect_equal(nrow(jma), 121)
  expect_equal(nrow(fma), 10)
})

test_that("nzsf does not attach dependency packages", {
  description <- read.dcf(system.file("DESCRIPTION", package = "nzsf"))
  depends <- trimws(strsplit(description[1, "Depends"], ",")[[1]])

  expect_true(all(grepl("^R( |$)", depends)))
  expect_false("select" %in% getNamespaceExports("nzsf"))
})
