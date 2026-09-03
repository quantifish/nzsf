#' Get Statistical Areas
#' 
#' @param area A fisheries area. Supported values include EEZ, CRA, FMA, JMA,
#'   statistical areas, CCSBT, SIOFA, and SPRFMO.
#' @param proj The projection to use.
#' @return New Zealand's statistical areas as an \code{sf} object.
#' 
#' @seealso \code{\link{plot_statistical_areas}}
#' 
#' @importFrom utils data
#' @importFrom dplyr filter
#' @importFrom sf st_transform st_union st_cast st_make_valid
#' @export
#' @examples
#' x <- get_statistical_areas(area = "CRA")
#' ggplot2::ggplot() +
#'   ggplot2::geom_sf(data = x, fill = NA)
#' 
get_statistical_areas <- function(area = "CRA", proj = proj_nzsf()) {

  if (!is.character(area) || length(area) != 1L || is.na(area)) {
    stop("`area` must be a single, non-missing character value.", call. = FALSE)
  }

  x <- NULL

  if (area %in% c("statistical area", "statistical areas", "stat area", "stat areas")) {
    x <- nzsf::nz_general_statistical_areas
  }
  
  if (area %in% c("EEZ")) {
    # x <- nzsf::exclusive_economic_zone_outer_limits_200_mile
    geometry <- nzsf::FisheriesManagementAreas %>%
      filter(.data$LayerName == "General FMAs") %>%
      st_make_valid() %>%
      st_union()
    x <- sf::st_sf(area = "EEZ", geometry = geometry)
  }
  
  if (area %in% c("CRA")) {
    x <- nzsf::rock_lobster_stat_areas
  }
  
  if (area %in% c("FMA")) {
    x <- nzsf::FisheriesManagementAreas %>% 
      filter(.data$LayerName == "General FMAs") %>%
      st_make_valid()
  }

  if (area %in% c("JMA")) {
    x <- nzsf::nz_general_statistical_areas
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

  if (is.null(x)) {
    stop(
      sprintf("Unsupported `area`: %s.", encodeString(area, quote = "\"")),
      call. = FALSE
    )
  }
  
  if (!is.null(proj)) {
    x <- x %>%
      st_transform(crs = proj) %>%
      st_make_valid()
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
#' ggplot2::ggplot() +
#'   plot_statistical_areas(area = "CRA")
#' 
plot_statistical_areas <- function(proj = proj_nzsf(), 
                                   area = "CRA", ...) {
  
  x <- get_statistical_areas(area = area, proj = proj)
  
  p <- geom_sf(data = x, ...)
  
  return(p)
}
