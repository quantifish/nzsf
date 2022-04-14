#' Get Fisheries New Zealand standard grid origin
#' 
#' @param cell_size square grid boundary length in km
#' @param bounding_box limits generated from call to sf::st_bbox()
#' @param anchor the point to anchor the grid to
#' @return standard grid origin \code{data.frame}
#'
#' @seealso \code{\link{get_standard_grid}}
#' @author Darcy Webber, Sophie Mormede, Charles Edwards
#' @export
#' 
get_standard_grid_origin <- function(cell_size, bounding_box, anchor = c(0, 422600)) {
  
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
                  xmin = -ceiling((-bb_xmin - anchor[1]) / cell_size_m) * cell_size_m - anchor[1],
                  xmax = -floor((-(bb_xmax + anchor[1])) / cell_size_m) * cell_size_m - anchor[1],
                  ymin = -ceiling((-bb_ymin - anchor[2]) / cell_size_m) * cell_size_m - anchor[2],
                  ymax = -floor((-(bb_ymax + anchor[2])) / cell_size_m) * cell_size_m - anchor[2])

  return(x)
}


#' Get Fisheries New Zealand standard grid definitions
#' 
#' @inheritParams get_standard_grid_origin
#' @param return_raster return a raster or polygons
#' @return New Zealand's standard grid polygon as a \code{sf} object or as a raster.
#'
#' @seealso \code{\link{get_standard_grid_origin}}
#' @author Darcy Webber, Sophie Mormede, Charles Edwards
#' 
#' @importFrom sf st_make_grid st_join st_as_sf st_as_sfc
#' @importFrom raster extent crs
#' @export
#' 
get_standard_grid <- function(cell_size, bounding_box, anchor = c(0, 422600), return_raster = TRUE) {
  
  grid_origin <- get_standard_grid_origin(cell_size = cell_size, bounding_box = bounding_box, anchor = anchor)
  
  if (return_raster) {
    grids <- raster(crs = proj_nzsf(), 
                    xmn = grid_origin$xmin, 
                    ymn = grid_origin$ymin, 
                    xmx = grid_origin$xmax, 
                    ymx = grid_origin$ymax, 
                    res = grid_origin$cell_size_m)
  } else {
    grids <- bounding_box %>% 
      st_make_grid(cellsize = as.numeric(grid_origin["grid_size_km"]) * 1000, 
                   offset = as.numeric(grid_origin[c("xmin", "ymin")]), 
                   crs = proj_nzsf()) %>%
      st_as_sf()
  }
  
  return(grids)
}
