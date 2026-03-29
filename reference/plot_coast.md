# Plot the New Zealand coastline.

Plot the New Zealand coastline.

## Usage

``` r
plot_coast(
  proj = proj_nzsf(),
  resolution = "medium",
  keep = 1,
  rivers = FALSE,
  size = 0.3,
  ...
)
```

## Arguments

- proj:

  The coordinate reference system to use: integer with the EPSG code, or
  character with `proj4string`.

- resolution:

  the resolution, choose from "10", "50". "110", "150", "1250", "1500".

- keep:

  proportion of points to retain (0-1; default 1).

- rivers:

  Plot rivers over land as `geom_sf`.

- size:

  The line size to pass on to `geom_sf`.

- ...:

  Other arguments passed on to `geom_sf`.

## Value

ggplot of New Zealands coastline.

## See also

[`get_coast`](http://www.quantifish.co.nz/nzsf/reference/get_coast.md)
