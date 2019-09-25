# plot_nz
#
plot_nz <- function(nz_fill = "orange", 
                    proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs") {

  dsn <- system.file("extdata", "nz-coastlines-and-islands-polygons-topo-150k.shp", package = "nzsf")

  sf_coast <- st_read(dsn = dsn, layer = "nz-coastlines-and-islands-polygons-topo-150k") %>% 
    st_transform(crs = proj) %>%
    ms_simplify(keep = 0.001, keep_shapes = FALSE)
  
  bbox <- st_bbox(sf_coast %>% filter(name %in% c("North Island or Te Ika-a-Māui", 
                                                  "South Island or Te Waipounamu", 
                                                  "Chatham Island", "Stewart Island/Rakiura")))
  
  theme_set(theme_linedraw(base_size = 17) +
              theme(legend.position = "none", strip.background = element_rect(fill = "orange"), strip.text = element_text(colour = 'black')))
  
  ggplot() + 
    #geom_sf(data = depth_sf_km, colour = "blue", linetype = "dotted") +
    #geom_sf(data = sf_stat, fill = NA, colour = "grey", linetype = "solid") +
    #geom_sf(data = sf_qma, fill = NA) +
    geom_sf(data = sf_coast, fill = nz_fill, colour = "black", size = 0.3) +
    #geom_sf_label(data = sf_lab, aes(label = CODE)) +
    #coord_sf(xlim = bbox[c(1,3)], ylim = c(-5900000, -2800000)) +
    coord_sf(xlim = bbox[c(1,3)], bbox[c(2,4)]) +
    labs(x = NULL, y = NULL) +
    annotation_north_arrow(location = "tl", which_north = "true", style = north_arrow_nautical) +
    annotation_scale(location = "br", unit_category = "metric") +
    theme(axis.title = element_blank(), panel.grid = element_line(color = "darkgrey", linetype = 2))
}
