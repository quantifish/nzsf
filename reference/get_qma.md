# Get Quota Management Area (QMA) polygons

This function is used to return a Quota Management Area (QMA) as a `sf`
object.

## Usage

``` r
get_qma(qma = "CRA", proj = proj_nzsf())
```

## Arguments

- qma:

  A Quota Management Area (QMA). Can be CRA, PHC, COC, ...

- proj:

  The coordinate reference system to use: integer with the EPSG code, or
  character with `proj4string`.

## Value

A simple feature collection of QMA polygons as a `sf` object.

## See also

[`plot_qma`](https://www.quantifish.co.nz/nzsf/reference/plot_qma.md) to
plot Quota Management Area's.

## Examples

``` r
# Red rock lobster
x <- get_qma(qma = "CRA")
ggplot2::ggplot() +
  ggplot2::geom_sf(data = x, fill = NA)


# Hake
y <- get_qma(qma = "HAK")
ggplot2::ggplot() +
  ggplot2::geom_sf(data = y, fill = NA)

  
# Ling
z <- get_qma(qma = "LIN")
ggplot2::ggplot() +
  ggplot2::geom_sf(data = z, fill = NA)

  
```
