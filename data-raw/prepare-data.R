library(usethis)
library(sf)
library(tidyverse)
# library(rgdal)
library(raster)
library(ncdf4)
library(stars)
library(conflicted)

conflict_prefer("select", "dplyr")
conflict_prefer("filter", "dplyr")

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

# setwd("/home/darcy/Projects/nzsf/data-raw")
# setwd("/home/darcy/Projects/nzsf")

# proj_nzsf <- "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
source("../R/projection.R")
proj_nzsf <- proj_nzsf()

# Various ----

SPRFMO <- unzip_and_clean("FAO_RFB_SPRFMO.zip") %>%
  select(OBJECTID, SHAPE_LENG, SHAPE_AREA)
use_data(SPRFMO, overwrite = TRUE)

SIOFA1 <- unzip_and_clean("SIOFA.zip")
# use_data(SIOFA, overwrite = TRUE)
SIOFA <- unzip_and_clean("siofa_subarea_final.zip")
st_crs(SIOFA) <- st_crs(SIOFA1)
use_data(SIOFA, overwrite = TRUE)

FisheriesManagementAreas <- unzip_and_clean("FisheriesManagementAreas.zip") %>%
  select(FeatureKey, LayerKey, LayerGroup, LayerName, SpeciesCod, SpeciesSci, FishstockC, SpeciesCom, FmaName, FmaId, Annotation) %>%
  rename(SpeciesCode = SpeciesCod)
use_data(FisheriesManagementAreas, overwrite = TRUE)

# this version has several issues including gaps between polygons and the land area is clipped to a high resolution coastline making spatial operations slow
# nz_fisheries_general_statistical_areas <- unzip_and_clean("kx-nz-fisheries-general-statistical-areas-SHP.zip") %>%
#   select(-Descriptio)  %>%
#   st_wrap_dateline(options = c("WRAPDATELINE=YES", "DATELINEOFFSET=180"), quiet = TRUE)
# use_data(nz_fisheries_general_statistical_areas, overwrite = TRUE)

nz_rivers <- unzip_and_clean("lds-nz-river-polygons-topo-150k-SHP.zip") %>%
  st_wrap_dateline(options = c("WRAPDATELINE=YES", "DATELINEOFFSET=180"), quiet = TRUE)
use_data(nz_rivers, overwrite = TRUE)

nz_general_statistical_areas <- unzip_and_clean("General_Statistical_Areas-shp.zip") %>%
  select(OBJECTID, Statistica, Statisti_2) %>%
  st_wrap_dateline(options = c("WRAPDATELINE=YES", "DATELINEOFFSET=180"), quiet = TRUE)
use_data(nz_general_statistical_areas, overwrite = TRUE)

nz_inshore_statistical_areas <- unzip_and_clean("Inshore_Statistical_Areas-shp.zip") %>%
  select(OBJECTID, Statistica, Statisti_2)  %>%
  st_wrap_dateline(options = c("WRAPDATELINE=YES", "DATELINEOFFSET=180"), quiet = TRUE)
use_data(nz_inshore_statistical_areas, overwrite = TRUE)

territorial_sea_outer_limit_12_mile <- unzip_and_clean("lds-12-mile-territorial-sea-outer-limit-SHP.zip")
use_data(territorial_sea_outer_limit_12_mile, overwrite = TRUE)

exclusive_economic_zone_outer_limits_200_mile <- unzip_and_clean("lds-200-mile-exclusive-economic-zone-outer-limits-SHP.zip")
use_data(exclusive_economic_zone_outer_limits_200_mile, overwrite = TRUE)

coastline_polyline_hydro_14k_122k <- unzip_and_clean("lds-coastline-polyline-hydro-14k-122k-SHP.zip")
use_data(coastline_polyline_hydro_14k_122k, overwrite = TRUE)

# New Zealand coastline ----

