library(sf)
library(tidyverse)
library(usethis)

unzip_and_clean <- function(f) {
  fz <- unzip(zipfile = f, list = TRUE)
  unzip(zipfile = f)
  dsn <- fz$Name[grep(".shp", fz$Name)]
  layer <- gsub(".shp", "", dsn)
  x <- st_read(dsn = ".", layer = layer)
  file.remove(fz$Name)
  layer_name <- gsub("-", "_", layer)
  print(layer_name)
  return(x)
}

# Various ---

FisheriesManagementAreas <- unzip_and_clean("data-raw/FisheriesManagementAreas.zip") %>%
  dplyr::select(-Descriptio) %>%
  rename(SpeciesCode = SpeciesCod)
use_data(FisheriesManagementAreas, overwrite = TRUE)

nz_fisheries_general_statistical_areas <- unzip_and_clean("data-raw/kx-nz-fisheries-general-statistical-areas-SHP.zip") %>%
  dplyr::select(-Descriptio)
use_data(nz_fisheries_general_statistical_areas, overwrite = TRUE)

territorial_sea_outer_limit_12_mile <- unzip_and_clean("data-raw/lds-12-mile-territorial-sea-outer-limit-SHP.zip")
use_data(territorial_sea_outer_limit_12_mile, overwrite = TRUE)

exclusive_economic_zone_outer_limits_200_mile <- unzip_and_clean("data-raw/lds-200-mile-exclusive-economic-zone-outer-limits-SHP.zip")
use_data(exclusive_economic_zone_outer_limits_200_mile, overwrite = TRUE)

coastline_polyline_hydro_14k_122k <- unzip_and_clean("data-raw/lds-coastline-polyline-hydro-14k-122k-SHP.zip")
use_data(coastline_polyline_hydro_14k_122k, overwrite = TRUE)

# Depth ---

depth_contour_polyline_hydro_122k_190k <- unzip_and_clean("data-raw/lds-depth-contour-polyline-hydro-122k-190k-SHP.zip") %>% 
  rename(depth = VALDCO)
use_data(depth_contour_polyline_hydro_122k_190k, overwrite = TRUE)

depth_contour_polyline_hydro_190k_1350k <- unzip_and_clean("data-raw/lds-depth-contour-polyline-hydro-190k-1350k-SHP.zip") %>% 
  rename(depth = VALDCO)
use_data(depth_contour_polyline_hydro_190k_1350k, overwrite = TRUE)

depth_contour_polyline_hydro_1350k_11500k <- unzip_and_clean("data-raw/lds-depth-contour-polyline-hydro-1350k-11500k-SHP.zip") %>%
  rename(depth = VALDCO)
use_data(depth_contour_polyline_hydro_1350k_11500k, overwrite = TRUE)

# New Zealand coastline ---

nz_coastlines_and_islands_polygons_topo_150k <- unzip_and_clean("data-raw/lds-nz-coastlines-and-islands-polygons-topo-150k-SHP.zip")
use_data(nz_coastlines_and_islands_polygons_topo_150k, overwrite = TRUE)

nz_coastlines_and_islands_polygons_topo_1250k <- unzip_and_clean("data-raw/lds-nz-coastlines-and-islands-polygons-topo-1250k-SHP.zip")
use_data(nz_coastlines_and_islands_polygons_topo_1250k, overwrite = TRUE)

nz_coastlines_and_islands_polygons_topo_1500k <- unzip_and_clean("data-raw/lds-nz-coastlines-and-islands-polygons-topo-1500k-SHP.zip")
use_data(nz_coastlines_and_islands_polygons_topo_1500k, overwrite = TRUE)

nz_coastlines_topo_150k <- unzip_and_clean("data-raw/lds-nz-coastlines-topo-150k-SHP.zip")
use_data(nz_coastlines_topo_150k, overwrite = TRUE)

nz_coastlines_topo_1250k <- unzip_and_clean("data-raw/lds-nz-coastlines-topo-1250k-SHP.zip")
use_data(nz_coastlines_topo_1250k, overwrite = TRUE)

nz_coastlines_topo_1500k <- unzip_and_clean("data-raw/lds-nz-coastlines-topo-1500k-SHP.zip")
use_data(nz_coastlines_topo_1500k, overwrite = TRUE)

# Finfish Quota Management Areas (QMAs) ---

