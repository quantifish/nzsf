#' Get Marine Reserves
#' 
#' @param proj The projection to use.
#' @return New Zealands marine reserves.
#' @keywords reserve
#' @importFrom utils data
#' @export
#' @examples
#' get_marine_reserves()
#' 
get_marine_reserves <- function(proj = proj_nzsf()) {
  x <- nzsf::doc_marine_reserves
  if (!is.null(proj)) x <- x %>% st_transform(crs = proj, check = TRUE)
  return(x)
}


#' Plot Marine Reserves
#' 
#' @inheritParams get_marine_reserves
#' @param ... Other arguments passed on to \code{geom_sf}.
#' @return ggplot of New Zealand's marine reserves.
#' @importFrom ggplot2 geom_sf
#' @importFrom sf st_transform
#' @export
#' @examples
#' ggplot() +
#'   plot_marine_reserves()
#' 
plot_marine_reserves <- function(proj = proj_nzsf(), ...) {
  x <- get_marine_reserves()
  p <- geom_sf(data = x, ...)
  return(p)
}
