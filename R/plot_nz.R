
plot_raster <- function(data, field, fun = "sum", nrow = 100, ncol = 100, ...) {
  r_empty <- raster(data, nrow = nrow, ncol = ncol)
  ras <- rasterize(x = data, y = r_empty, field = field, fun = fun)
  gg_ras <- data.frame(rasterToPoints(ras)) %>% mutate(layer = ifelse(layer == 0, NA, layer))
  
  geom_raster(data = gg_ras, aes(x = x, y = y, fill = layer), ...)
}

get_statistical_areas <- function(area = "CRA") {
  # shp <- "rock_lobster_stat_areas"
  # dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
  # x <- st_read(dsn = dsn, layer = shp) %>% rename(area = AREA_CODE)
  if (area %in% c("CRA")) {
    data("rock_lobster_stat_areas")
    x <- rock_lobster_stat_areas
  }
  return(x)
}

plot_statistical_areas <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", 
                                   area = "CRA", ...) {
  x <- get_statistical_areas(area = area) %>% st_transform(crs = proj, check = TRUE)
  geom_sf(data = x, ...)
}


#' Get the New Zealand coastline.
#' 
#' @param resolution the resolution
#' @param keep proportion of points to retain (0-1; default 1)
#' @return New Zealands coastline.
#' @export
#' @examples
#' get_coast(resolution = "low")
#' 
get_coast <- function(resolution = "low", keep = 1) {
  if (resolution %in% c("high", "150k")) {
    data("nz_coastlines_and_islands_polygons_topo_150k")
    x <- nz_coastlines_and_islands_polygons_topo_150k
  } else if (resolution %in% c("med", "1250k")) {
    data("nz_coastlines_and_islands_polygons_topo_1250k")
    x <- nz_coastlines_and_islands_polygons_topo_1250k
  } else {
    data("nz_coastlines_and_islands_polygons_topo_1500k")
    x <- nz_coastlines_and_islands_polygons_topo_1500k
  }
  if (keep < 1) x <- x %>% ms_simplify(keep = keep, keep_shapes = FALSE)
  return(x)
}

#' Plot the New Zealand coastline.
#' 
#' @param proj The projection to use.
#' @param resolution the resolution
#' @param keep proportion of points to retain (0-1; default 0.05)
#' @return ggplot of New Zealands coastline.
#' @export
#' @examples
#' ggplot() +
#'   plot_nz()
#' 
plot_nz <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", 
                    resolution = "low", keep = 1, ...) {
  x <- get_coast(resolution = resolution, keep = keep) %>% st_transform(crs = proj, check = TRUE)
  geom_sf(data = x, ...)
}
