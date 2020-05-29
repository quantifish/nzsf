#' New Zealand projection
#' 
#' The default projection for New Zealand.
#'
#' @export
#' 
proj_nzsf <- function() {
  "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
}


#' CCAMLR projection
#' 
#' This is the CRS 3031 with a 180 degree rotation.
#'
#' @export
#' 
proj_ccamlr <- function() {
  "+proj=stere +lat_0=-90 +lat_ts=-71 +lon_0=180 +k=1 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
}


#' CCSBT projection
#' 
#' This is the CRS 3994.
#'
#' @export
#' 
proj_ccsbt <- function() {
  3994
}
