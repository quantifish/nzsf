#' Clip to a shapefile.
#' 
#' @param x The sf object to clip to.
#' @param proj The coordinate reference system to use: integer with the EPSG code, or character with \code{proj4string}.
#' @param ... Other arguments passed on to \code{coord_sf}.
#' @return a coord_sf.
#' 
#' @importFrom ggplot2 coord_sf
#' @importFrom sf st_as_sfc st_bbox st_crs st_transform
#' @export
#' 
plot_clip <- function(x, proj = proj_nzsf(), ...) {

  if (inherits(x, "bbox")) {
    bbox <- x
    if (!is.null(proj) && !is.na(st_crs(bbox))) {
      bbox <- bbox %>%
        st_as_sfc() %>%
        st_transform(crs = proj) %>%
        st_bbox()
    }
  } else if (inherits(x, c("sf", "sfc", "stars"))) {
    if (!is.null(proj)) x <- st_transform(x, crs = proj)
    bbox <- st_bbox(x)
  } else if (is.character(x) && length(x) == 1L && !is.na(x) &&
             tolower(x) %in% c("nz", "new zealand")) {
    bbox <- st_bbox(get_statistical_areas(area = "EEZ", proj = proj))
  } else {
    stop(
      "`x` must be an sf, sfc, stars, bbox, or New Zealand label.",
      call. = FALSE
    )
  }

  p <- coord_sf(
    crs = proj,
    xlim = unname(bbox[c("xmin", "xmax")]),
    ylim = unname(bbox[c("ymin", "ymax")]),
    ...
  )

  return(p)
}
