
plot_raster <- function(data, field, fun = "sum", nrow = 100, ncol = 100, ...) {
  r_empty <- raster(data, nrow = nrow, ncol = ncol)
  ras <- rasterize(x = data, y = r_empty, field = field, fun = fun)
  gg_ras <- data.frame(rasterToPoints(ras)) %>% mutate(layer = ifelse(layer == 0, NA, layer))
  
  geom_raster(data = gg_ras, aes(x = x, y = y, fill = layer), ...)
}

get_cra_stats <- function() {
  shp <- "rock_lobster_stat_areas"
  dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
  x <- st_read(dsn = dsn, layer = shp) %>% rename(area = AREA_CODE)
  x
}

plot_cra_stats <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", ...) {
  x <- get_cra_stats() %>% st_transform(crs = proj, check = TRUE)
  geom_sf(data = x, ...)
}


#' Get the New Zealand coastline.
#' 
#' @param keep proportion of points to retain (0-1; default 0.05)
#' @return New Zealands coastline.
#' @examples
#' get_coast(keep = 0.25)
#' 
get_coast <- function(keep = 0.05) {
  shp <- "nz-coastlines-and-islands-polygons-topo-150k"
  dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
  x <- st_read(dsn = dsn, layer = shp) %>% ms_simplify(keep = keep, keep_shapes = FALSE)
  x
}


#' Plot the New Zealand coastline.
#' 
#' @param keep proportion of points to retain (0-1; default 0.05)
#' @return ggplot of New Zealands coastline.
#' @examples
#' ggplot() +
#'   plot_nz(keep = 0.1)
#' 
plot_nz <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", 
                    keep = 0.05, ...) {
  x <- get_coast(keep = keep) %>% st_transform(crs = proj, check = TRUE)
  geom_sf(data = x, ...)
}
