# Get the New Zealand coastline

Get the New Zealand coastline

## Usage

``` r
get_coast(proj = proj_nzsf(), resolution = "medium", keep = 1)
```

## Arguments

- proj:

  The coordinate reference system to use: integer with the EPSG code, or
  character with `proj4string`.

- resolution:

  the resolution, choose from "10", "50". "110", "150", "1250", "1500".

- keep:

  proportion of points to retain (0-1; default 1).

## Value

New Zealand's coastline as an `sf` object.

## See also

[`plot_coast`](https://www.quantifish.co.nz/nzsf/reference/plot_coast.md)
