#' Get Fisheries New Zealand standard grid origin
#' 
#' @param cell_size square grid boundary length in km
#' @param bounding_box limits generated from call to \code{sf::st_bbox()}
#' @param anchor projected coordinates, in metres, used to anchor a shared grid
#'   cell corner. The default is the EPSG:9191 origin at 175 degrees E,
#'   40 degrees S.
#' @return standard grid origin \code{data.frame}
#'
#' @seealso \code{\link{get_standard_grid}}
#' @author Darcy Webber, Sophie Mormede, Charles Edwards
#' @export
#' 
get_standard_grid_origin <- function(cell_size, bounding_box, anchor = c(0, 0)) {
  validate_cell_size(cell_size)
  validate_anchor(anchor)
  validate_projected_bbox(bounding_box)

  cell_size_m <- cell_size * 1000
  
  stnd_cell_size_m <- c(250, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000, 256000, 512000, 1024000)
  
  if (!cell_size_m %in% stnd_cell_size_m) {
    warning(paste0("The chosen grid size does not conform to the standard grid specification, consider setting cell_size to one of: ", paste(stnd_cell_size_m / 1000, collapse = ", "), "."))
  }

  bb_xmin <- as.numeric(bounding_box$xmin)
  bb_xmax <- as.numeric(bounding_box$xmax)
  bb_ymin <- as.numeric(bounding_box$ymin)
  bb_ymax <- as.numeric(bounding_box$ymax)
  
  x <- data.frame(cell_size_m = cell_size_m,
                  cell_size_m2 = cell_size_m^2,
                  grid_size_km = cell_size, 
                  grid_size_km2 = cell_size^2, 
                  xmin = floor((bb_xmin - anchor[1]) / cell_size_m) * cell_size_m + anchor[1],
                  xmax = ceiling((bb_xmax - anchor[1]) / cell_size_m) * cell_size_m + anchor[1],
                  ymin = floor((bb_ymin - anchor[2]) / cell_size_m) * cell_size_m + anchor[2],
                  ymax = ceiling((bb_ymax - anchor[2]) / cell_size_m) * cell_size_m + anchor[2])

  return(x)
}


#' Get Fisheries New Zealand standard grid definitions
#' 
#' @inheritParams get_standard_grid_origin
#' @param return_raster return a raster or polygons
#' @param crs the CRS to use
#' @param square logical; if FALSE, create hexagonal grid
#' @return New Zealand's standard grid polygon as a \code{sf} object or as a raster.
#'
#' @seealso \code{\link{get_standard_grid_origin}}
#' @author Darcy Webber, Sophie Mormede, Charles Edwards
#' 
#' @importFrom sf st_make_grid st_join st_as_sf st_as_sfc
#' @importFrom raster extent crs
#' @importFrom methods is
#' @export
#' 
get_standard_grid <- function(cell_size, bounding_box, anchor = c(0, 0),
                              return_raster = TRUE, crs = proj_nzsf(), square = TRUE) {

  validate_flag(return_raster, "return_raster")
  validate_flag(square, "square")
  validate_bbox(bounding_box)
  target_crs <- validate_projected_crs(crs)

  projected_box <- bounding_box
  if (sf::st_crs(bounding_box) != target_crs) {
    projected_box <- bounding_box %>%
      sf::st_as_sfc() %>%
      sf::st_transform(crs = target_crs) %>%
      sf::st_bbox()
  }

  grid_origin <- get_standard_grid_origin(cell_size = cell_size, 
                                          bounding_box = projected_box,
                                          anchor = anchor)
  
  if (return_raster) {
    grids <- raster(crs = target_crs$wkt,
                    xmn = grid_origin$xmin, 
                    ymn = grid_origin$ymin, 
                    xmx = grid_origin$xmax, 
                    ymx = grid_origin$ymax, 
                    res = grid_origin$cell_size_m)
  } else {
    grids <- projected_box %>%
      st_make_grid(cellsize = as.numeric(grid_origin["grid_size_km"]) * 1000, 
                   offset = as.numeric(grid_origin[c("xmin", "ymin")]), 
                   what = "polygons",
                   square = square,
                   crs = target_crs) %>%
      st_as_sf()
  }
  
  return(grids)
}


validate_cell_size <- function(cell_size) {
  if (!is.numeric(cell_size) || length(cell_size) != 1L ||
      is.na(cell_size) || !is.finite(cell_size) || cell_size <= 0) {
    stop("`cell_size` must be a single, finite, positive number in kilometres.",
         call. = FALSE)
  }
  invisible(cell_size)
}


validate_anchor <- function(anchor) {
  if (!is.numeric(anchor) || length(anchor) != 2L ||
      anyNA(anchor) || any(!is.finite(anchor))) {
    stop("`anchor` must contain two finite projected coordinates in metres.",
         call. = FALSE)
  }
  invisible(anchor)
}


validate_flag <- function(x, name) {
  if (!is.logical(x) || length(x) != 1L || is.na(x)) {
    stop(sprintf("`%s` must be TRUE or FALSE.", name), call. = FALSE)
  }
  invisible(x)
}


validate_bbox <- function(bounding_box) {
  if (!methods::is(bounding_box, "bbox")) {
    stop("`bounding_box` must be an object returned by `sf::st_bbox()`.",
         call. = FALSE)
  }
  extent <- unname(as.numeric(bounding_box))
  if (length(extent) != 4L || anyNA(extent) || any(!is.finite(extent)) ||
      extent[1] >= extent[3] || extent[2] >= extent[4]) {
    stop("`bounding_box` must have finite, ordered xmin, ymin, xmax, and ymax values.",
         call. = FALSE)
  }
  if (is.na(sf::st_crs(bounding_box))) {
    stop("`bounding_box` must have a coordinate reference system.", call. = FALSE)
  }
  invisible(bounding_box)
}


validate_projected_crs <- function(crs) {
  x <- tryCatch(sf::st_crs(crs), error = function(e) NA)
  if (!inherits(x, "crs") || is.na(x)) {
    stop("`crs` must identify a valid coordinate reference system.", call. = FALSE)
  }
  if (isTRUE(sf::st_is_longlat(x))) {
    stop("`crs` must be projected; grid dimensions are specified in metres.",
         call. = FALSE)
  }
  units <- tolower(x$units_gdal)
  if (length(units) != 1L || is.na(units) ||
      !units %in% c("metre", "metres", "meter", "meters", "m")) {
    stop("`crs` must use metres as its linear unit.", call. = FALSE)
  }
  x
}


validate_projected_bbox <- function(bounding_box) {
  validate_bbox(bounding_box)
  validate_projected_crs(sf::st_crs(bounding_box))
  invisible(bounding_box)
}
