#' Get Fisheries New Zealand standard grid definitions
#' 
#' @param x square grid boundary length in km
#' @param bounding_box limits generated from call to sf::st_bbox()
#'
#' @include get-statistical-areas.R projection.R
#'
#' @author Sophie Mormede
#' 
#' @export
#' 
get_standard_grid_origin <- function(x, bounding_box) {
  
  bb_xmin <- as.numeric(bounding_box$xmin)
  bb_ymin <- as.numeric(bounding_box$ymin)
  
  data.frame("grid_size_km" = x, "grid_size_km2" = x^2, "xmin" = -ceiling(-bb_xmin / (x * 1000)) * (x * 1000), "ymin" = -floor((-bb_ymin + 422600) / (x * 1000)) * (x * 1000) - 422600)  
}
#' @export
#' 
get_standard_grid <- function(x, bounding_box, clip_eez = TRUE) {
  
  grid_origin <- get_standard_grid_origin(x, bounding_box)
  
  grids <- bounding_box %>% sf::st_make_grid(cellsize = as.numeric(grid_origin["grid_size_km"])*1000, offset = as.numeric(grid_origin[c("xmin", "ymin")]), crs = proj_nzsf())

  if (clip_eez) {
    
    eez <- get_statistical_areas(area = "EEZ", proj = proj_nzsf()) 
    
    grids <- grids %>% sf::st_intersection(eez)
  }
  
  return(grids)
}


