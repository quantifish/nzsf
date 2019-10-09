#' Get Marine Reserves.
#' 
#' @return New Zealands marine reserves.
#' @export
#' @examples
#' get_marine_reserves()
#' 
get_marine_reserves <- function() {
  data("doc_marine_reserves")
  x <- doc_marine_reserves
  return(x)
}

#' Plot Marine Reserves.
#' 
#' @return ggplot of New Zealand's marine reserves.
#' @export
#' @examples
#' plot_marine_reserves()
#' 
plot_marine_reserves <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", ...) {
  x <- get_marine_reserves() %>% st_transform(crs = proj, check = TRUE)
  geom_sf(data = x, ...)
}
