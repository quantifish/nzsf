# Convert points to a raster

Convert points to a raster

## Usage

``` r
get_points_as_raster(data, field, fun = "sum", nrow = 100, ncol = 100)
```

## Arguments

- data:

  a spatial feature data.

- field:

  the field to rasterize.

- fun:

  the function

- nrow:

  number of rows

- ncol:

  number of rows

## Value

a raster.

## Examples

``` r
x <- get_qma("CRA")
set.seed(4277)
pts <- sf::st_sf(sf::st_sample(x, size = 1000))
pts$z <- rnorm(nrow(pts))
r <- get_points_as_raster(data = pts, field = "z")
```
