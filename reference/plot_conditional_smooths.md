# Plot a conditional_smooths output

Plot a conditional_smooths output

## Usage

``` r
plot_conditional_smooths(
  x,
  resolution = 100,
  smooths = NULL,
  crs1 = st_crs(4326),
  crs2 = proj_nzsf(),
  ...
)
```

## Arguments

- x:

  An object of class `brmsfit`.

- resolution:

  Number of support points used to generate the plots. Higher resolution
  leads to smoother plots. Defaults to `100`. If `surface` is `TRUE`,
  this implies `10000` support points for interaction terms, so it might
  be necessary to reduce `resolution` when only few RAM is available.

- smooths:

  Optional character vector of smooth terms to display. If `NULL` (the
  default) all smooth terms are shown.

- crs1:

  The CRS of the coordinates in the model.

- crs2:

  The desired output CRS.

- ...:

  Other arguments passed on to `plot_raster`.

## Value

a ggplot.
