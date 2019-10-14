#' Get Quota Management Area (QMA) polygons
#' 
#' @param qma A Quota Managemetn Area (QMA).
#' @param proj The projection to use.
#' @return A simple feature collection of QMA polygons.
#' @export
#' @examples
#' x <- get_qma(qma = "CRA")
#' ggplot() +
#'   geom_sf(data = x, fill = NA)
#' 
get_qma <- function(qma = "CRA",
                    proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs") {

  # Shellfish
  if (qma %in% c("CRA", "crayfish")) {
    data("SpinyRedRockLobster_QMA")
    sf_x <- SpinyRedRockLobster_QMA
    # shp <- "SpinyRedRockLobster_QMAs"
    # dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    # sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("PHC")) {
    data("PackhorseRockLobster_QMA")
    sf_x <- PackhorseRockLobster_QMA
  }
  if (qma %in% c("COC")) {
    data("Cockle_QMA")
    sf_x <- Cockle_QMA
  }
  if (qma %in% c("PAU")) {
    data("Paua_QMA")
    sf_x <- Paua_QMA
  }
  if (qma %in% c("PPI")) {
    data("Pipi_QMA")
    sf_x <- Pipi_QMA
  }
  if (qma %in% c("SCA")) {
    data("Scallop_QMA")
    sf_x <- Scallop_QMA
  }
  
  # Finfish
  if (qma %in% c("JMA")) {
    data("JackMackerel_QMA")
    sf_x <- JackMackerel_QMA
  }
  if (qma %in% c("HAK")) {
    data("HAKE_QMA")
    sf_x <- HAKE_QMA
  }
  if (qma %in% c("HOK")) {
    data("HOKI_QMA")
    sf_x <- HOKI_QMA
  }
  if (qma %in% c("LIN")) {
    data("LING_QMA")
    sf_x <- LING_QMA
  }
  if (qma %in% c("OEO")) {
    data("OREO_QMA")
    sf_x <- OREO_QMA
  }
  if (qma %in% c("ORH")) {
    data("OrangeRoughy_QMA")
    sf_x <- OrangeRoughy_QMA
  }
  if (qma %in% c("SBW")) {
    data("SouthernBlueWhiting_QMA")
    sf_x <- SouthernBlueWhiting_QMA
  }
  if (qma %in% c("SWA")) {
    data("SilverWarehou_QMA")
    sf_x <- SilverWarehou_QMA
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
#' @param qma A Quota Managemetn Area (QMA)
#' @param proj The projection to use.
#' @param ... Other arguments passed on to \code{geom_sf}.
#' @return A ggplot of the selected QMA.
#' @export
#' @examples
#' ggplot() + 
#'   plot_qma(qma = "CRA")
#' 
plot_qma <- function(qma = "CRA",
                     proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", ...) {
  x <- get_qma(qma = qma, proj = proj)
  geom_sf(data = x, ...)
}
