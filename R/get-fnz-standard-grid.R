#' Get Fisheries New Zealand standard grid origin
#' 
#' @param cell_size square grid boundary length in km
#' @param bounding_box limits generated from call to sf::st_bbox()
#' @return standard grid origin \code{data.frame}
#'
#' @seealso \code{\link{get_standard_grid}}
#' @author Sophie Mormede, Darcy Webber
#' @export
#' 
get_standard_grid_origin <- function(cell_size, bounding_box) {
  
  cell_size_m <- cell_size * 1000
  
  bb_xmin <- as.numeric(bounding_box$xmin)
  bb_ymin <- as.numeric(bounding_box$ymin)
  
  x <- data.frame(cell_size_m = cell_size_m,
                  grid_size_km = cell_size, 
                  grid_size_km2 = cell_size^2, 
                  xmin = -ceiling(-bb_xmin / cell_size_m) * cell_size_m, 
                  ymin = -floor((-bb_ymin + 422600) / cell_size_m) * cell_size_m - 422600)
  
  return(x)
}


#' Get Fisheries New Zealand standard grid definitions
#' 
#' @inheritParams get_standard_grid_origin
#' @param return_raster return a raster or polygons
#' @return New Zealands standard grid polygon as a \code{sf} object.
#'
#' @seealso \code{\link{get_standard_grid_origin}}
#' @author Darcy Webber
#' 
#' @importFrom sf st_make_grid st_join st_as_sf st_as_sfc
#' @importFrom raster extent crs
#' @export
#' 
get_standard_grid <- function(cell_size, bounding_box, return_raster = TRUE) {
  
  grid_origin <- get_standard_grid_origin(cell_size, bounding_box)
  
  grids <- bounding_box %>% 
    st_make_grid(cellsize = as.numeric(grid_origin["grid_size_km"]) * 1000, 
                 offset = as.numeric(grid_origin[c("xmin", "ymin")]), 
                 crs = proj_nzsf()) %>%
    st_as_sf()

  bb <- bounding_box %>% 
    st_as_sfc() %>%
    st_as_sf()

  grids <- st_join(grids, bb, left = FALSE)
  
  if (return_raster) {
    cell_size_m <- grid_origin$cell_size_m
    bb <- st_bbox(grids)
    ncols <- (as.numeric(bb[3]) - as.numeric(bb[1])) / cell_size_m
    nrows <- (as.numeric(bb[4]) - as.numeric(bb[2])) / cell_size_m
    
    polys <- grids %>% as_Spatial()
    
    grids <- raster(nrow = nrows, ncol = ncols, ext = extent(polys), crs = crs(polys))
  }
  
  return(grids)
}
