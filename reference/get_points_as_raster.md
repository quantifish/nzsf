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
pts <- st_sample(x, size = 1000) %>% 
  st_sf() %>% 
  mutate(z = rnorm(1:n()))
r <- get_points_as_raster(data = pts, field = "z")
```
