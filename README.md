
<!-- README.md is generated from README.Rmd. Please edit that file -->

# New Zealand Spatial Features <img src="man/figures/logo.png" align="right" height=140/>

New Zealand Spatial Features (`nzsf`) is an R package for creating
scientific maps in New Zealand waters. The `nzsf` package relies heavily
on the R packages `ggplot2`, `dplyr`, and `sf` providing a
straightforward approach for complex mapping tasks. Maps can be built up
in layers in the same way as `ggplot2` so users can easily add points,
lines/arrows, polygons, coastlines, and much more.

## Installation

The `nzsf` package can be installed from within R using:

``` r
library(devtools)
install_github(repo = "ropensci/rnaturalearthhires")
install_github(repo = "quantifish/nzsf", build_vignettes = TRUE)
```

In the future I hope to release `nzsf` as a formal R package on The
Comprehensive R Archive Network (CRAN).

## Help

The package vignettes are a great place to see what `nzsf` can do. You
can view the package vignettes from within R using:

``` r
browseVignettes(package = "nzsf")
vignette(topic = "nzsf", package = "nzsf")
```

Alternatively, you can look at the help pages associated with each
function and data set in `nzsf`. To see them all use:

``` r
help(package = "nzsf")
```

## Shapefiles

The `nzsf` package includes many different shapefiles including New
Zealand Quota Management Area (QMA) boundaries for many finfish and
shellfish stocks including:

| Species code | Common name            | Scientific name             | Maori name           |
|:-------------|:-----------------------|:----------------------------|:---------------------|
| COC          | Cockle                 | *Austrovenus stutchburyi*   | Tuangi               |
| CRA          | Red rock lobster       | *Jasus edwardsii*           | Kōura                |
| HAK          | Hake                   | *Merluccius australis*      | Kehe, tiikati        |
| HOK          | Hoki                   | *Macruronus novaezelandiae* | Hoki                 |
| LIN          | Ling                   | *Genypterus blacodes*       | Hoka, hokarari, rari |
| OEO          | Oreo                   |                             |                      |
| ORH          | Orange roughy          | *Hoplostethus atlanticus*   | Nihorota             |
| PAU          | Paua                   | *Haliotis iris*             | Pāua                 |
| PHC          | Packhorse rock lobster | *Sagmariasus verreauxi*     | Kōura Papatia        |
| PPI          | Pipi                   | *Paphies australis*         | Pipi                 |
| SWA          | Silver warehou         | *Seriolella punctata*       | Warehou hiriwa       |
| SBW          | Southern blue whiting  | *Micromesistius australis*  |                      |
| SCA          | Scallop                | *Pecten novaezealandiae*    | Tupa                 |

Other useful shapefiles include:

- The New Zealand coastline (in high, medium, and low resolution)
- Depth contours (in high, medium, and low resolution)
- New Zealands Exclusive Economic Zone (EEZ)
- Department of Conservation (DOC) marine reserves
- Rock lobster statistical areas
- New Zealand rocky reefs
- Te Tapuwae o Rongokako (Gisborne) habitats and reefs

These shapefiles can be accessed using the `data` command in R. For
example:

``` r
data("doc_marine_reserves")
```

If you would like additional shapefiles added just let me know in the
issues (please include a link to the shapefiles).
