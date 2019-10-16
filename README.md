New Zealand Spatial Features <img src="sticker.png" align="right" height=140/>
==============================================================================

![Build Status](https://travis-ci.org/quantifish/nzsf.svg?branch=master)

New Zealand Spatial Features (`nzsf`) is a package for creating scientific maps in New Zealand waters. The `nzsf` package relies heavily on the R packages `ggplot2`, `dplyr`, and `sf` providing a fresh and easy approach for complex mapping tasks. Maps can be built up in layers in the same way as `ggplot2` so users can easily add points, lines/arrows, polygons, coastlines, and much more. It can be installed from within R using:

    library(devtools)
    install_github("quantifish/nzsf", build_vignettes = TRUE)

The package vignettes are a great place to see what `nzsf` can do. You can view the package vignettes from within R using:

    browseVignettes(package = "nzsf")
    vignette(package = "nzsf")

 The `nzsf` package can plot QMA boundaries for many New Zealand finfish and shellfish stocks:

| Species code | Common name            | Scientific name             | Maori name           |
|:------------:|:---------------------- |:--------------------------- |:-------------------- |
| HAK          | Hake                   | *Merluccius australis*      | Kehe, tiikati        |
| HOK          | Hoki                   | *Macruronus novaezelandiae* |                      |
| LIN          | Ling                   | *Genypterus blacodes*       | Hoka, hokarari, rari |
| OEO          | Oreo                   |                             |                      |
| ORH          | Orange roughy          | *Hoplostethus atlanticus*   |                      |
| SWA          | Silver warehou         | *Seriolella punctata*       | Warehou hiriwa       |
| SBW          | Southern blue whiting  | *Micromesistius australis*  |                      |
| CRA          | Red rock lobster       | *Jasus edwardsii*           | Kōura                |
| PHC          | Packhorse rock lobster | *Sagmariasus verreauxi*     | Kōura Papatia        |
| COC          | Cockle                 |                             | Tuangi               |
| PPI          | Pipi                   |                             | Pipi                 |
| PAU          | Paua                   | *Haliotis iris*             | Pāua                 |
| SCA          | Scallop                | *Pecten novaezealandiae*    | Tupa                 |

If you would like additional stocks added just let me know in the issues (please include a link to the shapefiles).
