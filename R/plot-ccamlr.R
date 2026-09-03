#' CCAMLR geometries
#' 
#' @param feature A CCAMLR feature. Supported values are `ssru`, `label`,
#'   `statistical_area`, `mpa`, `land`, and `gebco`.
#' @param proj The projection to use.
#' @param fill The fill colour for vector features.
#' @param colour The line or text colour for vector features.
#' @param ... Other arguments passed to the selected ggplot2 geom.
#' @return A ggplot2 layer containing the selected CCAMLR feature.
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
#' 
geom_ccamlr <- function(feature = "ssru", 
                        proj = proj_ccamlr(), 
                        fill = NA, 
                        colour = "black", ...) {

  if (!is.character(feature) || length(feature) != 1L || is.na(feature)) {
    stop("`feature` must be a single, non-missing character value.", call. = FALSE)
  }
  if (!feature %in% c("ssru", "SSRU", "label", "statistical_area", "mpa", "MPA", "land", "gebco", "GEBCO")) {
    stop(
      sprintf("Unsupported `feature`: %s.", encodeString(feature, quote = "\"")),
      call. = FALSE
    )
  }
  
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
    x <- nzsf::gebco_CCAMLR %>%
      st_as_stars() %>%
      st_transform(crs = proj)
    p <- geom_stars(data = x, ...)
  }
  
  return(p)
}


#' CCAMLR coord
#' 
#' @param proj The projection to use.
#' @param ... Other arguments passed to \code{ggplot2::geom_sf()}.
#' @return A CCAMLR \code{ggplot2} layer.
#' 
#' @seealso \code{\link{geom_ccamlr}}
#' 
#' @importFrom utils data
#' @importFrom dplyr filter
#' @importFrom ggplot2 coord_sf
#' @importFrom sf st_transform st_buffer st_bbox
#' @export
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
