# nzsf

New Zealand Spatial Features (nzsf) is a package for plotting shapefiles. For example:

    library(nzsf)
    
    proj <- "+proj=aea +lat_1=-30 +lat_2=-50 +lat=-40 +lon_0=175 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
    
    bbox <- get_coast() %>% 
        st_transform(crs = proj, check = TRUE) %>% 
        filter(name %in% c("North Island or Te Ika-a-Māui")) %>%
        st_bbox()
    
    ggplot() +
        plot_marine_reserves(fill = "green", colour = "green") +
        plot_qma(qma = "CRA", fill = NA) +
        plot_nz(fill = "black", colour = "black", size = 0.3) +
        annotation_north_arrow(location = "tr", which_north = "true", style = north_arrow_nautical) +
        annotation_scale(location = "br", unit_category = "metric") +
        coord_sf(xlim = bbox[c(1,3)], bbox[c(2,4)]) +
        theme_bw()

In this example New Zealands marine reserves, rock lobster Quota Management Areas (QMAs), and the New Zealand coastline is plotted. A north arrow and a scale is then added. And finally, the figure is retricted to the North Island only using the bounding box (`bbox`).
