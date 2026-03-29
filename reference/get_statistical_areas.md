# Get Statistical Areas

Get Statistical Areas

## Usage

``` r
get_statistical_areas(area = "CRA", proj = proj_nzsf())
```

## Arguments

- area:

  A Quota Managemetn Area (QMA). Can be EEZ, CRA, JMA.

- proj:

  The projection to use.

## Value

New Zealands statistical areas as a `sf` object.

## See also

[`plot_statistical_areas`](http://www.quantifish.co.nz/nzsf/reference/plot_statistical_areas.md)

## Examples

``` r
x <- get_statistical_areas(area = "CRA")
ggplot() +
  geom_sf(data = x, fill = NA)

```
