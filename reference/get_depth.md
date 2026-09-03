# Get depth polylines around New Zealand

Get depth polylines around New Zealand

## Usage

``` r
get_depth(proj = proj_nzsf(), resolution = "low", depths = NULL)
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

## Value

New Zealand's depth polylines as an `sf` object.

## See also

[`plot_depth`](https://www.quantifish.co.nz/nzsf/reference/plot_depth.md)

## Author

Darcy Webber <darcy@quantifish.co.nz>