nz_coastlines_and_islands_polygons_topo_150k <- unzip_and_clean("lds-nz-coastlines-and-islands-polygons-topo-150k-SHP.zip")
use_data(nz_coastlines_and_islands_polygons_topo_150k, overwrite = TRUE)

nz_coastlines_and_islands_polygons_topo_1250k <- unzip_and_clean("lds-nz-coastlines-and-islands-polygons-topo-1250k-SHP.zip")
use_data(nz_coastlines_and_islands_polygons_topo_1250k, overwrite = TRUE)

nz_coastlines_and_islands_polygons_topo_1500k <- unzip_and_clean("lds-nz-coastlines-and-islands-polygons-topo-1500k-SHP.zip")
use_data(nz_coastlines_and_islands_polygons_topo_1500k, overwrite = TRUE)

nz_coastlines_topo_150k <- unzip_and_clean("lds-nz-coastlines-topo-150k-SHP.zip")
use_data(nz_coastlines_topo_150k, overwrite = TRUE)

nz_coastlines_topo_1250k <- unzip_and_clean("lds-nz-coastlines-topo-1250k-SHP.zip")
use_data(nz_coastlines_topo_1250k, overwrite = TRUE)

nz_coastlines_topo_1500k <- unzip_and_clean("lds-nz-coastlines-topo-1500k-SHP.zip")
use_data(nz_coastlines_topo_1500k, overwrite = TRUE)

# CCSBT ----

CCSBT <- unzip_and_clean("CCSBT_Statistical_Areas.zip") %>%
  st_wrap_dateline(options = c("WRAPDATELINE=YES", "DATELINEOFFSET=180"), quiet = TRUE)
use_data(CCSBT, overwrite = TRUE)

# CCAMLR ----

ccamlr_statistical_areas <- unzip_and_clean("asd-shapefile-WGS84.zip") %>%
  select(GAR_ID, Name, ShortLabel, LongLabel, StartDate, EndDate)  %>%
  st_transform(crs = proj_ccamlr())
use_data(ccamlr_statistical_areas, overwrite = TRUE)

ccamlr_ssru <- unzip_and_clean("ssru-shapefile-WGS84.zip") %>%
  st_transform(crs = proj_ccamlr())
use_data(ccamlr_ssru, overwrite = TRUE)

ccamlr_mpa <- unzip_and_clean("mpa-shapefile-WGS84.zip") %>%
  st_transform(crs = proj_ccamlr())
use_data(ccamlr_mpa, overwrite = TRUE)

ccamlr_eez <- unzip_and_clean("eez-shapefile-WGS84.zip") %>%
  st_transform(crs = proj_ccamlr())
use_data(ccamlr_eez, overwrite = TRUE)

# Finfish Quota Management Areas (QMAs) ----

HAKE_QMA <- unzip_and_clean("HAKE_QMA.zip") %>% 
  rename(QMA = FishstockC, SpeciesCode = SpeciesCod, SpeciesScientific = SpeciesSci, SpeciesCommmon = SpeciesCom) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon)
use_data(HAKE_QMA, overwrite = TRUE)

HOKI_QMA <- unzip_and_clean("HOKI_QMA.zip") %>% 
  rename(QMA = FishstockC, SpeciesCode = SpeciesCod, SpeciesScientific = SpeciesSci, SpeciesCommmon = SpeciesCom) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon)
use_data(HOKI_QMA, overwrite = TRUE)

JackMackerel_QMA <- unzip_and_clean("JackMackerel_QMA.zip") %>% 
  rename(QMA = FishstockC, SpeciesCode = SpeciesCod, SpeciesScientific = SpeciesSci, SpeciesCommmon = SpeciesCom) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon)
use_data(JackMackerel_QMA, overwrite = TRUE)

LING_QMA <- unzip_and_clean("LING_QMA.zip") %>% 
  rename(QMA = FishstockC, SpeciesCode = SpeciesCod, SpeciesScientific = SpeciesSci, SpeciesCommmon = SpeciesCom) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon)
use_data(LING_QMA, overwrite = TRUE)

