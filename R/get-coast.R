#' Get the New Zealand coastline
#' 
#' @param proj The coordinate reference system to use: integer with the EPSG code, or character with \code{proj4string}.
#' @param resolution the resolution.
#' @param keep proportion of points to retain (0-1; default 1).
#' @return New Zealands coastline as a \code{sf} object.
#' 
#' @seealso \code{\link{plot_coast}}
#' 
#' @importFrom utils data
#' @importFrom rmapshaper ms_simplify
#' @import sf
#' @export
#' @examples
#' x <- get_coast(resolution = "low")
#' ggplot() +
#'   geom_sf(data = x, fill = "forestgreen")
#' 
get_coast <- function(proj = proj_nzsf(), resolution = "low", keep = 1) {
  if (resolution %in% c("h", "high", "150k")) {
    x <- nzsf::nz_coastlines_and_islands_polygons_topo_150k
  } else if (resolution %in% c("m", "med", "1250k")) {
    x <- nzsf::nz_coastlines_and_islands_polygons_topo_1250k
  } else {
    x <- nzsf::nz_coastlines_and_islands_polygons_topo_1500k
  }
  if (keep < 1) x <- x %>% ms_simplify(keep = keep, keep_shapes = FALSE)
  if (!is.null(proj)) x <- x %>% st_transform(crs = proj, check = TRUE)
  return(x)
}


#' Plot the New Zealand coastline.
#' 
#' @inheritParams get_coast
#' @param ... Other arguments passed on to \code{geom_sf}.
#' @return ggplot of New Zealands coastline.
#' 
#' @seealso \code{\link{get_coast}}
#' 
#' @importFrom ggplot2 geom_sf
#' @importFrom sf st_transform
#' @export
#' @examples
#' ggplot() +
#'   plot_coast()
#' 
plot_coast <- function(proj = proj_nzsf(), resolution = "low", keep = 1, ...) {
  x <- get_coast(proj = proj, resolution = resolution, keep = keep)
  p <- geom_sf(data = x, ...)
  return(p)
}
