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

gebco_depth_raster <- r0

gebco_depth_raster <- gebco_depth_raster %>%
  raster::aggregate(fact = 10)
  # projectRaster(crs = proj_nzsf)

cont <- c(0,100,200,300,400,500,550,600,650,700,750,800,850,900,950,1000,1250,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000)
# gebco_depth_contour <- rasterToContour(x = gebco_depth_raster, maxpixels = 1e+05, levels = cont)
gebco_depth_contour <- rasterToContour(x = gebco_depth_raster, maxpixels = 1e+05, nlevels = 20)

save(gebco_depth_raster, file = "gebco_depth_raster.rda")
save(gebco_depth_contour, file = "gebco_depth_contour.rda")
# setwd("/home/darcy/Projects/nzsf/data-raw")
# load("gebco_depth_raster.rda")
# use_data(gebco_depth_raster, overwrite = TRUE)

dfr <- gebco_depth_raster %>%
  rasterToPoints() %>%
  data.frame()

ggplot() +
  geom_tile(data = dfr, aes(x = x, y = y, fill = layer))