OrangeRoughy_QMA <- unzip_and_clean("OrangeRoughy_QMAs.zip") %>% 
  rename(QMA = FishstockC, SpeciesCode = SpeciesCod, SpeciesScientific = SpeciesSci, SpeciesCommmon = SpeciesCom) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon)
use_data(OrangeRoughy_QMA, overwrite = TRUE)

OREO_QMA <- unzip_and_clean("OREO_QMA.zip") %>% 
  rename(QMA = FishstockC, SpeciesCode = SpeciesCod, SpeciesScientific = SpeciesSci, SpeciesCommmon = SpeciesCom) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon)
use_data(OREO_QMA, overwrite = TRUE)

SilverWarehou_QMA <- unzip_and_clean("SilverWarehou_QMAs.zip") %>% 
  rename(QMA = FishstockC, SpeciesCode = SpeciesCod, SpeciesScientific = SpeciesSci, SpeciesCommmon = SpeciesCom) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon)
use_data(SilverWarehou_QMA, overwrite = TRUE)

SouthernBlueWhiting_QMA <- unzip_and_clean("SouthernBlueWhiting_QMAs.zip") %>% 
  rename(QMA = FishstockC, SpeciesCode = SpeciesCod, SpeciesScientific = SpeciesSci, SpeciesCommmon = SpeciesCom) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon)
use_data(SouthernBlueWhiting_QMA, overwrite = TRUE)

# Shellfish Quota Management Areas (QMAs) ----

Cockle_QMA <- unzip_and_clean("Cockle_QMAs.zip") %>% 
  rename(QMA = FishstockC, SpeciesCode = SpeciesCod, SpeciesScientific = SpeciesSci, SpeciesCommmon = SpeciesCom) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon, QmaName)
use_data(Cockle_QMA, overwrite = TRUE)

Paua_QMA <- unzip_and_clean("Paua_QMAs.zip") %>% 
  rename(QMA = FishstockC, SpeciesCode = SpeciesCod, SpeciesScientific = SpeciesSci, SpeciesCommmon = SpeciesCom) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon)
use_data(Paua_QMA, overwrite = TRUE)

Pipi_QMA <- unzip_and_clean("Pipi_QMAs.zip") %>% 
  rename(QMA = FishstockC, SpeciesCode = SpeciesCod, SpeciesScientific = SpeciesSci, SpeciesCommmon = SpeciesCom) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon, QmaName)
use_data(Pipi_QMA, overwrite = TRUE)

Scallop_QMA <- unzip_and_clean("Scallop_QMAs.zip") %>% 
  rename(QMA = FishstockC, SpeciesCode = SpeciesCod, SpeciesScientific = SpeciesSci, SpeciesCommmon = SpeciesCom) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon, QmaName)
use_data(Scallop_QMA, overwrite = TRUE)

# Rock lobsters ----

PackhorseRockLobster_QMA <- unzip_and_clean("QMA_Packhorse_rocklobster_region.zip") %>% 
  rename(QMA = CODE, SpeciesCode = CODE0, SpeciesScientific = NAME0, SpeciesCommmon = NAME) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon)
use_data(PackhorseRockLobster_QMA, overwrite = TRUE)

SpinyRedRockLobster_QMA <- unzip_and_clean("SpinyRedRockLobster_QMAs.zip") %>% 
  rename(QMA = FishstockC, SpeciesCode = SpeciesCod, SpeciesScientific = SpeciesSci, SpeciesCommmon = SpeciesCom) %>%
  select(QMA, SpeciesCode, SpeciesScientific, SpeciesCommmon)
use_data(SpinyRedRockLobster_QMA, overwrite = TRUE)

