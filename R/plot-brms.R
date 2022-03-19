#' Plot a conditional_smooths output
#' 
#' @inheritParams brms::conditional_smooths
#' @param ... Other arguments passed on to \code{conditional_smooths}.
#' @return a ggplot.
#' @importFrom brms conditional_smooths
#' @import ggplot2
#' @export
#' 
plot_conditional_smooths <- function(x, resolution = 100, smooths = NULL, ...) {
  df <- conditional_smooths(x = x, resolution = resolution, smooths = smooths, ...)[[1]]
  p <- geom_raster(data = df, aes(x = .data$x, y = .data$y, fill = .data$estimate__))
  return(p)
}
