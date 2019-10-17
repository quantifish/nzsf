#' Get Statistical Areas
#' 
#' @param area A Quota Managemetn Area (QMA)
#' @param proj The projection to use.
#' @return A FMA.
#' @importFrom utils data
#' @importFrom dplyr filter
#' @importFrom sf st_transform st_union st_cast
#' @export
#' @examples
#' x <- get_statistical_areas(area = "CRA")
#' ggplot() +
#'   geom_sf(data = x, fill = NA)
#' 
get_statistical_areas <- function(area = "CRA",
                                  proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs") {

  if (area %in% c("EEZ")) {
    data("exclusive_economic_zone_outer_limits_200_mile")
    x <- exclusive_economic_zone_outer_limits_200_mile
  }
  if (area %in% c("CRA")) {
    data("rock_lobster_stat_areas")
    x <- rock_lobster_stat_areas
  }
  if (area %in% c("JMA")) {
    data("FisheriesManagementAreas")
    x <- FisheriesManagementAreas %>% filter(LayerName == "General FMAs")
  }
  
  if (!is.null(proj)) {
    x <- x %>% 
      st_transform(crs = proj, check = TRUE) %>% 
      st_union(by_feature = TRUE)
    if (!area %in% "EEZ") {
      x <- x %>% st_cast("MULTIPOLYGON")
    }
  }
  
  return(x)
}


#' Get statistical areas
#' 
#' @inheritParams get_statistical_areas
#' @param ... Other arguments passed on to \code{geom_sf}.
#' @return A ggplot of the selected QMA.
#' @importFrom ggplot2 geom_sf
#' @export
#' @examples
#' ggplot() + 
#'   plot_statistical_areas(area = "CRA")
#' 
plot_statistical_areas <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", 
                                   area = "CRA", ...) {
  x <- get_statistical_areas(area = area, proj = proj)
  p <- geom_sf(data = x, ...)
  return(p)
}
