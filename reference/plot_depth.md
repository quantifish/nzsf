# Plot depth polylines around New Zealand

Plot depth polylines around New Zealand

## Usage

``` r
plot_depth(
  proj = proj_nzsf(),
  resolution = "low",
  depths = NULL,
  col_depth = FALSE,
  lty_depth = FALSE,
  ...
)
```

## Arguments

- proj:

  The coordinate reference system to use: integer with the EPSG code, or
  character with `proj4string`.

- resolution:

  the resolution.

- depths:

  a vector of specific depths to filter. Depths (in metres) that are
  available include: 0, 2, 5, 10, 20, 30, 50, 100, 200, 500, 1000, 2000,
  3000, 4000, 5000, 6000, 7000, 8000, 9000, and 10000.

- col_depth:

  Different colours for the depth contours.

- lty_depth:

  Different line types for the depth contours.

- ...:

  Other arguments passed on to `geom_sf`.

## Value

A `ggplot` object of New Zealands depth polylines.

## See also

[`get_depth`](http://www.quantifish.co.nz/nzsf/reference/get_depth.md)

## Author

Darcy Webber <darcy@quantifish.co.nz>
