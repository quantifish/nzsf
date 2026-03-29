# CCSBT geometry

A helper function for obtaining a CCSBT related feature and returning a
`geom_sf` object of that feature. Feature include the CCSBT management
areas, labels or land. By default the projection returned by the
function `proj_ccsbt` is used.

## Usage

``` r
geom_ccsbt(
  feature = "area",
  proj = proj_ccsbt(),
  fill = NA,
  colour = "black",
  ...
)
```

## Arguments

- feature:

  A CCSBT feature such as a management area, label or land.

- proj:

  The projection to use.

- fill:

  The fill colour for the selected feature.

- colour:

  The colour for the seleceted feature.

- ...:

  Any additional arguments passed to `geom_sf`.

## Value

A `geom_sf` object.

## See also

[`coord_ccsbt`](http://www.quantifish.co.nz/nzsf/reference/coord_ccsbt.md)
for coord and
[`proj_ccsbt`](http://www.quantifish.co.nz/nzsf/reference/proj_ccsbt.md)
for projection.

## Examples

``` r
ggplot() +
  geom_ccsbt(feature = "area") +
  geom_ccsbt(feature = "land", fill = "black") +
  coord_ccsbt()

```
