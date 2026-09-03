#' GEBCO bathymetry rasters
#'
#' GEBCO elevation rasters bundled for offline plotting and lookup. Elevations
#' are in metres, with ocean depths represented by negative values.
#'
#' @format Raster objects: `gebco` has 2,004,002 cells; `gebco_NZ` has 322,734
#'   cells; `gebco_CCAMLR` has 231,000 cells; and `gebco_SIOFA` has 301,000
#'   cells. Each object contains one elevation layer.
#' @source GEBCO gridded bathymetry data
#'   \url{https://www.gebco.net/data_and_products/gridded_bathymetry_data/}
#' @name gebco-data
NULL

#' @rdname gebco-data
"gebco"

#' @rdname gebco-data
"gebco_NZ"

#' @rdname gebco-data
"gebco_CCAMLR"

#' @rdname gebco-data
"gebco_SIOFA"


#' New Zealand fisheries boundaries and statistical areas
#'
#' Snapshot boundary layers used by Fisheries New Zealand mapping helpers.
#'
#' @format Simple-feature objects with the following feature and attribute
#'   counts: `nz_general_statistical_areas` (121, 3),
#'   `nz_inshore_statistical_areas` (53, 3), `FisheriesManagementAreas` (25,
#'   11), `exclusive_economic_zone_outer_limits_200_mile` (153, 29),
#'   `territorial_sea_outer_limit_12_mile` (930, 4), and
#'   `rock_lobster_stat_areas` (43, 16).
#' @source Fisheries New Zealand fisheries maps
#'   \url{https://www.mpi.govt.nz/legal/legislation-standards-and-reviews/fisheries-legislation/maps-of-nz-fisheries}
#'   and Land Information New Zealand
#'   \url{https://data.linz.govt.nz/}
#' @name nz-fisheries-boundaries
NULL

#' @rdname nz-fisheries-boundaries
"nz_general_statistical_areas"

#' @rdname nz-fisheries-boundaries
"nz_inshore_statistical_areas"

#' @rdname nz-fisheries-boundaries
"FisheriesManagementAreas"

#' @rdname nz-fisheries-boundaries
"exclusive_economic_zone_outer_limits_200_mile"

#' @rdname nz-fisheries-boundaries
"territorial_sea_outer_limit_12_mile"

#' @rdname nz-fisheries-boundaries
"rock_lobster_stat_areas"


#' New Zealand Quota Management Areas
#'
#' Snapshot Quota Management Area (QMA) boundaries. The common core fields are
#' `QMA`, `SpeciesCode`, `SpeciesScientific`, and the historically named
#' `SpeciesCommmon`; some shellfish layers also include `QmaName`.
#'
#' @format Simple-feature objects with the following feature counts:
#'   `Cockle_QMA` (13), `HAKE_QMA` (4), `HOKI_QMA` (2),
#'   `JackMackerel_QMA` (4), `LING_QMA` (8), `OrangeRoughy_QMA` (8),
#'   `OREO_QMA` (5), `PackhorseRockLobster_QMA` (1), `Paua_QMA` (11),
#'   `Pipi_QMA` (10), `Scallop_QMA` (13), `Scampi_QMA` (11),
#'   `SilverWarehou_QMA` (4), `SouthernBlueWhiting_QMA` (5),
#'   `SpinyRedRockLobster_QMA` (10), and `Squid_QMA` (3). Objects have four
#'   attributes, except `Cockle_QMA`, `Pipi_QMA`, and `Scallop_QMA`, which have
#'   five.
#' @source Fisheries New Zealand fisheries maps
#'   \url{https://www.mpi.govt.nz/legal/legislation-standards-and-reviews/fisheries-legislation/maps-of-nz-fisheries}
#' @name qma-data
NULL

#' @rdname qma-data
"Cockle_QMA"

#' @rdname qma-data
"HAKE_QMA"

#' @rdname qma-data
"HOKI_QMA"

#' @rdname qma-data
"JackMackerel_QMA"

#' @rdname qma-data
"LING_QMA"

#' @rdname qma-data
"OrangeRoughy_QMA"

#' @rdname qma-data
"OREO_QMA"

#' @rdname qma-data
"PackhorseRockLobster_QMA"

#' @rdname qma-data
"Paua_QMA"

#' @rdname qma-data
"Pipi_QMA"

#' @rdname qma-data
"Scallop_QMA"

#' @rdname qma-data
"Scampi_QMA"

#' @rdname qma-data
"SilverWarehou_QMA"

#' @rdname qma-data
"SouthernBlueWhiting_QMA"

