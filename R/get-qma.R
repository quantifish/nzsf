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
    data("SpinyRedRockLobster_QMA")
    x <- SpinyRedRockLobster_QMA
    # shp <- "SpinyRedRockLobster_QMAs"
    # dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    # x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("PHC")) {
    data("PackhorseRockLobster_QMA")
    x <- PackhorseRockLobster_QMA
  }
  if (qma %in% c("COC")) {
    data("Cockle_QMA")
    x <- Cockle_QMA
  }
  if (qma %in% c("PAU")) {
    data("Paua_QMA")
    x <- Paua_QMA
  }
  if (qma %in% c("PPI")) {
    data("Pipi_QMA")
    x <- Pipi_QMA
  }
  if (qma %in% c("SCA")) {
    data("Scallop_QMA")
    x <- Scallop_QMA
  }
  
  # Finfish
  if (qma %in% c("JMA")) {
    data("JackMackerel_QMA")
    x <- JackMackerel_QMA
  }
  if (qma %in% c("HAK")) {
    data("HAKE_QMA")
    x <- HAKE_QMA
  }
  if (qma %in% c("HOK")) {
    data("HOKI_QMA")
    x <- HOKI_QMA
  }
  if (qma %in% c("LIN")) {
    data("LING_QMA")
    x <- LING_QMA
  }
  if (qma %in% c("OEO")) {
    data("OREO_QMA")
    x <- OREO_QMA
  }
  if (qma %in% c("ORH")) {
    data("OrangeRoughy_QMA")
    x <- OrangeRoughy_QMA
  }
  if (qma %in% c("SBW")) {
    data("SouthernBlueWhiting_QMA")
    x <- SouthernBlueWhiting_QMA
  }
  if (qma %in% c("SWA")) {
    data("SilverWarehou_QMA")
    x <- SilverWarehou_QMA
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
