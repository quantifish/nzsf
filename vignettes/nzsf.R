## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=TRUE, fig.height=6, fig.width=6, message=FALSE-----------------
library(nzsf)
library(ggspatial)

theme_set(theme_bw() + theme(axis.title = element_blank()))

get_statistical_areas(area = "EEZ")

ggplot() +
  plot_statistical_areas(area = "EEZ") +
  plot_coast(resolution = "low", fill = "black", colour = "black", size = 0.3) +
  annotation_north_arrow(location = "tr", which_north = "true", style = north_arrow_nautical) +
  annotation_scale(location = "br", unit_category = "metric")

## ----echo=TRUE, fig.height=6, fig.width=6, message=FALSE-----------------
bbox <- get_coast() %>% 
  filter(name %in% c("North Island or Te Ika-a-Māui")) %>%
  st_bbox()

ggplot() +
  plot_depth(colour = "lightblue") +
  plot_marine_reserves(fill = "red", colour = "red") +
  plot_qma(qma = "CRA", fill = NA) +
  plot_coast(fill = "grey", colour = NA, size = 0.3) +
  annotation_north_arrow(location = "tr", which_north = "true", style = north_arrow_nautical) +
  annotation_scale(location = "br", unit_category = "metric") +
  coord_sf(xlim = bbox[c(1, 3)], ylim = bbox[c(2, 4)])

## ----echo=TRUE, fig.height=6, fig.width=6, message=FALSE-----------------
library(lwgeom)

sf_jma <- get_qma("JMA")
sf_coast <- get_coast() %>% 
  st_combine() %>% 
  st_make_valid()
lab <- st_difference(sf_jma, sf_coast) %>% 
  st_point_on_surface()
# lab <- st_difference(sf_jma, sf_coast) %>% st_centroid()

ggplot() +
  plot_qma(qma = "JMA", fill = NA) +
  plot_statistical_areas(area = "JMA", fill = NA) +
  plot_coast(fill = "forestgreen", colour = NA, size = 0.3) +
  geom_sf_label(data = lab, aes(label = QMA)) +
  annotation_north_arrow(location = "tl", which_north = "true") +
  annotation_scale(location = "br", unit_category = "metric")

## ----echo=TRUE, fig.height=6, fig.width=6, message=FALSE-----------------
library(viridis)

proj <- "+proj=longlat +datum=WGS84 +no_defs"

data("Gisborne_TToR_Habitats")
Gisborne_TToR_Habitats <- Gisborne_TToR_Habitats %>% st_transform(crs = proj, check = TRUE)

data("Rocky_reef_National_NZ")
Rocky_reef_National_NZ <- Rocky_reef_National_NZ %>% st_transform(crs = proj, check = TRUE)

bbox <- get_marine_reserves() %>%
  st_transform(crs = proj, check = TRUE) %>%
  filter(Name == "Te Tapuwae o Rongokako Marine Reserve") %>%
  st_bbox()

ggplot() +
  geom_sf(data = Rocky_reef_National_NZ, fill = "lightgrey", colour = NA) +
  plot_depth(proj = proj, resolution = "med", size = 0.2, colour = "skyblue") +
  geom_sf(data = Gisborne_TToR_Habitats, aes(fill = Habitat), colour = NA) +
  scale_fill_viridis_d(alpha = 0.5) +
  plot_marine_reserves(proj = proj, fill = NA) +
  plot_coast(proj = proj, resolution = "med", fill = "black", colour = NA, size = 0.3) +
  annotation_scale(location = "br", unit_category = "metric") +
  coord_sf(xlim = bbox[c(1, 3)], ylim = bbox[c(2, 4)]) +
  labs(title = "Te Tapuwae o Rongokako Marine Reserve")

## ----echo=TRUE, fig.height=6, fig.width=12, message=FALSE----------------
library(patchwork)

stewart <- get_coast() %>%
  filter(name == "Stewart Island/Rakiura") %>%
  st_buffer(dist = 4500)
bbox <- stewart %>% st_bbox()

# Simulate some points around Stewart Island
pts <- st_sample(stewart, size = 5000) %>% st_sf() %>% mutate(z = rnorm(1:n()))

p1 <- ggplot() +
  plot_depth(resolution = "med", size = 0.2, colour = "grey") +
  geom_sf(data = pts, aes(colour = z)) +
  plot_coast(resolution = "med", fill = "black", colour = NA, size = 0.3) +
  annotation_north_arrow(location = "tl", which_north = "true", style = north_arrow_nautical) +
  annotation_scale(location = "br", unit_category = "metric") +
  coord_sf(xlim = bbox[c(1, 3)], ylim = bbox[c(2, 4)]) +
  labs(colour = "Points", title = "Rakiura")
p2 <- ggplot() +
  plot_depth(resolution = "med", size = 0.2, colour = "grey") +
  plot_raster(data = pts, field = "z", fun = mean, nrow = 50, ncol = 50) +
  scale_fill_viridis("Raster", alpha = 0.8, option = "plasma") +
  plot_coast(resolution = "med", fill = "black", colour = NA, size = 0.3) +
  annotation_north_arrow(location = "tl", which_north = "true", style = north_arrow_nautical) +
  annotation_scale(location = "br", unit_category = "metric") +
  coord_sf(xlim = bbox[c(1, 3)], ylim = bbox[c(2, 4)]) +
  labs(title = "Rakiura")
p1 + p2

