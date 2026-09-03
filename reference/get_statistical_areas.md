# Get Statistical Areas

Get Statistical Areas

## Usage

``` r
get_statistical_areas(area = "CRA", proj = proj_nzsf())
```

## Arguments

- area:

  A fisheries area. Supported values include EEZ, CRA, FMA, JMA,
  statistical areas, CCSBT, SIOFA, and SPRFMO.

- proj:

  The projection to use.

## Value

New Zealand's statistical areas as an `sf` object.

## See also

[`plot_statistical_areas`](https://www.quantifish.co.nz/nzsf/reference/plot_statistical_areas.md)

## Examples

``` r
x <- get_statistical_areas(area = "CRA")
ggplot2::ggplot() +
  ggplot2::geom_sf(data = x, fill = NA)

```
