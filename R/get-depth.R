#' Lookup the depth (m) at specific locations around New Zealand
#' 
#' @param pts The points to generate a depth for.
#' @return Depth at each location.
#' 
#' @author Darcy Webber \email{darcy@quantifish.co.nz}
#' 
#' @export
#' 
lookup_depth <- function(pts) {
  
  x <- nzsf::NZBathymetry_2016_grid
  
  y <- pts %>%
    st_transform(crs = st_crs(x))
  
  z <- raster::extract(x = x, y = y)
  
  return(z)
}


#' Get depth polylines around New Zealand
#' 
#' @param proj The coordinate reference system to use: integer with the EPSG code, or character with \code{proj4string}.
#' @param resolution the resolution.
#' @param depths a vector of specific depths to filter. Depths (in metres) that are available include: 0, 2, 5, 10, 20, 30, 50, 100, 200, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, and 10000.
#' @return New Zealands depth polylines as a \code{sf} object.
#' 
#' @author Darcy Webber \email{darcy@quantifish.co.nz}
#' 
#' @seealso \code{\link{plot_depth}}
#' 
#' @importFrom dplyr filter
#' @importFrom utils data
#' @export
#' @examples
#' x <- get_depth(resolution = "low")
#' ggplot() +
#'   geom_sf(data = x, colour = "lightblue")
#' 
get_depth <- function(proj = proj_nzsf(), 
                      resolution = "low", 
                      depths = NULL) {
  
  if (resolution %in% c("high", "122k_190k")) {
    x <- nzsf::depth_contour_polyline_hydro_122k_190k
  } else if (resolution %in% c("med", "190k_1350k")) {
    x <- nzsf::depth_contour_polyline_hydro_190k_1350k
  } else {
    x <- nzsf::depth_contour_polyline_hydro_1350k_11500k
  }
  
  if (!is.null(depths)) x <- x %>% filter(.data$depth %in% depths)
  if (!is.null(proj)) x <- x %>% st_transform(crs = proj, check = TRUE)
  
  return(x)
}


#' Plot depth polylines around New Zealand
#' 
#' @inheritParams get_depth
#' @param col_depth Different colours for the depth contours.
#' @param lty_depth Different line types for the depth contours.
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
plot_depth <- function(proj = proj_nzsf(), 
                       resolution = "low", 
                       depths = NULL, 
                       col_depth = FALSE, 
                       lty_depth = FALSE, ...) {
  
  x <- get_depth(proj = proj, resolution = resolution, depths = depths)
  
  if (col_depth & lty_depth) {
    p <- geom_sf(data = x, aes(colour = factor(.data$depth), linetype = factor(.data$depth)), ...)
  } else if (col_depth & !lty_depth) {
    p <- geom_sf(data = x, aes(colour = factor(.data$depth)), ...)
  } else if (!col_depth & lty_depth) {
    p <- geom_sf(data = x, aes(linetype = factor(.data$depth)), ...)
  } else {
    p <- geom_sf(data = x, ...)
  }
  
  return(p)
}


#' Plot GEBCO depth raster
#' 
#' @param proj Projection.
#' @param downsample Downsampling rate: e.g. 3 keeps rows and cols 1, 4, 7, 10 etc.; a value of 0 does not downsample; can be specified for each dimension, e.g. c(5,5,0) to downsample the first two dimensions but not the third.
#' @param ... Other arguments passed on to \code{geom_sf}.
#' @return A \code{ggplot} object of New Zealands depth polylines.
#' 
#' @author Darcy Webber \email{darcy@quantifish.co.nz}
#' 
#' @seealso \code{\link{get_depth}}
#' 
#' @importFrom sf st_transform
#' @importFrom stars st_as_stars geom_stars
#' @export
#' @examples
#' ggplot() + 
#'   geom_gebco()
#' 
geom_gebco <- function(proj = proj_nzsf(), 
                       downsample = 3, ...) {
  
  # x <- nzsf::gebco %>%
  x <- nzsf::gebco_NZ %>%
    st_as_stars() %>%
    st_transform(crs = proj)
  
  p <- geom_stars(data = x, downsample = downsample, ...)
  
  return(p)
}
