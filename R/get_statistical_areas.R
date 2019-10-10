#' Get Statistical Areas.
#' 
#' @param qma A Quota Managemetn Area (QMA)
#' @return A QMA.
#' @export
#' @examples
#' get_statistical_areas(area = "CRA")
#' 
get_statistical_areas <- function(area = "CRA") {
  if (area %in% c("CRA")) {
    data("rock_lobster_stat_areas")
    x <- rock_lobster_stat_areas
  }
  return(x)
}

#' Get a Quota Managemetn Area.
#' 
#' @param area A Quota Managemetn Area (QMA)
#' @param proj The projection to use.
#' @return A ggplot of the selected QMA.
#' @export
#' @examples
#' ggplot() + 
#'   plot_statistical_areas(area = "CRA")
#' 
plot_statistical_areas <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", 
                                   area = "CRA", ...) {
  x <- get_statistical_areas(area = area) %>% st_transform(crs = proj, check = TRUE)
  geom_sf(data = x, ...)
}