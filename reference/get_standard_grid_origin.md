# Get Fisheries New Zealand standard grid origin

Get Fisheries New Zealand standard grid origin

## Usage

``` r
get_standard_grid_origin(cell_size, bounding_box, anchor = c(0, 422600))
```

## Arguments

- cell_size:

  square grid boundary length in km

- bounding_box:

  limits generated from call to
  [`sf::st_bbox()`](https://r-spatial.github.io/sf/reference/st_bbox.html)

- anchor:

  the point to anchor the grid to

## Value

standard grid origin `data.frame`

## See also

[`get_standard_grid`](http://www.quantifish.co.nz/nzsf/reference/get_standard_grid.md)

## Author

Darcy Webber, Sophie Mormede, Charles Edwards
