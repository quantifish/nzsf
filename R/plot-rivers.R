#' Plot New Zealand rivers.
#' 
#' @param proj The coordinate reference system to use: integer with the EPSG code, or character with \code{proj4string}.
#' @param ... Other arguments passed on to \code{geom_sf}.
#' @return ggplot of New Zealands rivers.
#' 
#' @importFrom ggplot2 geom_sf
#' @importFrom sf st_transform
#' @export
#' @examples
#' ggplot() +
#'   plot_rivers()
#' 
plot_rivers <- function(proj = proj_nzsf(), ...) {
  
  x <- nzsf::nz_rivers
  
  if (!is.null(proj)) x <- x %>% st_transform(crs = proj, check = TRUE)
  
  p <- geom_sf(data = x, ...)
  
  return(p)
}

