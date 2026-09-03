# Get statistical areas

Get statistical areas

## Usage

``` r
plot_statistical_areas(proj = proj_nzsf(), area = "CRA", ...)
```

## Arguments

- proj:

  The projection to use.

- area:

  A fisheries area. Supported values include EEZ, CRA, FMA, JMA,
  statistical areas, CCSBT, SIOFA, and SPRFMO.

- ...:

  Other arguments passed on to `geom_sf`.

## Value

A ggplot of the selected QMA.

## See also

[`get_statistical_areas`](https://www.quantifish.co.nz/nzsf/reference/get_statistical_areas.md)

## Examples

``` r
ggplot2::ggplot() +
  plot_statistical_areas(area = "CRA")

```
