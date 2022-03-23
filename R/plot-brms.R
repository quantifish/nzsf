#' Plot a conditional_smooths output
#' 
#' @inheritParams brms::conditional_smooths
#' @param crs1 The CRS of the coordinates in the model.
#' @param crs2 The desired output CRS.
#' @param ... Other arguments passed on to \code{conditional_smooths}.
#' @return a \code{data.frame}.
#' @importFrom brms conditional_smooths
#' @import dplyr
#' @export
#' 
get_conditional_smooths <- function(x, resolution = 100, smooths = NULL, crs1 = st_crs(4326), crs2 = proj_nzsf(), ...) {
  df <- conditional_smooths(x = x, resolution = resolution, smooths = smooths, ...)[[1]] %>%
    rename(x = 1, y = 2) %>%
    st_as_sf(coords = c("x", "y"), crs = crs1) %>%
    st_transform(crs = crs2)
  return(df)
}


#' Plot a conditional_smooths output
#' 
#' @inheritParams get_conditional_smooths
#' @param ... Other arguments passed on to \code{plot_raster}.
#' @return a ggplot.
#' @importFrom brms conditional_smooths
#' @import ggplot2
#' @export
#' 
plot_conditional_smooths <- function(x, resolution = 100, smooths = NULL, crs1 = st_crs(4326), crs2 = proj_nzsf(), ...) {
  df <- get_conditional_smooths(x = x, resolution = resolution, smooths = smooths, crs1 = crs1, crs2 = crs2)
  p <- plot_raster(data = df, field = "estimate__", fun = mean, nrow = resolution, ncol = resolution, ...)
  return(p)
}
