#' Convert points to a raster
#' 
#' @param data a spatial feature data.
#' @param field the field to rasterize.
#' @param fun the function
#' @param nrow number of rows
#' @param ncol number of rows
#' @return a raster.
#' @importFrom raster raster rasterize
#' @importFrom sf st_sample st_sf
#' @importFrom dplyr mutate
#' @export
#' @examples
#' x <- get_qma("CRA")
#' pts <- st_sample(x, size = 1000) %>% 
#'   st_sf() %>% 
#'   mutate(z = rnorm(1:n()))
#' r <- get_points_as_raster(data = pts, field = "z")
#' 
get_points_as_raster <- function(data, field, fun = "sum", nrow = 100, ncol = 100) {
  r_empty <- raster(data, nrow = nrow, ncol = ncol)
  r <- rasterize(x = data, y = r_empty, field = field, fun = fun)
  return(r)
}


#' Convert points to a raster
#' 
#' @param data a spatial feature data.
#' @param field the field to rasterize.
#' @param fun the function
#' @param nrow number of rows
#' @param ncol number of rows
#' @param ... Other arguments passed on to \code{geom_raster}.
#' @return a ggplot.
#' @importFrom raster rasterToPoints
#' @importFrom ggplot2 geom_raster
#' @export
#' @examples
#' x <- get_qma("CRA")
#' pts <- st_sample(x, size = 1000) %>% 
#'   st_sf() %>% 
#'   mutate(z = rnorm(1:n()))
#' ggplot() +
#'   plot_raster(data = pts, field = "z")
#' 
plot_raster <- function(data, field, fun = "sum", nrow = 100, ncol = 100, ...) {
  r <- get_points_as_raster(data = data, field = field, fun = fun, nrow = nrow, ncol = ncol)
  df <- rasterToPoints(r) %>%
    data.frame() %>%
    mutate(layer = ifelse(layer == 0, NA, layer))
  p <- geom_raster(data = df, aes(x = x, y = y, fill = layer), ...)
  return(p)
}
