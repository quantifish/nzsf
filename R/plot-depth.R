#' Look up GEBCO elevation at specific locations around New Zealand
#' 
#' @param pts An sf or sfc object containing point geometries.
#' @return GEBCO elevation, in metres, at each location. Ocean depths are
#'   returned as negative elevations.
#' 
#' @author Darcy Webber \email{darcy@quantifish.co.nz}
#' 
#' @export
#' 
lookup_depth <- function(pts) {
  if (!inherits(pts, c("sf", "sfc"))) {
    stop("`pts` must be an `sf` or `sfc` object.", call. = FALSE)
  }
  if (is.na(sf::st_crs(pts))) {
    stop("`pts` must have a coordinate reference system.", call. = FALSE)
  }
  if (length(sf::st_geometry(pts)) > 0L &&
      any(sf::st_geometry_type(pts) != "POINT")) {
    stop("`pts` must contain only point geometries.", call. = FALSE)
  }

  x <- nzsf::gebco_NZ
  y <- sf::st_transform(pts, crs = raster::crs(x))
  z <- raster::extract(x = x, y = methods::as(y, "Spatial"))
  
  return(z)
}


#' Get depth polylines around New Zealand
#' 
#' @param proj The coordinate reference system to use: integer with the EPSG code, or character with \code{proj4string}.
#' @param resolution the resolution.
#' @param depths a vector of specific depths to filter. Depths (in metres) that are available include: 0, 2, 5, 10, 20, 30, 50, 100, 200, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, and 10000.
#' @return New Zealand's depth polylines as an \code{sf} object.
#' 
#' @author Darcy Webber \email{darcy@quantifish.co.nz}
#' 
#' @seealso \code{\link{plot_depth}}
#' 
#' @importFrom dplyr filter
#' @importFrom utils data
#' @export
#' 
get_depth <- function(proj = proj_nzsf(), 
                      resolution = "low", 
                      depths = NULL) {
  
  if (!is.character(resolution) || length(resolution) != 1L ||
      is.na(resolution)) {
    stop("`resolution` must be a single, non-missing character value.",
         call. = FALSE)
  }

  if (resolution %in% c("high", "122k_190k")) {
    x <- nzsf::depth_contour_polyline_hydro_122k_190k
  } else if (resolution %in% c("med", "medium", "190k_1350k")) {
    x <- nzsf::depth_contour_polyline_hydro_190k_1350k
  } else if (resolution %in% c("low", "small", "1350k_11500k")) {
    x <- nzsf::depth_contour_polyline_hydro_1350k_11500k
  } else {
    stop(
      sprintf("Unsupported `resolution`: %s.", encodeString(resolution, quote = "\"")),
      call. = FALSE
    )
  }
  
  if (!is.null(depths)) x <- x %>% filter(.data$depth %in% depths)
  if (!is.null(proj)) x <- x %>% st_transform(crs = proj)
  
  return(x)
}


#' Plot depth polylines around New Zealand
#' 
#' @inheritParams get_depth
#' @param col_depth Different colours for the depth contours.
#' @param lty_depth Different line types for the depth contours.
#' @param ... Other arguments passed on to \code{geom_sf}.
#' @return A \code{ggplot} object of New Zealand's depth polylines.
#' 
#' @author Darcy Webber \email{darcy@quantifish.co.nz}
#' 
#' @seealso \code{\link{get_depth}}
#' 
#' @importFrom ggplot2 geom_sf
#' @importFrom sf st_transform
#' @export
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
#' @return A \code{ggplot} object of New Zealand's depth raster.
#' 
#' @author Darcy Webber \email{darcy@quantifish.co.nz}
#' 
#' @seealso \code{\link{get_depth}}
#' 
#' @importFrom sf st_transform
#' @importFrom stars st_as_stars geom_stars
#' @export
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
