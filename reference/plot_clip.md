# Clip to a shapefile.

Clip to a shapefile.

## Usage

``` r
plot_clip(x, proj = proj_nzsf(), ...)
```

## Arguments

- x:

  The sf object to clip to.

- proj:

  The coordinate reference system to use: integer with the EPSG code, or
  character with `proj4string`.

- ...:

  Other arguments passed on to `coord_sf`.

## Value

a coord_sf.
