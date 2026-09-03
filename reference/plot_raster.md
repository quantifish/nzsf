# Plot points as a raster

Plot points as a raster

## Usage

``` r
plot_raster(data, field, fun = "sum", nrow = 100, ncol = 100, ...)
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

- ...:

  Other arguments passed on to `geom_raster`.

## Value

a ggplot.

## Examples

``` r
x <- get_qma("CRA")
set.seed(4277)
pts <- sf::st_sf(sf::st_sample(x, size = 1000))
pts$z <- rnorm(nrow(pts))
ggplot2::ggplot() +
  plot_raster(data = pts, field = "z")

```
