#' Plot CRA labels
#' 
#' @param feature a spatial feature data.
#' @param proj The projection to use.
#' @param qma a spatial feature data.
#' @param area the field to rasterize.
#' @param ... the field to rasterize.
#' @return a \code{ggplot2} geom.
#' @import dplyr
#' @importFrom sf st_combine st_buffer st_make_valid st_difference st_centroid st_point
#' @export
#' 
geom_cra <- function(feature = "label", proj = proj_nzsf(),
                     qma = NULL, area = NULL, ...) {
  
  coast <- get_coast(resolution = "medium") %>% 
    st_combine() %>% 
    st_buffer(dist = 4500) %>%
    st_make_valid()
  
  labs <- get_statistical_areas("CRA") %>%
    st_difference(coast) %>% 
    st_centroid() %>%
    dplyr::select(.data$QMA, .data$area)

  labs$geometry[labs$area == 905] <- st_point(c(21042, 454394)) # CRA 2
  labs$geometry[labs$area == 907] <- st_point(c(156026, 276000))
  
  labs$geometry[labs$area == 909] <- st_point(c(325000, 247645.9)) # CRA 3
  labs$geometry[labs$area == 910] <- st_point(c(297000, 152074.9))
  labs$geometry[labs$area == 911] <- st_point(c(249018.7, 66000))
  
  labs$geometry[labs$area == 912] <- st_point(c(191000, 23806.92)) # CRA 4
  labs$geometry[labs$area == 913] <- st_point(c(120000, -98027.46))
  
  labs$geometry[labs$area == 916] <- st_point(c(-52882, -200000)) # 916
  labs$geometry[labs$area == 917] <- st_point(c(-116704.7, -300000)) # 917
  labs$geometry[labs$area == 918] <- st_point(c(-145000, -433466)) # 918
  labs$geometry[labs$area == 919] <- st_point(c(-287000, -500855.2)) # 919
  labs$geometry[labs$area == 932] <- st_point(c(-169000, -78064)) # 932
  labs$geometry[labs$area == 933] <- st_point(c(-80000, -71000)) # 933
  
  labs$geometry[labs$area == 940] <- st_point(c(644000, -420000)) # 940
  labs$geometry[labs$area == 941] <- st_point(c(710000, -470000)) # 941
  labs$geometry[labs$area == 942] <- st_point(c(710000, -497000)) # 942
  labs$geometry[labs$area == 943] <- st_point(c(644000, -480000)) # 943
  
  labs$geometry[labs$area == 920] <- st_point(c(-302000, -611022)) # CRA 7
  labs$geometry[labs$area == 921] <- st_point(c(-349800, -701800))
  # lab78 <- bind_rows(lab7, lab8)
  # lab78$geometry[1] <- st_point(c(-289000, -611022)) # 920
  # lab78$geometry[2] <- st_point(c(-330000, -706800)) # 921
  
  labs$geometry[labs$area == 922] <- st_point(c(-430815, -796000)) # CRA 8
  labs$geometry[labs$area == 923] <- st_point(c(-526000, -747000))
  labs$geometry[labs$area == 924] <- st_point(c(-579832, -805969))
  labs$geometry[labs$area == 925] <- st_point(c(-650000, -933000))
  labs$geometry[labs$area == 926] <- st_point(c(-622000, -755000))
  labs$geometry[labs$area == 927] <- st_point(c(-640000, -570000))
  labs$geometry[labs$area == 928] <- st_point(c(-530000, -440000))
  labs$geometry[labs$area == 929] <- st_point(c(-371183, -318000))
  
  if (!is.null(qma) & !is.null(area)) {
    labs <- labs %>% filter(.data$QMA %in% qma | .data$area %in% area)
  } else if (!is.null(qma) & is.null(area)) {
    labs <- labs %>% filter(.data$QMA %in% qma)
  } else if (is.null(qma) & !is.null(area))  {
    labs <- labs %>% filter(.data$area %in% area)
  }

  # geom_sf_text(data = lab %>% filter(QMA %in% stock), aes(label = QMA), size = 5.5, nudge_x = -60000, nudge_y = 20000) +
  p <- geom_sf_label(data = labs, aes(label = .data$area), ...)
  
  return(p)
}
