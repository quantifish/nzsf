# devtools::install_github("GuangchuangYu/hexSticker")
library(hexSticker)
library(nzsf)
library(ggspatial)

p <- ggplot() +
  plot_coast(resolution = "low", fill = "orange", colour = NA, size = 0.3) +
  theme_void() + 
  theme_transparent()

# Generate sticker

sticker(p, package = "nzsf", 
        h_color = "orange", h_fill = "#1881C2", 
        #spotlight = TRUE, l_x = 0.8, l_y = 1,
        p_y = 1.65, p_size = 20, p_color = "orange",
        s_x = 1, s_y = 0.85, s_width = 1.3, s_height = 1.3, 
        filename = "man/figures/logo.png")