HAKE_QMA <- unzip_and_clean("data-raw/HAKE_QMA.zip") %>% 
  rename(QMA = FishstockC)
use_data(HAKE_QMA, overwrite = TRUE)

HOKI_QMA <- unzip_and_clean("data-raw/HOKI_QMA.zip") %>% 
  rename(QMA = FishstockC)
use_data(HOKI_QMA, overwrite = TRUE)

JackMackerel_QMA <- unzip_and_clean("data-raw/JackMackerel_QMA.zip") %>% 
  rename(QMA = FishstockC)
use_data(JackMackerel_QMA, overwrite = TRUE)

LING_QMA <- unzip_and_clean("data-raw/LING_QMA.zip") %>% 
  rename(QMA = FishstockC)
use_data(LING_QMA, overwrite = TRUE)

OrangeRoughy_QMA <- unzip_and_clean("data-raw/OrangeRoughy_QMAs.zip") %>% 
  rename(QMA = FishstockC)
use_data(OrangeRoughy_QMA, overwrite = TRUE)

OREO_QMA <- unzip_and_clean("data-raw/OREO_QMA.zip") %>% 
  rename(QMA = FishstockC)
use_data(OREO_QMA, overwrite = TRUE)

SilverWarehou_QMA <- unzip_and_clean("data-raw/SilverWarehou_QMAs.zip") %>% 
  rename(QMA = FishstockC)
use_data(SilverWarehou_QMA, overwrite = TRUE)

SouthernBlueWhiting_QMA <- unzip_and_clean("data-raw/SouthernBlueWhiting_QMAs.zip") %>% 
  rename(QMA = FishstockC)
use_data(SouthernBlueWhiting_QMA, overwrite = TRUE)

# Shellfish Quota Management Areas (QMAs) ---

Cockle_QMA <- unzip_and_clean("data-raw/Cockle_QMAs.zip") %>% 
  rename(QMA = FishstockC)
use_data(Cockle_QMA, overwrite = TRUE)

Paua_QMA <- unzip_and_clean("data-raw/Paua_QMAs.zip") %>% 
  rename(QMA = FishstockC)
use_data(Paua_QMA, overwrite = TRUE)

Pipi_QMA <- unzip_and_clean("data-raw/Pipi_QMAs.zip") %>% 
  rename(QMA = FishstockC)
use_data(Pipi_QMA, overwrite = TRUE)

Scallop_QMA <- unzip_and_clean("data-raw/Scallop_QMAs.zip") %>% 
  rename(QMA = FishstockC)
use_data(Scallop_QMA, overwrite = TRUE)

# Rock lobsters ---

PackhorseRockLobster_QMA <- unzip_and_clean("data-raw/QMA_Packhorse_rocklobster_region.zip") %>% 
  rename(QMA = CODE)
use_data(PackhorseRockLobster_QMA, overwrite = TRUE)

SpinyRedRockLobster_QMA <- unzip_and_clean("data-raw/SpinyRedRockLobster_QMAs.zip") %>% 
  rename(QMA = FishstockC)
use_data(SpinyRedRockLobster_QMA, overwrite = TRUE)

rock_lobster_stat_areas <- unzip_and_clean("data-raw/rock_lobster_stat_areas.zip") %>% 
  rename(area = AREA_CODE) %>%
  mutate(QMA = ifelse(area %in% 909:911, "CRA3", "CRA"))
use_data(rock_lobster_stat_areas, overwrite = TRUE)

# Marine reserves ---

doc_marine_reserves <- unzip_and_clean("data-raw/kx-doc-marine-reserves-SHP.zip") %>%
  dplyr::select(-Section, -Legislatio, -Government, -Local_Purp, -Type, -GlobalID)
use_data(doc_marine_reserves, overwrite = TRUE)

Gisborne_TToR_Habitats <- unzip_and_clean("data-raw/Gisborne_Te_Tapuwae_o_Rongokako_Habitats.zip") %>%
  rename(Habitat = HABITAT)
use_data(Gisborne_TToR_Habitats, overwrite = TRUE)

Gisborne_TToR_Reefs <- unzip_and_clean("data-raw/Gisborne_TToR_Reefs.zip")
use_data(Gisborne_TToR_Reefs, overwrite = TRUE)

Rocky_reef_National_NZ <- unzip_and_clean("data-raw/Rocky_reef_National_NZ.zip")
use_data(Rocky_reef_National_NZ, overwrite = TRUE)