rock_lobster_stat_areas <- unzip_and_clean("rock_lobster_stat_areas.zip") %>% 
  rename(area = AREA_CODE) %>%
  mutate(QMA = case_when(
    area %in% c(901:904, 939) ~ "CRA1",
    area %in% 905:908 ~ "CRA2",
    area %in% 909:911 ~ "CRA3",
    area %in% c(912:915, 934) ~ "CRA4",
    area %in% c(916:919, 932, 933) ~ "CRA5",
    area %in% 940:943 ~ "CRA6",
    area %in% 920:921 ~ "CRA7",
    area %in% 922:928 ~ "CRA8",
    area %in% c(929:931, 935:938) ~ "CRA9",
    TRUE ~ "Unknown"))
use_data(rock_lobster_stat_areas, overwrite = TRUE)

# Marine reserves ----

doc_marine_reserves <- unzip_and_clean("kx-doc-marine-reserves-SHP.zip") %>%
  select(Name)

motiti_marine_reserves <- unzip_and_clean("Coastal_Plan%3A_Motiti_Protection_Area_(Operative_11_Aug_2021).zip") %>%
  rename(Name = Protection) %>%
  select(Name) %>%
  st_transform(crs = st_crs(doc_marine_reserves))

doc_marine_reserves <- doc_marine_reserves %>%
  bind_rows(motiti_marine_reserves)

use_data(doc_marine_reserves, overwrite = TRUE)

# Marine habitats ----

Gisborne_TToR_Habitats <- unzip_and_clean("Gisborne_Te_Tapuwae_o_Rongokako_Habitats.zip") %>%
  rename(Habitat = HABITAT)
use_data(Gisborne_TToR_Habitats, overwrite = TRUE)

Gisborne_TToR_Reefs <- unzip_and_clean("Gisborne_TToR_Reefs.zip") %>%
  select(Reef_name)
use_data(Gisborne_TToR_Reefs, overwrite = TRUE)

Rocky_reef_National_NZ <- unzip_and_clean("Rocky_reef_National_NZ.zip") %>%
  select(Source)
use_data(Rocky_reef_National_NZ, overwrite = TRUE)

# Depth ----

depth_contour_polyline_hydro_122k_190k <- unzip_and_clean("lds-depth-contour-polyline-hydro-122k-190k-SHP.zip") %>% 
  rename(depth = VALDCO) %>%
  select(depth, SCAMIN, SORDAT, SORIND)
use_data(depth_contour_polyline_hydro_122k_190k, overwrite = TRUE)

depth_contour_polyline_hydro_190k_1350k <- unzip_and_clean("lds-depth-contour-polyline-hydro-190k-1350k-SHP.zip") %>% 
  rename(depth = VALDCO) %>%
  select(depth, SCAMIN, SORDAT, SORIND)
use_data(depth_contour_polyline_hydro_190k_1350k, overwrite = TRUE)

depth_contour_polyline_hydro_1350k_11500k <- unzip_and_clean("lds-depth-contour-polyline-hydro-1350k-11500k-SHP.zip") %>%
  rename(depth = VALDCO) %>%
  select(depth, SCAMIN, SORDAT, SORIND)
use_data(depth_contour_polyline_hydro_1350k_11500k, overwrite = TRUE)

# GEBCO depth ----

# Install GMT
# https://www.generic-mapping-tools.org/
# https://github.com/GenericMappingTools/gmt/blob/master/INSTALL.md
# Download GEBCO
# https://www.gebco.net/data_and_products/gridded_bathymetry_data/
f <- "gebco_2021.zip"
fz <- unzip(zipfile = f, list = TRUE)
# unzip(zipfile = f)
# Too big
# gebco <- stack(x = "GEBCO_2021.nc") %>% readAll()
system("gmt grdsample GEBCO_2021.nc -GGEBCO.nc -I20k")
system("gmt grdedit GEBCO.nc -GGEBCO.nc -Dzelevation")
system("gmt grdedit GEBCO.nc -fg")
gebco <- stack(x = "GEBCO.nc") %>% readAll()
crs(gebco) <- "+proj=longlat +datum=WGS84 +no_defs"
# use_data(gebco, overwrite = TRUE)

