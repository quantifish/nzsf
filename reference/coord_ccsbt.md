# CCSBT coord

CCSBT coord

## Usage

``` r
coord_ccsbt(proj = proj_ccsbt(), ...)
```

## Arguments

- proj:

  The projection to use.

- ...:

  Any additional arguments passed to `coord_sf`.

## Value

A `geom_coord` object.

## See also

[`geom_ccsbt`](https://www.quantifish.co.nz/nzsf/reference/geom_ccsbt.md)

## Examples

``` r
ggplot2::ggplot() +
  geom_ccsbt(feature = "area") +
  geom_ccsbt(feature = "land", fill = "black") +
  coord_ccsbt()

```
