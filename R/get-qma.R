#' Get Quota Management Area (QMA) polygons
#' 
#' @param qma A Quota Managemetn Area (QMA). Can be CRA, PHC, COC, ...
#' @param proj The coordinate reference system to use: integer with the EPSG code, or character with \code{proj4string}.
#' @return A simple feature collection of QMA polygons as a \code{sf} object.
#' 
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
  # qma <- "CRA"
  # any(str_detect(qma, regex(c("CRA", "crayfish", "koura"), ignore_case = TRUE)))
  if (qma %in% c("CRA", "crayfish", "koura", "Koura", "Jasus", "Jasus edwardsii")) {
    x <- nzsf::SpinyRedRockLobster_QMA
    # shp <- "SpinyRedRockLobster_QMAs"
    # dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    # x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("PHC", "packhorse", "koura papatia", "Sagmariasus verreauxi")) {
    x <- nzsf::PackhorseRockLobster_QMA
  }
  if (qma %in% c("COC", "cockle", "Cockle", "tuangi", "Tuangi", "Austrovenus stutchburyi")) {
    x <- nzsf::Cockle_QMA
  }
  if (qma %in% c("PAU", "paua", "Paua", "Haliotis iris")) {
    x <- nzsf::Paua_QMA
  }
  if (qma %in% c("PPI", "pipi", "Pipi", "Paphies australis")) {
    x <- nzsf::Pipi_QMA
  }
  if (qma %in% c("SCA", "scallop", "Scallop", "tupa", "Tupa", "Pecten novaezealandiae")) {
    x <- nzsf::Scallop_QMA
  }
  
  # Finfish
  if (qma %in% c("JMA", "jack mackerel", "JMD", "JMM", "JMN")) {
    x <- nzsf::JackMackerel_QMA
  }
  if (qma %in% c("HAK", "hake", "kehe", "tiikati", "Merluccius australis")) {
    x <- nzsf::HAKE_QMA
  }
  if (qma %in% c("HOK", "hoki", "Macruronus novaezelandiae")) {
    x <- nzsf::HOKI_QMA
  }
  if (qma %in% c("LIN", "ling", "hoka", "hokarari", "rari", "Genypterus blacodes")) {
    x <- nzsf::LING_QMA
  }
  if (qma %in% c("OEO", "oreo")) {
    x <- nzsf::OREO_QMA
  }
  if (qma %in% c("ORH", "orange roughy", "nihorota", "Hoplostethus atlanticus")) {
    x <- nzsf::OrangeRoughy_QMA
  }
  if (qma %in% c("SBW", "southern blue whiting", "Micromesistius australis")) {
    x <- nzsf::SouthernBlueWhiting_QMA
  }
  if (qma %in% c("SWA", "silver warehou", "warehou hiriwa", "Seriolella punctata")) {
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
#' @return A \code{ggplot} object of the selected QMA.
#' 
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
