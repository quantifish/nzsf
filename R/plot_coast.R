#' Get the New Zealand coastline.
#' 
#' @param resolution the resolution
#' @param keep proportion of points to retain (0-1; default 1)
#' @return New Zealands coastline.
#' @export
#' @examples
#' x <- get_coast(resolution = "low")
#' ggplot() +
#'   geom_sf(data = x, fill = "forestgreen")
#' 
get_coast <- function(resolution = "low", keep = 1) {
  if (resolution %in% c("h", "high", "150k")) {
    data("nz_coastlines_and_islands_polygons_topo_150k")
    x <- nz_coastlines_and_islands_polygons_topo_150k
  } else if (resolution %in% c("m", "med", "1250k")) {
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
#'   plot_coast()
#' 
plot_coast <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", 
                       resolution = "low", keep = 1, ...) {
  x <- get_coast(resolution = resolution, keep = keep) %>% st_transform(crs = proj, check = TRUE)
  geom_sf(data = x, ...)
}
