# GEBCO bathymetry rasters

GEBCO elevation rasters bundled for offline plotting and lookup.
Elevations are in metres, with ocean depths represented by negative
values.

## Usage

``` r
gebco

gebco_NZ

gebco_CCAMLR

gebco_SIOFA
```

## Format

Raster objects: \`gebco\` has 2,004,002 cells; \`gebco_NZ\` has 322,734
cells; \`gebco_CCAMLR\` has 231,000 cells; and \`gebco_SIOFA\` has
301,000 cells. Each object contains one elevation layer.

An object of class `RasterStack` of dimension 1001 x 2002 x 1.

An object of class `RasterLayer` of dimension 722 x 447 x 1.

An object of class `RasterStack` of dimension 250 x 924 x 1.

An object of class `RasterStack` of dimension 500 x 602 x 1.

## Source

GEBCO gridded bathymetry data
<https://www.gebco.net/data_and_products/gridded_bathymetry_data/>
