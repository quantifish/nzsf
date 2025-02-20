% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot-qma.R
\name{get_qma}
\alias{get_qma}
\title{Get Quota Management Area (QMA) polygons}
\usage{
get_qma(qma = "CRA", proj = proj_nzsf())
}
\arguments{
\item{qma}{A Quota Management Area (QMA). Can be CRA, PHC, COC, ...}

\item{proj}{The coordinate reference system to use: integer with the EPSG code, or character with \code{proj4string}.}
}
\value{
A simple feature collection of QMA polygons as a \code{sf} object.
}
\description{
This function is used to return a Quota Management Area (QMA) as a \code{sf} object.
}
\examples{
# Red rock lobster
x <- get_qma(qma = "CRA")
ggplot() +
  geom_sf(data = x, fill = NA)

# Hake
y <- get_qma(qma = "HAK")
ggplot() +
  geom_sf(data = y, fill = NA)
  
# Ling
z <- get_qma(qma = "LIN")
ggplot() +
  geom_sf(data = z, fill = NA)
  
}
\seealso{
\code{\link{plot_qma}} to plot Quota Management Area's.
}
