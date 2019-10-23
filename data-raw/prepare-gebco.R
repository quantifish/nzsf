library(usethis)
library(sf)
library(tidyverse)
library(ncdf4)
library(raster)

proj_nzsf <- "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"

# setwd("/home/darcy/Projects/nzsf/data-raw")
# fz <- unzip(zipfile = "GEBCO_2019.zip", list = TRUE)
# fz
# unzip(zipfile = "GEBCO_2019.zip")

# Read in GEBCO depth and convert to rasters ----

nc_data <- nc_open("GEBCO_2019.nc")

lon <- ncvar_get(nc_data, "lon")
lat <- ncvar_get(nc_data, "lat")

ix <- which(lon >= 160)
iy <- which(lat >= -57 & lat <= -25)
df1 <- ncvar_get(nc = nc_data, varid = "elevation", start = c(min(ix), min(iy)), count = c(length(ix), length(iy)))
df1[df1 >= 0] <- NA

r1 <- raster(t(df1), xmn = min(lon[ix]), xmx = max(lon[ix]), ymn = min(lat[iy]), ymx = max(lat[iy]), 
             crs = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+"))
r1 <- flip(r1, direction = "y")

ix <- which(lon <= -170)
df2 <- ncvar_get(nc = nc_data, varid = "elevation", start = c(min(ix), min(iy)), count = c(length(ix), length(iy)))
df2[df2 >= 0] <- NA

# r2 <- raster(t(df2), xmn = min(lon[ix]) %% 360, xmx = max(lon[ix]) %% 360, ymn = min(lat[iy]), ymx = max(lat[iy]), 
#              crs = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+"))
r2 <- raster(t(df2), xmn = min(lon[ix]), xmx = max(lon[ix]), ymn = min(lat[iy]), ymx = max(lat[iy]), 
             crs = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+"))
r2 <- flip(r2, direction = "y")

nc_close(nc_data)

# Merge rasters ----

r <- merge(r1, r2)
r0 <- raster::raster(crs = raster::projection(r))
raster::extent(r0) <- raster::extent(r)
nrow(r0) <- nrow(r)
ncol(r0) <- ncol(r)
r0[] <- r[]
names(r0) <- names(r)

rm(lon, lat, ix, iy, df1, df2, r1, r2, r)
gc()

# Aggregate and reproject ----

gebco_depth_raster <- r0 %>%
  raster::aggregate(fact = 10) %>%
  projectRaster(crs = proj_nzsf)

# dfr <- gebco_depth_raster %>% 
#   rasterToPoints() %>% 
#   data.frame()
# 
# ggplot() +
#   geom_raster(data = dfr, aes(x = x, y = y, fill = layer)) +
#   plot_statistical_areas(area = "EEZ", fill = NA) +
#   #plot_coast(proj = projection(gebco_depth_raster), resolution = "med", fill = "black", colour = NA) +
#   plot_coast(resolution = "med", fill = "black", colour = NA) +
#   coord_sf()

use_data(gebco_depth_raster, overwrite = TRUE)
