#' Get Statistical Areas.
#' 
#' @param qma A Quota Managemetn Area (QMA)
#' @param proj The projection to use.
#' @return A FMA.
#' @export
#' @examples
#' x <- get_statistical_areas(area = "CRA")
#' ggplot() +
#'   geom_sf(data = x, fill = NA)
#' 
get_statistical_areas <- function(area = "CRA",
                                  proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs") {
  if (area %in% c("CRA")) {
    data("rock_lobster_stat_areas")
    sf_x <- rock_lobster_stat_areas
  }
  if (area %in% c("JMA")) {
    data("FisheriesManagementAreas")
    sf_x <- FisheriesManagementAreas %>% filter(LayerName == "General FMAs")
  }
  
  if (is.null(proj)) {
    sf_x
  } else {
    sf_x %>% 
      st_transform(crs = proj, check = TRUE) %>% 
      st_union(by_feature = TRUE) %>%
      st_cast("MULTIPOLYGON")
  }
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
  x <- get_statistical_areas(area = area, proj = proj)
  geom_sf(data = x, ...)
}
