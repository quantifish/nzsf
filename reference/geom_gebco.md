# Plot GEBCO depth raster

Plot GEBCO depth raster

## Usage

``` r
geom_gebco(proj = proj_nzsf(), downsample = 3, ...)
```

## Arguments

- proj:

  Projection.

- downsample:

  Downsampling rate: e.g. 3 keeps rows and cols 1, 4, 7, 10 etc.; a
  value of 0 does not downsample; can be specified for each dimension,
  e.g. c(5,5,0) to downsample the first two dimensions but not the
  third.

- ...:

  Other arguments passed on to `geom_sf`.

## Value

A `ggplot` object of New Zealands depth polylines.

## See also

[`get_depth`](http://www.quantifish.co.nz/nzsf/reference/get_depth.md)

## Author

Darcy Webber <darcy@quantifish.co.nz>
