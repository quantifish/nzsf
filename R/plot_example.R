# Theme NZ
#
theme_nz <- theme_bw()



plot_raster <- function(data, field, fun = "sum", nrow = 100, ncol = 100, ...) {
  r_empty <- raster(data, nrow = nrow, ncol = ncol)
  ras <- rasterize(x = data, y = r_empty, field = field, fun = fun)
  gg_ras <- data.frame(rasterToPoints(ras)) %>% mutate(layer = ifelse(layer == 0, NA, layer))
  
  geom_raster(data = gg_ras, aes(x = x, y = y, fill = layer), ...)
}



# all
#
plot_example <- function () {

  sf_depth <- get_depth() %>% 
    st_transform(crs = proj, check = TRUE) %>%
    filter(depth %in% 100:1000)
  unique(sf_depth$depth)
  
  sf_coast <- get_coast() %>% st_transform(crs = proj, check = TRUE)
  #bbox <- st_bbox(sf_coast %>% filter(name %in% c("North Island or Te Ika-a-Māui","South Island or Te Waipounamu", "Chatham Island", "Stewart Island/Rakiura")))
  bbox <- st_bbox(sf_coast %>% filter(name %in% c("North Island or Te Ika-a-Māui")))
  
  CRA <- get_qma("CRA")

  theme_set(theme_linedraw(base_size = 17) +
             theme(legend.position = "none", strip.background = element_rect(fill = "orange"), strip.text = element_text(colour = 'black')))
  
  lab1 <- st_difference(st_cast(CRA, "MULTIPOLYGON"), st_combine(sf_coast)) %>% st_point_on_surface()
  lab1 <- CRA %>% st_point_on_surface()
  
  rpnts <- st_sample(CRA, size = 10000) %>% st_sf() %>% mutate(poop = rnorm(1:n()))
  ggplot() +
    plot_raster(data = rpnts, field = "poop") +
    scale_fill_viridis() +
    plot_coast(fill = "black", colour = "black", size = 0.3)
    
  
  ggplot() +
    # geom_sf(data = sf_depth, aes(colour = rev(depth))) +
    #plot_depth(aes(colour = depth), linetype = "solid") +
    #geom_sf(data = CRA, fill = NA) +
    #geom_sf_label(data = lab1, aes(label = area)) +
    # plot_cra_stats(fill = NA) +
    plot_marine_reserves(fill = "red", colour = "red") +
    plot_coast(fill = "black", colour = "black", size = 0.3) +
    #coord_sf(xlim = bbox[c(1,3)], bbox[c(2,4)]) +
    annotation_north_arrow(location = "tr", which_north = "true", style = north_arrow_nautical) +
    annotation_scale(location = "br", unit_category = "metric")

  
  #geom_sf_label(data = sf_lab, aes(label = CODE)) +
  #coord_sf(xlim = bbox[c(1,3)], ylim = c(-5900000, -2800000)) +
  #coord_sf(xlim = bbox[c(1,3)], bbox[c(2,4)]) +
  #labs(x = NULL, y = NULL) +
  #theme(axis.title = element_blank(), panel.grid = element_line(color = "darkgrey", linetype = 2))
}

# sf_lab <- st_difference(st_cast(sf_qma, "MULTIPOLYGON"), st_combine(sf_coast)) %>% st_centroid() %>% st_point_on_surface() %>% select(CODE)
# 
# ggplot() + 
#   #geom_sf(data = depth_sf_km, colour = "blue", linetype = "dotted") +
#   geom_sf(data = sf_stat, fill = NA, colour = "grey", linetype = "solid") +
#   geom_sf(data = sf_qma, fill = NA) +
#   geom_sf(data = sf_coast, fill = nz_fill, colour = "black", size = 0.3) +
#   geom_sf_label(data = sf_lab, aes(label = CODE)) +
#   coord_sf(xlim = bbox[c(1,3)], ylim = c(-5900000, -2800000)) +
#   labs(x = NULL, y = NULL, colour = "Depth (m)", linetype = "Depth (m)") +
#   annotation_north_arrow(location = "tl", which_north = "true", style = north_arrow_nautical) +
#   annotation_scale(location = "br", unit_category = "metric") +
#   theme(axis.title = element_blank(), panel.grid = element_line(color = "darkgrey", linetype = 2))

