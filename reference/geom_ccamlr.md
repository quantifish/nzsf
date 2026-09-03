# CCAMLR geometries

CCAMLR geometries

## Usage

``` r
geom_ccamlr(
  feature = "ssru",
  proj = proj_ccamlr(),
  fill = NA,
  colour = "black",
  ...
)
```

## Arguments

- feature:

  A CCAMLR feature. Supported values are \`ssru\`, \`label\`,
  \`statistical_area\`, \`mpa\`, \`land\`, and \`gebco\`.

- proj:

  The projection to use.

- fill:

  The fill colour for vector features.

- colour:

  The line or text colour for vector features.

- ...:

  Other arguments passed to the selected ggplot2 geom.

## Value

A ggplot2 layer containing the selected CCAMLR feature.

## See also

[`coord_ccamlr`](https://www.quantifish.co.nz/nzsf/reference/coord_ccamlr.md)
