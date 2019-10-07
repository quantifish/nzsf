#' Get depth polylines around New Zealand.
#' 
#' @return New Zealands depth polylines.
#' @examples
#' get_depth()
#' 
get_depth <- function() {
  shp <- "depth-contour-polyline-hydro-1350k-11500k"
  dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
  x <- st_read(dsn = dsn, layer = shp) %>% rename(depth = VALDCO)
  x
}


#' Plot depth polylines around New Zealand.
#' 
#' @param proj The projection to use.
#' @return ggplot of New Zealands depth polylines.
#' @examples
#' ggplot() + 
#'   plot_depth()
#' 
plot_depth <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", ...) {
  x <- get_depth() %>% st_transform(crs = proj, check = TRUE)# %>% filter(depth %in% c(200))
  geom_sf(data = x, ...)
}
