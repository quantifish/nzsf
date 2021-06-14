#' Get Fisheries New Zealand standard grid origin
#' 
#' @param cell_size square grid boundary length in km
#' @param bounding_box limits generated from call to sf::st_bbox()
#' @return standard grid origin \code{data.frame}
#'
#' @seealso \code{\link{get_standard_grid}}
#' @author Sophie Mormede
#' 
#' @export
#' 
get_standard_grid_origin <- function(cell_size, bounding_box) {
  
  cell_size_m <- cell_size * 1000
  
  bb_xmin <- as.numeric(bounding_box$xmin)
  bb_xmax <- as.numeric(bounding_box$xmax)
  bb_ymin <- as.numeric(bounding_box$ymin)
  bb_ymax <- as.numeric(bounding_box$ymax)
  
  x <- data.frame(grid_size_km = cell_size, 
                  grid_size_km2 = cell_size^2, 
                  n_x = ceiling((bb_xmax - bb_xmin) / cell_size_m),
                  n_y = ceiling((bb_ymax - bb_ymin) / cell_size_m),
                  xmin = -ceiling(-bb_xmin / cell_size_m) * cell_size_m, 
                  ymin = -floor((-bb_ymin + 422600) / cell_size_m) * cell_size_m - 422600)
  
  return(x)
}


#' Get Fisheries New Zealand standard grid definitions
#' 
#' @param cell_size square grid boundary length in km
#' @param bounding_box limits generated from call to sf::st_bbox()
#' @param clip_eez should the grid be clipped to the NZ EEZZ
#' @return New Zealands standard grid polygon as a \code{sf} object.
#'
#' @seealso \code{\link{get_standard_grid_origin}}
#' @author Sophie Mormede
#' 
#' @importFrom sf st_make_grid st_intersection
#' @export
#' 
get_standard_grid <- function(cell_size, bounding_box, clip_eez = TRUE) {
  
  grid_origin <- get_standard_grid_origin(cell_size, bounding_box)
  
  grids <- bounding_box %>% 
    st_make_grid(cellsize = as.numeric(grid_origin["grid_size_km"]) * 1000, 
                 offset = as.numeric(grid_origin[c("xmin", "ymin")]), 
                 crs = proj_nzsf())

  if (clip_eez) {
    eez <- get_statistical_areas(area = "EEZ", proj = proj_nzsf()) 
    
    grids <- grids %>% 
      st_intersection(eez)
  }
  
  return(grids)
}
