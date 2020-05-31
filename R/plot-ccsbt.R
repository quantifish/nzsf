#' CCSBT geometry
#' 
#' @param feature A Quota Managemetn Area (QMA). Can be EEZ, CRA, JMA.
#' @param proj The projection to use.
#' @param fill The projection to use.
#' @param colour The projection to use.
#' @param ... The projection to use.
#' @return New Zealands statistical areas as a \code{sf} object.
#' 
#' @seealso \code{\link{coord_ccsbt}}
#' 
#' @importFrom utils data
#' @importFrom rnaturalearth ne_countries
#' @importFrom ggplot2 geom_sf
#' @importFrom sf st_transform st_union st_centroid
#' @export
#' @examples
#' ggplot() +
#'   geom_ccsbt(feature = "area") +
#'   geom_ccsbt(feature = "land", fill = "black") +
#'   coord_ccsbt()
#' 
geom_ccsbt <- function(feature = "area", proj = proj_ccsbt(), fill = NA, colour = "black", ...) {
  if (feature %in% c("Area", "area")) {
    x <- nzsf::CCSBT %>% 
      st_transform(crs = proj) %>%
      st_union(by_feature = TRUE)
    p <- geom_sf(data = x, fill = fill, colour = colour, ...)
  }
  if (feature %in% c("label")) {
    x <- nzsf::CCSBT %>% 
      st_transform(crs = proj) %>%
      st_centroid()
    p <- geom_sf_label(data = x, aes(label = .data$Area), fill = fill, colour = colour, ...)
  }
  if (feature %in% c("land")) {
    x <- ne_countries(scale = "medium", returnclass = "sf") %>%
      st_transform(crs = proj)
    p <- geom_sf(data = x, fill = fill, colour = colour, ...)
  }
  return(p)
}


#' CCSBT coord
#' 
#' @param proj The projection to use.
#' @param ... A Quota Managemetn Area (QMA). Can be EEZ, CRA, JMA.
#' @return New Zealands statistical areas as a \code{sf} object.
#' 
#' @seealso \code{\link{geom_ccsbt}}
#' 
#' @importFrom utils data
#' @importFrom ggplot2 coord_sf
#' @importFrom sf st_transform st_buffer st_bbox
#' @export
#' @examples
#' ggplot() +
#'   geom_ccsbt(feature = "area") +
#'   geom_ccsbt(feature = "land", fill = "black") +
#'   coord_ccsbt()
#' 
coord_ccsbt <- function(proj = proj_ccsbt(), ...) {
  bb <- nzsf::CCSBT %>% 
    st_transform(crs = proj) %>%
    st_buffer(dist = 1e5) %>% 
    st_bbox()
  p <- coord_sf(xlim = bb[c(1, 3)], ylim = bb[c(2, 4)], expand = FALSE, ...)
  return(p)
}