system("gmt grdsample GEBCO_2021.nc -GNZ.nc -R-180/180/-60/-15 -I5k")
system("gmt grdedit NZ.nc -GNZ.nc -Dzelevation")
system("gmt grdedit NZ.nc -fg")

bb <- FisheriesManagementAreas %>% 
  filter(.data$LayerName == "General FMAs") %>%
  st_make_valid() %>%
  st_union() %>% 
  st_transform(crs = proj_nzsf()) %>%
  as_Spatial()
  # st_buffer(dist = 1e7) %>%
  # st_bbox() %>% 
  # st_as_sfc()

nz1 <- raster(x = "NZ.nc")
nz2 <- projectRaster(from = nz1, crs = proj_nzsf())
gebco_NZ <- crop(nz2, extent(bb))
# gebco_NZ <- shift(rotate(shift(gebco_NZ, 180)), 180)
# plot(gebco_NZ)
# readAll() %>%
# st_as_stars() %>%
#   # st_transform(crs = proj_nzsf()) %>%
#   st_warp(crs = proj_nzsf()) %>%
#   st_crop(bb)
use_data(gebco_NZ, overwrite = TRUE)
file.remove("NZ.nc")

system("gmt grdsample GEBCO_2021.nc -GSIOFA.nc -R0/125/-75/15 -I20k")
system("gmt grdedit SIOFA.nc -GSIOFA.nc -Dzelevation")
system("gmt grdedit SIOFA.nc -fg")
gebco_SIOFA <- stack(x = "SIOFA.nc") %>% readAll()
#   rotate()
use_data(gebco_SIOFA, overwrite = TRUE)
file.remove("SIOFA.nc")

# system("gmt grdsample GEBCO_2021.nc -GCCAMLR.nc -R110/179/-75/-50 -I15k")
system("gmt grdsample GEBCO_2021.nc -GCCAMLR.nc -R-180/180/-85/-40 -I20k")
system("gmt grdedit CCAMLR.nc -GCCAMLR.nc -Dzelevation")
system("gmt grdedit CCAMLR.nc -fg")
gebco_CCAMLR <- stack(x = "CCAMLR.nc") %>% readAll()
use_data(gebco_CCAMLR, overwrite = TRUE)
file.remove("CCAMLR.nc")

# file.remove(fz$Name)

# This file is too big
# f <- "NZBathy_DTM_2016_ascii_grid.zip"
# fz <- unzip(zipfile = f, list = TRUE)
# unzip(zipfile = f)
# NZBathymetry_2016_grid <- readGDAL("nzbathymetry_2016_ascii-grid.txt") %>%
#   raster()
# crs(NZBathymetry_2016_grid) <- "+proj=merc +lat_ts=-41 +lon_0=100 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs"
# file.remove(fz$Name)
NZBathymetry_2016_grid <- NULL
use_data(NZBathymetry_2016_grid, overwrite = TRUE)

# gebco_contours <- unzip_and_clean("gebco_2019_contours.zip")
# use_data(gebco_contours, overwrite = TRUE)

# Environmental layers ----

# library(raster)
# library(ncdf4)
# ncfile <- "era5-nz_sst_to_2020.nc"
# era5_nz_sst <- stack(x = ncfile) %>%
#   rotate()
# nlayers(era5_nz_sst)
# use_data(era5_nz_sst, overwrite = TRUE)

# f <- "mfe-average-seasurface-temperature-19932012-GTiff.zip"
# fz <- unzip(zipfile = f, list = TRUE)
# fz
# unzip(zipfile = f)
# 
# mfe_average_sst <- raster::raster(x = "average-seasurface-temperature-19932012.tif", values = TRUE) %>%
#   projectRaster(crs = proj_nzsf)
# names(mfe_average_sst) <- "layer"
# mfe_average_sst[mfe_average_sst[] < -5 | mfe_average_sst[] > 60] <- NA
# file.remove(fz$Name)
# use_data(mfe_average_sst, overwrite = TRUE)
