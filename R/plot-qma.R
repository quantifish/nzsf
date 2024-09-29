#' Get Quota Management Area (QMA) polygons
#' 
#' This function is used to return a Quota Management Area (QMA) as a \code{sf} object. 
#' 
#' @param qma A Quota Management Area (QMA). Can be CRA, PHC, COC, ...
#' @param proj The coordinate reference system to use: integer with the EPSG code, or character with \code{proj4string}.
#' @return A simple feature collection of QMA polygons as a \code{sf} object.
#' @seealso \code{\link{plot_qma}} to plot Quota Management Area's.
#' 
#' @importFrom utils data
#' @importFrom sf st_transform st_union st_cast
#' @export
#' @examples
#' # Red rock lobster
#' x <- get_qma(qma = "CRA")
#' ggplot() +
#'   geom_sf(data = x, fill = NA)
#'
#' # Hake
#' y <- get_qma(qma = "HAK")
#' ggplot() +
#'   geom_sf(data = y, fill = NA)
#'   
#' # Ling
#' z <- get_qma(qma = "LIN")
#' ggplot() +
#'   geom_sf(data = z, fill = NA)
#'   
get_qma <- function(qma = "CRA", proj = proj_nzsf()) {

  # Shellfish
  if (qma %in% c("CRA", "crayfish", "koura", "Koura", "Jasus", "Jasus edwardsii")) {
    x <- nzsf::SpinyRedRockLobster_QMA
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
  if (qma %in% c("SQU", "squid", "Squid")) {
    x <- nzsf::Squid_QMA
  }
  if (qma %in% c("SCI", "scampi", "Scapi")) {
    x <- nzsf::Scampi_QMA
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
      st_cast("MULTIPOLYGON") %>%
      st_make_valid()
  }
  return(x)
}


#' Plot a Quota Management Area (QMA)
#' 
#' This function is used to plot a Quota Management Area (QMA) as a \code{ggplot2} object. 
#' 
#' @inheritParams get_qma
#' @param ... Other arguments passed on to \code{geom_sf}.
#' @return A \code{ggplot} object of the selected QMA.
#' @seealso \code{\link{get_qma}} to return Quota Management Area (QMA) polygons as \code{sf} objects.
#' 
#' @importFrom ggplot2 geom_sf
#' @export
#' @examples
#' # Packhorse rock lobster
#' ggplot() + 
#'   plot_qma(qma = "PHC")
#'   
#' # Jack mackerel
#' ggplot() + 
#'   plot_qma(qma = "JMA")
#'
#' # Paua
#' ggplot() + 
#'   plot_qma(qma = "PAU")
#' 
plot_qma <- function(qma = "CRA", proj = proj_nzsf(), ...) {
  x <- get_qma(qma = qma, proj = proj)
  p <- geom_sf(data = x, ...)
  return(p)
}
