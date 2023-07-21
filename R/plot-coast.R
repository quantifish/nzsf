#' Get the New Zealand coastline
#' 
#' @param proj The coordinate reference system to use: integer with the EPSG code, or character with \code{proj4string}.
#' @param resolution the resolution, choose from "10", "50". "110", "150", "1250", "1500".
#' @param keep proportion of points to retain (0-1; default 1).
#' @return New Zealands coastline as a \code{sf} object.
#' 
#' @seealso \code{\link{plot_coast}}
#' 
#' @importFrom utils data
#' @importFrom rmapshaper ms_simplify
#' @importFrom rnaturalearth ne_countries
#' @import sf
#' @export
#' 
get_coast <- function(proj = proj_nzsf(), 
                      resolution = "medium", 
                      keep = 1) {
  
  if (resolution %in% c("large", "high", "10")) {
    x <- ne_countries(scale = "large", returnclass = "sf")
  } else if (resolution %in% c("m", "med", "medium", "50")) {
    x <- ne_countries(scale = "medium", returnclass = "sf")
  } else if (resolution %in% c("small", "low", "110")) {
    x <- ne_countries(scale = "small", returnclass = "sf")
  } else if (resolution %in% c("150k", "150")) {
    x <- nzsf::nz_coastlines_and_islands_polygons_topo_150k
  } else if (resolution %in% c("1250k", "1250")) {
    x <- nzsf::nz_coastlines_and_islands_polygons_topo_1250k
  } else if (resolution %in% c("1500k", "1500")) {
    x <- nzsf::nz_coastlines_and_islands_polygons_topo_1500k
  }
  
  if (keep < 1) x <- x %>% ms_simplify(keep = keep, keep_shapes = FALSE)
  
  if (!is.null(proj)) x <- x %>% st_transform(crs = proj, check = TRUE)
  
  return(x)
}


#' Plot the New Zealand coastline.
#' 
#' @inheritParams get_coast
#' @param rivers Plot rivers over land as \code{geom_sf}.
#' @param ... Other arguments passed on to \code{geom_sf}.
#' @return ggplot of New Zealands coastline.
#' 
#' @seealso \code{\link{get_coast}}
#' 
#' @import ggplot2
#' @importFrom sf st_transform
#' @export
#' 
plot_coast <- function(proj = proj_nzsf(), 
                       resolution = "medium", 
                       keep = 1,
                       rivers = FALSE, ...) {
  
  x <- get_coast(proj = proj, resolution = resolution, keep = keep)
  
  if (rivers) {
    p <- list(geom_sf(data = x, ...), plot_rivers(proj = proj))
  } else {
    p <- geom_sf(data = x, ...)
  }
  
  return(p)
}
