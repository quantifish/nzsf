#' Get depth polylines around New Zealand
#' 
#' @param proj The coordinate reference system to use: integer with the EPSG code, or character with \code{proj4string}.
#' @param resolution the resolution.
#' @return New Zealands depth polylines as a \code{sf} object.
#' 
#' @author Darcy Webber \email{darcy@quantifish.co.nz}
#' 
#' @seealso \code{\link{plot_depth}}
#' 
#' @importFrom utils data
#' @export
#' @examples
#' x <- get_depth(resolution = "low")
#' ggplot() +
#'   geom_sf(data = x, colour = "lightblue")
#' 
get_depth <- function(proj = proj_nzsf(), resolution = "low") {
  if (resolution %in% c("high", "122k_190k")) {
    x <- nzsf::depth_contour_polyline_hydro_122k_190k
  } else if (resolution %in% c("med", "190k_1350k")) {
    x <- nzsf::depth_contour_polyline_hydro_190k_1350k
  } else {
    x <- nzsf::depth_contour_polyline_hydro_1350k_11500k
  }
  if (!is.null(proj)) x <- x %>% st_transform(crs = proj, check = TRUE)
  return(x)
}


#' Plot depth polylines around New Zealand
#' 
#' @inheritParams get_depth
#' @param ... Other arguments passed on to \code{geom_sf}.
#' @return A \code{ggplot} object of New Zealands depth polylines.
#' 
#' @author Darcy Webber \email{darcy@quantifish.co.nz}
#' 
#' @seealso \code{\link{get_depth}}
#' 
#' @importFrom ggplot2 geom_sf
#' @importFrom sf st_transform
#' @export
#' @examples
#' ggplot() + 
#'   plot_depth()
#' 
plot_depth <- function(proj = proj_nzsf(), resolution = "low", ...) {
  x <- get_depth(proj = proj, resolution = resolution)
  p <- geom_sf(data = x, ...)
  return(p)
}
