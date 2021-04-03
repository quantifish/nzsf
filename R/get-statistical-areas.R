#' Get Statistical Areas
#' 
#' @param area A Quota Managemetn Area (QMA). Can be EEZ, CRA, JMA.
#' @param proj The projection to use.
#' @return New Zealands statistical areas as a \code{sf} object.
#' 
#' @seealso \code{\link{plot_statistical_areas}}
#' 
#' @importFrom utils data
#' @importFrom dplyr filter
#' @importFrom sf st_transform st_union st_cast
#' @export
#' @examples
#' x <- get_statistical_areas(area = "CRA")
#' ggplot() +
#'   geom_sf(data = x, fill = NA)
#' 
get_statistical_areas <- function(area = "CRA", proj = proj_nzsf()) {

  if (area %in% c("statistical area", "statistical areas", "stat area", "stat areas")) {
    x <- nzsf::nz_general_statistical_areas
  }
  
  if (area %in% c("EEZ")) {
    # x <- nzsf::exclusive_economic_zone_outer_limits_200_mile
    x <- nzsf::FisheriesManagementAreas %>% 
      filter(.data$LayerName == "General FMAs") %>%
      st_union()
  }
  
  if (area %in% c("CRA")) {
    x <- nzsf::rock_lobster_stat_areas
  }
  
  if (area %in% c("FMA", "JMA")) {
    x <- nzsf::FisheriesManagementAreas %>% 
      filter(.data$LayerName == "General FMAs")
  }
  
  if (area %in% c("CCSBT")) {
    x <- nzsf::CCSBT
  }
  
  if (area %in% c("SIOFA")) {
    x <- nzsf::SIOFA
  }
  
  if (area %in% c("SPRFMO")) {
    x <- nzsf::SPRFMO
  }
  
  if (!is.null(proj)) {
    x <- x %>% 
      # st_transform(crs = proj, check = TRUE) %>% 
      st_transform(crs = proj) %>% 
      st_union(by_feature = TRUE)
    # if (!area %in% "EEZ") {
    #   x <- x %>% st_cast("MULTIPOLYGON")
    # }
  }
  
  return(x)
}


#' Get statistical areas
#' 
#' @inheritParams get_statistical_areas
#' @param ... Other arguments passed on to \code{geom_sf}.
#' @return A ggplot of the selected QMA.
#' 
#' @seealso \code{\link{get_statistical_areas}}
#' 
#' @importFrom ggplot2 geom_sf
#' @export
#' @examples
#' ggplot() + 
#'   plot_statistical_areas(area = "CRA")
#' 
plot_statistical_areas <- function(proj = proj_nzsf(), area = "CRA", ...) {
  x <- get_statistical_areas(area = area, proj = proj)
  p <- geom_sf(data = x, ...)
  return(p)
}
