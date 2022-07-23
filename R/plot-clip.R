#' Clip to a shapefile.
#' 
#' @param x The sf object to clip to.
#' @param proj The coordinate reference system to use: integer with the EPSG code, or character with \code{proj4string}.
#' @param ... Other arguments passed on to \code{coord_sf}.
#' @return a coord_sf.
#' 
#' @importFrom ggplot2 coord_sf
#' @importFrom sf st_bbox
#' @export
#' 
plot_clip <- function(x, proj = proj_nzsf(), ...) {
  
  if ("bbox" %in% class(x)) {
    bbox <- x
    p <- coord_sf(xlim = bbox[c(1, 3)], ylim = bbox[c(2, 4)], ...)
  } else if (any(c("sf", "sfc", "stars") %in% class(x))) {
    bbox <- st_bbox(x)
    p <- coord_sf(xlim = bbox[c(1, 3)], ylim = bbox[c(2, 4)], ...)
  } else if (x %in% c("nz", "NZ", "new zealand", "New Zealand")) {
    bbox <- st_bbox(get_statistical_areas(area = "EEZ", proj = proj))
    p <- coord_sf(xlim = bbox[c(1, 3)], ylim = bbox[c(2, 4)], ...)
  }
  
  return(p)
}
