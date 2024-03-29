#' nzsf theme
#' 
#' A ggplot2 theme for nzsf
#'
#' @param base_size base font size
#' @param base_family base font family
#' @import ggplot2
#' @export
#' 
theme_nzsf <- function(base_size = 14, base_family = "") {
  theme_grey(base_size = base_size, base_family = base_family) %+replace%
    theme(axis.title.x = element_text(margin = margin(10, 0, 0, 0)),
          #axis.title.x = element_text(vjust = -1.5),
          #axis.title.y = element_text(margin = margin(0, 20, 0, 0)),
          #axis.title.y = element_text(vjust = -0.1),
          axis.text = element_text(size = rel(0.8)),
          axis.ticks = element_line(colour = "black"), 
          legend.key = element_rect(colour = "grey80"),
          panel.background = element_rect(fill = "white", colour = NA),
          panel.border = element_rect(fill = NA, colour = "grey50"),
          panel.grid.major = element_line(colour = "grey90", size = 0.2),
          panel.grid.minor = element_line(colour = "grey98", size = 0.5),
          strip.background = element_rect(fill = "grey80", colour = "grey50", size = 0.2))
  #theme(axis.title = element_blank(), panel.grid = element_line(color = "darkgrey", linetype = 2))
}
