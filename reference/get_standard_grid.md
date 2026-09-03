# Get Fisheries New Zealand standard grid definitions

Get Fisheries New Zealand standard grid definitions

## Usage

``` r
get_standard_grid(
  cell_size,
  bounding_box,
  anchor = c(0, 0),
  return_raster = TRUE,
  crs = proj_nzsf(),
  square = TRUE
)
```

## Arguments

- cell_size:

  square grid boundary length in km

- bounding_box:

  limits generated from call to
  [`sf::st_bbox()`](https://r-spatial.github.io/sf/reference/st_bbox.html)

- anchor:

  projected coordinates, in metres, used to anchor a shared grid cell
  corner. The default is the EPSG:9191 origin at 175 degrees E, 40
  degrees S.

- return_raster:

  return a raster or polygons

- crs:

  the CRS to use

- square:

  logical; if FALSE, create hexagonal grid

## Value

New Zealand's standard grid polygon as a `sf` object or as a raster.

## See also

[`get_standard_grid_origin`](https://www.quantifish.co.nz/nzsf/reference/get_standard_grid_origin.md)

## Author

Darcy Webber, Sophie Mormede, Charles Edwards
