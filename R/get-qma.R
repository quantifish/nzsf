#' Get Quota Management Area (QMA) polygons
#' 
#' @param qma A Quota Managemetn Area (QMA).
#' @param proj The projection to use.
#' @return A simple feature collection of QMA polygons.
#' @importFrom utils data
#' @importFrom sf st_transform st_union st_cast
#' @export
#' @examples
#' x <- get_qma(qma = "CRA")
#' ggplot() +
#'   geom_sf(data = x, fill = NA)
#' 
get_qma <- function(qma = "CRA", proj = proj_nzsf()) {

  # Shellfish
  if (qma %in% c("CRA", "crayfish")) {
    x <- nzsf::SpinyRedRockLobster_QMA
    # shp <- "SpinyRedRockLobster_QMAs"
    # dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    # x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("PHC")) {
    x <- nzsf::PackhorseRockLobster_QMA
  }
  if (qma %in% c("COC")) {
    x <- nzsf::Cockle_QMA
  }
  if (qma %in% c("PAU")) {
    x <- nzsf::Paua_QMA
  }
  if (qma %in% c("PPI")) {
    x <- nzsf::Pipi_QMA
  }
  if (qma %in% c("SCA")) {
    x <- nzsf::Scallop_QMA
  }
  
  # Finfish
  if (qma %in% c("JMA")) {
    x <- nzsf::JackMackerel_QMA
  }
  if (qma %in% c("HAK")) {
    x <- nzsf::HAKE_QMA
  }
  if (qma %in% c("HOK")) {
    x <- nzsf::HOKI_QMA
  }
  if (qma %in% c("LIN")) {
    x <- nzsf::LING_QMA
  }
  if (qma %in% c("OEO")) {
    x <- nzsf::OREO_QMA
  }
  if (qma %in% c("ORH")) {
    x <- nzsf::OrangeRoughy_QMA
  }
  if (qma %in% c("SBW")) {
    x <- nzsf::SouthernBlueWhiting_QMA
  }
  if (qma %in% c("SWA")) {
    x <- nzsf::SilverWarehou_QMA
  }
  
  if (!is.null(proj)) {
    x <- x %>% 
      st_transform(crs = proj, check = TRUE) %>% 
      st_union(by_feature = TRUE) %>%
      st_cast("MULTIPOLYGON")
  }
  return(x)
}


#' Get a Quota Managemetn Area.
#' 
#' @inheritParams get_qma
#' @param ... Other arguments passed on to \code{geom_sf}.
#' @return A ggplot of the selected QMA.
#' @importFrom ggplot2 geom_sf
#' @export
#' @examples
#' ggplot() + 
#'   plot_qma(qma = "CRA")
#' 
plot_qma <- function(qma = "CRA", proj = proj_nzsf(), ...) {
  x <- get_qma(qma = qma, proj = proj)
  p <- geom_sf(data = x, ...)
  return(p)
}
