# nzsf

New Zealand Spatial Features is a package for plotting shapefiles.

    ggplot() +
        geom_sf(data = CRA, fill = NA) +
        plot_marine_reserves(fill = "green", colour = "green") +
        plot_nz(fill = "black", colour = "black", size = 0.3) +
        annotation_north_arrow(location = "tl", which_north = "true", style = north_arrow_nautical) +
        annotation_scale(location = "br", unit_category = "metric")