#' @rdname qma-data
"SpinyRedRockLobster_QMA"

#' @rdname qma-data
"Squid_QMA"


#' New Zealand coast, rivers, and depth contours
#'
#' Snapshot topographic and hydrographic simple-feature layers at several
#' source scales.
#'
#' @format Feature and attribute counts are: `nz_rivers` (4,866, 1),
#'   `nz_coastlines_topo_150k` (39, 2), `nz_coastlines_topo_1250k` (4, 2),
#'   `nz_coastlines_topo_1500k` (3, 1),
#'   `nz_coastlines_and_islands_polygons_topo_150k` (9,261, 7),
#'   `nz_coastlines_and_islands_polygons_topo_1250k` (1,699, 6),
#'   `nz_coastlines_and_islands_polygons_topo_1500k` (725, 2),
#'   `coastline_polyline_hydro_14k_122k` (5,043, 17),
#'   `depth_contour_polyline_hydro_122k_190k` (17,157, 4),
#'   `depth_contour_polyline_hydro_190k_1350k` (14,859, 4), and
#'   `depth_contour_polyline_hydro_1350k_11500k` (4,571, 4). Depth-contour
#'   objects include a `depth` attribute in metres.
#' @source Land Information New Zealand
#'   \url{https://data.linz.govt.nz/}
#' @name nz-topographic-data
NULL

#' @rdname nz-topographic-data
"nz_rivers"

#' @rdname nz-topographic-data
"nz_coastlines_topo_150k"

#' @rdname nz-topographic-data
"nz_coastlines_topo_1250k"

#' @rdname nz-topographic-data
"nz_coastlines_topo_1500k"

#' @rdname nz-topographic-data
"nz_coastlines_and_islands_polygons_topo_150k"

#' @rdname nz-topographic-data
"nz_coastlines_and_islands_polygons_topo_1250k"

#' @rdname nz-topographic-data
"nz_coastlines_and_islands_polygons_topo_1500k"

#' @rdname nz-topographic-data
"coastline_polyline_hydro_14k_122k"

#' @rdname nz-topographic-data
"depth_contour_polyline_hydro_122k_190k"

#' @rdname nz-topographic-data
"depth_contour_polyline_hydro_190k_1350k"

#' @rdname nz-topographic-data
"depth_contour_polyline_hydro_1350k_11500k"


#' New Zealand protected areas and marine habitats
#'
#' Snapshot protected-area and habitat layers used for contextual mapping.
#'
#' @format Simple-feature objects: `doc_marine_reserves` has 50 features and
#'   one attribute; `Hauraki_Gulf_Marine_Park` has one feature and 19
#'   attributes; `Gisborne_TToR_Habitats` has 482 features and 15 attributes;
#'   `Gisborne_TToR_Reefs` has three features and one attribute; and
#'   `Rocky_reef_National_NZ` has 4,817 features and one attribute.
#' @source New Zealand Department of Conservation and source authorities
#'   recorded in `data-raw/README.md`.
#' @name nz-habitat-data
NULL

#' @rdname nz-habitat-data
"doc_marine_reserves"

#' @rdname nz-habitat-data
"Hauraki_Gulf_Marine_Park"

#' @rdname nz-habitat-data
"Gisborne_TToR_Habitats"

#' @rdname nz-habitat-data
"Gisborne_TToR_Reefs"

#' @rdname nz-habitat-data
"Rocky_reef_National_NZ"


#' International fisheries areas
#'
#' Snapshot statistical, management, and convention-area boundaries for
#' international fisheries organisations.
#'
#' @format Simple-feature objects: `SPRFMO` (8 features, 3 attributes),
#'   `SIOFA` (9, 29), `CCSBT` (12, 2), `ccamlr_eez` (7, 13), `ccamlr_mpa`
#'   (6, 12), `ccamlr_ssru` (63, 13), and `ccamlr_statistical_areas` (19, 6).
#' @source SPRFMO, SIOFA, CCSBT, and CCAMLR; CCAMLR spatial data are available
#'   from \url{https://spatial.ccamlr.org/}.
#' @name international-fisheries-data
NULL

#' @rdname international-fisheries-data
"SPRFMO"

#' @rdname international-fisheries-data
"SIOFA"

#' @rdname international-fisheries-data
"CCSBT"

#' @rdname international-fisheries-data
"ccamlr_eez"

#' @rdname international-fisheries-data
"ccamlr_mpa"

#' @rdname international-fisheries-data
"ccamlr_ssru"

#' @rdname international-fisheries-data
"ccamlr_statistical_areas"
