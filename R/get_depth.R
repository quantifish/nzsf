#' Get depth polylines around New Zealand.
#' 
#' @param resolution the resolution
#' @return New Zealands depth polylines.
#' @export
#' @examples
#' x <- get_depth(resolution = "low")
#' ggplot() +
#'   geom_sf(data = x, colour = "lightblue)
#' 
get_depth <- function(resolution = "low") {
  if (resolution %in% c("high", "122k_190k")) {
    data("depth_contour_polyline_hydro_122k_190k")
    x <- depth_contour_polyline_hydro_122k_190k
  } else if (resolution %in% c("med", "190k_1350k")) {
    data("depth_contour_polyline_hydro_190k_1350k")
    x <- depth_contour_polyline_hydro_190k_1350k
  } else {
    data("depth_contour_polyline_hydro_1350k_11500k")
    x <- depth_contour_polyline_hydro_1350k_11500k
  }
  x
}

#' Plot depth polylines around New Zealand.
#' 
#' @param proj The projection to use.
#' @param resolution the resolution
#' @return ggplot of New Zealands depth polylines.
#' @export
#' @examples
#' ggplot() + 
#'   plot_depth()
#'  ggplot() + 
#'   plot_depth(resolution = "high") +
#'   plot_coast()
#' 
plot_depth <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", 
                       resolution = "low", ...) {
  x <- get_depth(resolution = resolution) %>% st_transform(crs = proj, check = TRUE)# %>% filter(depth %in% c(200))
  geom_sf(data = x, ...)
}
