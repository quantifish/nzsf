# Theme NZ
#
theme_nz <- theme_bw()


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
    scale_fill_viridis()
    
  
  ggplot() +
    # geom_sf(data = sf_depth, aes(colour = rev(depth))) +
    #plot_depth(aes(colour = depth), linetype = "solid") +
    geom_sf(data = CRA, fill = NA) +
    geom_sf_label(data = lab1, aes(label = area)) +
    # plot_cra_stats(fill = NA) +
    plot_marine_reserves(fill = "red", colour = "red") +
    plot_nz(fill = "black", colour = "black", size = 0.3) +
    coord_sf(xlim = bbox[c(1,3)], bbox[c(2,4)]) +
    annotation_north_arrow(location = "tr", which_north = "true", style = north_arrow_nautical) +
    annotation_scale(location = "br", unit_category = "metric")

  
  #geom_sf_label(data = sf_lab, aes(label = CODE)) +
  #coord_sf(xlim = bbox[c(1,3)], ylim = c(-5900000, -2800000)) +
  #coord_sf(xlim = bbox[c(1,3)], bbox[c(2,4)]) +
  #labs(x = NULL, y = NULL) +
  #theme(axis.title = element_blank(), panel.grid = element_line(color = "darkgrey", linetype = 2))
}



plot_raster <- function(data, field, fun = "sum", nrow = 100, ncol = 100, ...) {
  #r_empty <- raster(data, nrow = nrow, ncol = ncol)
  r_empty <- raster(data, nrow = nrow, ncol = ncol)
  #projection(r_empty) <- st_crs(data)
  ras <- rasterize(x = data, y = r_empty, field = field, fun = fun)
  gg_ras <- data.frame(rasterToPoints(ras)) %>% mutate(layer = ifelse(layer == 0, NA, layer))
  
  geom_raster(data = gg_ras, aes(x = x, y = y, fill = layer), ...)
  #scale_fill_viridis(ctitle, direction = 1, option = "C", na.value = "grey90")
}


get_qma <- function(qma = "CRA",
                    proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs") {
  if (qma %in% c("CRA")) {
    shp <- "SpinyRedRockLobster_QMAs"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("PHC")) {
    shp <- "QMA_Packhorse_rocklobster_region"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = CODE)
  }
  if (qma %in% c("PAU")) {
    shp <- "Paua_QMAs"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("COC")) {
    shp <- "Cockle_QMAs"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("HAK")) {
    shp <- "HAKE_QMA"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("HOK")) {
    shp <- "HOKI_QMA"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (qma %in% c("LIN")) {
    shp <- "LING_QMA"
    dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
    sf_x <- st_read(dsn = dsn, layer = shp) %>% rename(area = FishstockC)
  }
  if (is.null(proj)) {
    sf_x
  } else {
    sf_x %>% 
      st_transform(crs = proj, check = TRUE) %>% 
      st_union(by_feature = TRUE)
  }
}

get_marine_reserves <- function() {
  shp <- "doc-marine-reserves"
  dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
  x <- st_read(dsn = dsn, layer = shp)
  x
}

get_coast <- function(keep = 0.05) {
  shp <- "nz-coastlines-and-islands-polygons-topo-150k"
  dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
  x <- st_read(dsn = dsn, layer = shp) %>% ms_simplify(keep = keep, keep_shapes = FALSE)
  x
}

get_cra_stats <- function() {
  shp <- "rock_lobster_stat_areas"
  dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
  x <- st_read(dsn = dsn, layer = shp) %>% rename(area = AREA_CODE)
  x
}

get_depth <- function() {
  shp <- "depth-contour-polyline-hydro-1350k-11500k"
  dsn <- system.file("extdata", paste0(shp, ".shp"), package = "nzsf")
  x <- st_read(dsn = dsn, layer = shp) %>% rename(depth = VALDCO)
  x
}




plot_marine_reserves <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", ...) {
  x <- get_marine_reserves() %>% st_transform(crs = proj, check = TRUE)
  geom_sf(data = x, ...)
}

plot_cra_stats <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", ...) {
  x <- get_cra_stats() %>% st_transform(crs = proj, check = TRUE)
  geom_sf(data = x, ...)
}

# Depth around NZ
#
plot_depth <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", ...) {
  x <- get_depth() %>% st_transform(crs = proj, check = TRUE)# %>% filter(depth %in% c(200))
  geom_sf(data = x, ...)
}

# plot_nz
#
plot_nz <- function(proj = "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs", 
                    keep = 0.05, ...) {
  x <- get_coast(keep = keep) %>% st_transform(crs = proj, check = TRUE)
  geom_sf(data = x, ...)
}
