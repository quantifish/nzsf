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

  A Quota Managemetn Area (QMA). Can be EEZ, CRA, JMA.

- ...:

  Other arguments passed on to `geom_sf`.

## Value

A ggplot of the selected QMA.

## See also

[`get_statistical_areas`](http://www.quantifish.co.nz/nzsf/reference/get_statistical_areas.md)

## Examples

``` r
ggplot() + 
  plot_statistical_areas(area = "CRA")

```
