#' New Zealand projection
#' 
#' The default projection for New Zealand. See the document "A standardised 
#' approach for creating spatial grids for New Zealand marine environment and 
#' species data". This CRS has been formally registered by EPSG as EPSG:9191 
#' (see: https://epsg.io/9191 which includes the formal OGP XML specification).
#'
#' @export
#' 
proj_nzsf <- function() {
  #9191
 "+proj=aea +lat_1=-30 +lat_2=-50 +lat_0=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
}


#' CCAMLR projection
#' 
#' This is the CRS 3031 with a 180 degree rotation.
#'
#' @param rotation The rotation to apply.
#' 
#' @export
#' 
proj_ccamlr <- function(rotation = 180) {
  paste0("+proj=stere +lat_0=-90 +lat_ts=-71 +lon_0=", rotation, " +k=1 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")
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
