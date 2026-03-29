# Plot Marine Reserves

Plot Marine Reserves

## Usage

``` r
plot_marine_reserves(proj = proj_nzsf(), ...)
```

## Arguments

- proj:

  The coordinate reference system to use: integer with the EPSG code, or
  character with `proj4string`.

- ...:

  Other arguments passed on to `geom_sf`.

## Value

a `ggplot` object of New Zealand's marine reserves.

## Examples

``` r
ggplot() +
  plot_marine_reserves()

```
