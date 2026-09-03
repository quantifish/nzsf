# Changelog

## nzsf 1.2.0

- Correct the default Fisheries New Zealand standard-grid anchor to the
  EPSG:9191 origin at (0, 0), corresponding to 175 degrees E, 40
  degrees S. The origin is now a shared cell corner for all supported,
  nested grid sizes.
- Correct stale raw-data projection strings to use `+lat_0=-40`.
- Correct custom standard-grid anchor calculations, transform geographic
  bounding boxes into the requested projected CRS, and reject invalid
  grid sizes, flags, anchors, bounding boxes, and angular target CRSs.
- Make
  [`get_statistical_areas()`](https://www.quantifish.co.nz/nzsf/reference/get_statistical_areas.md)
  return `sf` objects consistently, return general statistical areas for
  `area = "JMA"`, and keep FMAs distinct.
- Restore
  [`lookup_depth()`](https://www.quantifish.co.nz/nzsf/reference/lookup_depth.md)
  using the bundled GEBCO grid, and document its negative-elevation
  convention. Invalid depth-resolution names now fail instead of
  silently selecting the low-resolution data.
- Stop attaching dependency packages when `nzsf` is loaded, preventing
  common function-name conflicts such as
  [`raster::select()`](https://rdrr.io/pkg/raster/man/select.html)
  masking
  [`dplyr::select()`](https://dplyr.tidyverse.org/reference/select.html).
- Repair invalid bundled vector geometries, use xz data compression, and
  add a reproducible package-data validation manifest and provenance
  guidance. This includes geometry repair for the Ling QMA snapshot; it
  does not assert a legal boundary update because the authoritative
  feature endpoint was unavailable during the refresh.
