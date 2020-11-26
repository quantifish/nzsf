#' CCSBT geometry
#' 
#' A helper function for obtaining a CCSBT related feature and returning a \code{geom_sf} object of that feature. Feature include the CCSBT 
#' management areas, labels or land. By default the projection returned by the function \code{proj_ccsbt} is used.
#' 
#' @param feature A CCSBT feature such as a management area, label or land.
#' @param proj The projection to use.
#' @param fill The fill colour for the selected feature.
#' @param colour The colour for the seleceted feature.
#' @param ... Any additional arguments passed to \code{geom_sf}.
#' @return A \code{geom_sf} object.
#' 
#' @seealso \code{\link{coord_ccsbt}} for coord and \code{\link{proj_ccsbt}} for projection.
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
      st_transform(crs = proj)
    # Two of these areas were split at the 180 line and needed to be combined
    x[9,] <- x[9,] %>%
      st_buffer(dist = 1e-9) %>%
      st_cast(to = "POLYGON") %>%
      st_union(by_feature = TRUE)
    x[10,] <- x[10,] %>%
      st_buffer(dist = 1e-9) %>%
      st_cast(to = "POLYGON") %>%
      st_union(by_feature = TRUE)
    p <- geom_sf(data = x, fill = fill, colour = colour, ...)
  }
  
  if (feature %in% c("label")) {
    x <- nzsf::CCSBT %>% 
      st_transform(crs = proj)
    # Two of these areas were split at the 180 line and needed to be combined
    x[9,] <- x[9,] %>%
      st_buffer(dist = 1e-9) %>%
      st_cast(to = "POLYGON") %>%
      st_union(by_feature = TRUE)
    x[10,] <- x[10,] %>%
      st_buffer(dist = 1e-9) %>%
      st_cast(to = "POLYGON") %>%
      st_union(by_feature = TRUE)
    x <- x %>%
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
#' @param ... Any additional arguments passed to \code{coord_sf}.
#' @return A \code{geom_coord} object.
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
