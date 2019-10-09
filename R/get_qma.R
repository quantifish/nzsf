#' Get a Quota Managemetn Area.
#' 
#' @param qma A Quota Managemetn Area (QMA)
#' @param proj The projection to use.
#' @return A QMA.
#' @export
#' @examples
#' get_qma(qma = "CRA")
#' get_qma(qma = "PHC")
#' get_qma(qma = "COC")
#' get_qma(qma = "HOK")
#' get_qma(qma = "HAK")
#' 
get_qma <- function(qma = "CRA",
                    proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs") {

  # Shellfish
  if (qma %in% c("CRA")) {
    data("SpinyRedRockLobster_QMA")
    sf_x <- SpinyRedRockLobster_QMA
    # shp <- "SpinyRedRockLobster_QMAs"
    # dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    # sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("PHC")) {
    shp <- "QMA_Packhorse_rocklobster_region"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = CODE)
  }
  if (qma %in% c("COC")) {
    shp <- "Cockle_QMAs"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("PAU")) {
    shp <- "Paua_QMAs"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("PPI")) {
    shp <- "Pipi_QMAs"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("SCA")) {
    shp <- "Scallop_QMAs"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  
  # Finfish
  if (qma %in% c("JMA")) {
    data("JackMackerel_QMA")
    sf_x <- JackMackerel_QMA
  }
  if (qma %in% c("HAK")) {
    shp <- "HAKE_QMA"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("HOK")) {
    shp <- "HOKI_QMA"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("LIN")) {
    shp <- "LING_QMA"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("OEO")) {
    shp <- "OREO_QMA"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("ORH")) {
    shp <- "OrangeRoughy_QMAs"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("SBW")) {
    shp <- "SouthernBlueWhiting_QMAs"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("SWA")) {
    shp <- "SilverWarehou_QMAs"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
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
