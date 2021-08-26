#' CCAMLR geometries
#' 
#' @param feature A Quota Managemetn Area (QMA). Can be EEZ, CRA, JMA.
#' @param proj The projection to use.
#' @param fill The projection to use.
#' @param colour The projection to use.
#' @param ... The projection to use.
#' @return New Zealands statistical areas as a \code{sf} object.
#' 
#' @seealso \code{\link{coord_ccamlr}}
#' 
#' @importFrom utils data
#' @importFrom rnaturalearth ne_countries
#' @importFrom stringr str_detect
#' @importFrom dplyr filter
#' @importFrom ggplot2 geom_sf
#' @importFrom sf st_transform
#' @export
#' @examples
#' ggplot() +
#'   geom_ccamlr(feature = "ssru") +
#'   geom_ccamlr(feature = "land", fill = "black") +
#'   coord_ccamlr()
#' 
geom_ccamlr <- function(feature = "ssru", 
                        proj = proj_ccamlr(), 
                        fill = NA, 
                        colour = "black", ...) {
  
  if (feature %in% c("ssru", "SSRU")) {
    x <- nzsf::ccamlr_ssru %>%
      st_transform(crs = proj) %>%
      filter(str_detect(.data$LongLabel, "88.1|88.2"))
    p <- geom_sf(data = x, fill = fill, colour = colour, ...)
  }
  
  if (feature %in% c("label")) {
    x <- nzsf::ccamlr_ssru %>%
      st_transform(crs = proj) %>%
      filter(str_detect(.data$LongLabel, "88.1|88.2"))
    p <- geom_sf_text(data = x, aes(label = .data$LongLabel), colour = colour, ...)
  }
  
  if (feature %in% c("statistical_area")) {
    x <- nzsf::ccamlr_statistical_areas %>%
      st_transform(crs = proj)
    p <- geom_sf(data = x, fill = fill, colour = colour, ...)
  }
  
  if (feature %in% c("mpa", "MPA")) {
    x <- nzsf::ccamlr_mpa %>%
      st_transform(crs = proj)
    p <- geom_sf(data = x, fill = fill, colour = colour, ...)
  }
  
  if (feature %in% c("land")) {
    x <- ne_countries(scale = "medium", returnclass = "sf") %>%
      st_transform(crs = proj)
    p <- geom_sf(data = x, fill = fill, colour = colour, ...)
  }
  
  if (feature %in% c("gebco", "GEBCO")) {
    x <- nzsf::gebco %>%
      st_as_stars() %>%
      st_transform(crs = proj)
    p <- geom_stars(data = x, ...)
  }
  
  return(p)
}


#' CCAMLR coord
#' 
#' @param proj The projection to use.
#' @param ... A Quota Managemetn Area (QMA). Can be EEZ, CRA, JMA.
#' @return New Zealands statistical areas as a \code{sf} object.
#' 
#' @seealso \code{\link{geom_ccamlr}}
#' 
#' @importFrom utils data
#' @importFrom dplyr filter
#' @importFrom ggplot2 coord_sf
#' @importFrom sf st_transform st_buffer st_bbox
#' @export
#' @examples
#' ggplot() +
#'   geom_ccamlr(feature = "ssru") +
#'   geom_ccamlr(feature = "land", fill = "black") +
#'   coord_ccamlr()
#' 
coord_ccamlr <- function(proj = proj_ccamlr(), ...) {
  
  bb <- nzsf::ccamlr_statistical_areas %>%
    st_transform(crs = proj) %>%
    filter(.data$LongLabel %in% c(88.1, 88.2)) %>%
    st_buffer(dist = 5e4) %>% 
    st_bbox()
  
  p <- coord_sf(xlim = bb[c(1, 3)], ylim = bb[c(2, 4)], expand = FALSE, ...)
  
  return(p)
}
