
proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"

sf_coast <- st_read(dsn = "inst/extdata", layer = "nz-coastlines-and-islands-polygons-topo-150k") %>% 
  st_transform(crs = proj) %>%
  rmapshaper::ms_simplify(keep = 0.001, keep_shapes = FALSE)
depth_sf_km <- st_read(dsn = "inst/extdata", layer = "depth-contour-polyline-hydro-1350k-11500k") %>%
  filter(VALDCO %in% c(200)) %>%
  rename(depth = VALDCO) %>%
  st_transform(crs = proj, check = TRUE)
sf_qma <- st_read(dsn = "inst/extdata", layer = "QMA_Spiny_Red_Rocklobster") %>% st_transform(crs = proj)
sf_stat <- st_read(dsn = "inst/extdata", layer = "rock_lobster_stat_areas") %>% st_transform(crs = proj)


theme_set(theme_linedraw(base_size = 17) +
            theme(legend.position = "none", strip.background = element_rect(fill = "orange"), strip.text = element_text(colour = 'black')))

nz_fill <- "orange"
#nz_fill <- "darkgreen"

sf_lab <- st_difference(st_cast(sf_qma, "MULTIPOLYGON"), st_combine(sf_coast)) %>%
  #st_centroid() %>% 
  st_point_on_surface() %>%
  select(CODE)
bbox <- st_bbox(sf_stat)

ggplot() + 
  #geom_sf(data = depth_sf_km, colour = "blue", linetype = "dotted") +
  geom_sf(data = sf_stat, fill = NA, colour = "grey", linetype = "solid") +
  geom_sf(data = sf_qma, fill = NA) +
  geom_sf(data = sf_coast, fill = nz_fill, colour = "black", size = 0.3) +
  geom_sf_label(data = sf_lab, aes(label = CODE)) +
  coord_sf(xlim = bbox[c(1,3)], ylim = c(-5900000, -2800000)) +
  labs(x = NULL, y = NULL, colour = "Depth (m)", linetype = "Depth (m)") +
  annotation_north_arrow(location = "tl", which_north = "true", style = north_arrow_nautical) +
  annotation_scale(location = "br", unit_category = "metric") +
  theme(axis.title = element_blank(), panel.grid = element_line(color = "darkgrey", linetype = 2))


