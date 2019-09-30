# Theme NZ
#
theme_nz <- theme_bw()


# all
#
plot_example <- function () {
  ggplot() + 
    #plot_depth() +
    plot_nz() +
    annotation_north_arrow(location = "tl", which_north = "true", style = north_arrow_nautical) +
    annotation_scale(location = "br", unit_category = "metric")
}


# Depth around NZ
#
plot_depth <- function(colour = "blue", linetype = "dotted",
                       proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs") {

  shp <- "depth-contour-polyline-hydro-1350k-11500k"
  dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
  sf_depth <- st_read(dsn = dsn, layer = shp) %>%
    filter(VALDCO %in% c(200)) %>%
    rename(depth = VALDCO) %>%
    st_transform(crs = proj, check = TRUE)
  
  p <- geom_sf(data = sf_depth, colour = colour, linetype = linetype)
  p
}


# plot_nz
#
plot_nz <- function(fill = "orange", colour = "black",
                    proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs") {

  shp <- "nz-coastlines-and-islands-polygons-topo-150k"
  dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")

  sf_coast <- st_read(dsn = dsn, layer = shp) %>% 
    st_transform(crs = proj) %>%
    ms_simplify(keep = 0.001, keep_shapes = FALSE)
  
  bbox <- st_bbox(sf_coast %>% filter(name %in% c("North Island or Te Ika-a-Māui", 
                                                  "South Island or Te Waipounamu", 
                                                  "Chatham Island", "Stewart Island/Rakiura")))
  
  theme_set(theme_linedraw(base_size = 17) +
              theme(legend.position = "none", strip.background = element_rect(fill = "orange"), strip.text = element_text(colour = 'black')))
  
  #geom_sf(data = depth_sf_km, colour = "blue", linetype = "dotted") +
  #geom_sf(data = sf_stat, fill = NA, colour = "grey", linetype = "solid") +
  #geom_sf(data = sf_qma, fill = NA) +
  #p <- ggplot() +
  p <- geom_sf(data = sf_coast, fill = fill, colour = colour, size = 0.3) +
    #geom_sf_label(data = sf_lab, aes(label = CODE)) +
    #coord_sf(xlim = bbox[c(1,3)], ylim = c(-5900000, -2800000)) +
    coord_sf(xlim = bbox[c(1,3)], bbox[c(2,4)]) +
    labs(x = NULL, y = NULL) +
    theme(axis.title = element_blank(), panel.grid = element_line(color = "darkgrey", linetype = 2))
  return(p)
}
