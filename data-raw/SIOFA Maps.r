#install_github(repo = "ccamlr/CCAMLRGIS", build_vignettes = TRUE)
#browseVignettes(package = "CCAMLRRGIS")

#install.packages("marmap")
#install.packages("tidync")
#install.packages("CCAMLRGIS")

library(nzsf)
library(ggspatial)
library(rnaturalearth)
library(rnaturalearthdata)
library(viridis)
library(raster)
library(lwgeom)
library(patchwork)
library(marmap)

source(make.filename("Functions.r",DIR$Functions))
.COL <- set.colours()
.COL$land <- "#F5F5DCFF"
.COL$statarea <- "#DDDDDD44"

theme_set(theme_bw() + theme(axis.title = element_blank()))
Proj <- CRS("+proj=longlat +datum=WGS84 +no_defs") # this is epsg4326

#SIOFA3832 <- SIOFA %>% st_crs(Proj)
world <- ne_countries(scale = "medium", returnclass = "sf") #%>% st_crs(Proj)

bathy<-getNetCDF(file=make.filename("SIOFA.nc",DIR$GEBCO))
bathy <- as.raster(bathy) 
#bathy <- crop(bathy, extent(0,125,-75,15))	
bathy <- as(bathy, "SpatialPixelsDataFrame")
bathy <- as.data.frame(bathy)
colnames(bathy) <-c("depth","long","lat")
bathy[bathy$depth >0,] <- NA

ASD <- st_read(make.filename("/asd-shapefile-WGS84/asd-shapefile-WGS84.shp",DIR$Data))
EEZ <- st_read(make.filename("/eez-shapefile-WGS84/eez-shapefile-WGS84.shp",DIR$Data))
SSRU <- st_read(make.filename("/ssru-shapefile-WGS84/ssru-shapefile-WGS84.shp",DIR$Data))

plot.SIOFA <- ggplot() + 
      geom_tile(data=bathy,aes(x=long,y=lat,fill=depth)) + 
   labs(x="", y="") +
      geom_sf(data = world, fill = .COL$land, colour = "black") +
      geom_sf(data = SIOFA, fill = .COL$statarea, colour = "black") +
      geom_sf_label(data = SIOFA, aes(fill = NULL, label = SubAreaNo), col = "black", label.size = 0, nudge_y=c(-2,0,0, 0, 0, 0, 0, -6)) +	  
      coord_sf() +
      theme_bw() +
      theme(legend.position = "none") +
      coord_sf(xlim = c(24, 123), ylim = c(-58, 13), expand=F)
plot.SIOFA

Box<-c(0,123,-75,13)
boundary <- st_linestring(rbind(c(0,-50),c(30,-50),c(30,-45),c(80,-45),c(80,-55),c(140,-55)))
boundary <- st_sfc(boundary, crs="+proj=longlat +datum=WGS84 +no_defs")
ASD <- st_crop(ASD, extent(Box))	
EEZ <- st_crop(EEZ, extent(0,125,-75,15))	

plot.CCAMLR <- ggplot() + 
      geom_tile(data=bathy,aes(x=long,y=lat,fill=depth)) + labs(x="", y="") +
      geom_sf(data = world, fill = .COL$land, colour = "black") +
      geom_sf(data = boundary, col = "red", lwd = 1.4) +
      geom_sf(data = SIOFA, fill = .COL$statarea, colour = "black") +
      geom_sf_label(data = SIOFA, aes(fill = NULL, label = SubAreaNo), size = 2.5, col = "black", label.size = 0, nudge_y=c(-2,0,0, 0, 0, 0, 0, -6)) +	  
      geom_sf(data = ASD, fill = .COL$statarea, colour = "black") +
      geom_sf_label(data = ASD, aes(fill = NULL, label = ShortLabel), size = 2.5, col = "black", label.size = 0, nudge_y=c(0,0,0, 0, 0, 0, 0, 0)) +	  
      #geom_sf(data = SSRU, fill = .COL$statarea, colour = "red") +
      geom_sf(data = EEZ, fill = .COL$statarea, colour = .COL$points[1]) +
      coord_sf() +
      theme_bw() +
      theme(legend.position = "none") +
      coord_sf(xlim = c(0, 123), ylim = c(-70, 13), expand=F)
plot.CCAMLR

