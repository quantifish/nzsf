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
pts <- st_sample(x, size = 1000) %>% 
  st_sf() %>% 
  mutate(z = rnorm(1:n()))
ggplot() +
  plot_raster(data = pts, field = "z")
#> Warning: Raster pixels are placed at uneven horizontal intervals and will be shifted
#> ℹ Consider using `geom_tile()` instead.

```
