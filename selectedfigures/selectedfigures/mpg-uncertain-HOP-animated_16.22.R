source("../_common.R")

library(gganimate)
library(mgcv)
library(ungeviz)

# devtools::install_github("thomasp85/transformr")

#set.seed(8692282)
set.seed(8692276)

fit <- gam(mpg ~ s(disp, bs = 'cr', k = 5), data = mtcars, method = "REML")

newdata <- data.frame(disp = seq(min(mtcars$disp), max(mtcars$disp), length.out = 100))
sample_df <- sample_outcomes(fit, newdata, 20, unconditional = TRUE)

ggplot(mtcars, aes(x = disp, y = mpg)) + 
  scale_x_continuous(
    name = "displacement (cu. in.)",
    expand = c(0.03, 0)
  ) +
  scale_y_continuous(
    name = "fuel efficiency (mpg)",
    limits = c(8.5, 35),
    expand = c(0, 0)
  ) +
  geom_point(color = "grey60") +
  geom_line(data = sample_df, aes(group = .draw), color = "#0072B2", size = 0.5) +
  theme_dviz_grid() +
  theme(
    strip.text = element_blank(),
    axis.ticks = element_blank(),
    axis.ticks.length = unit(0, "pt"),
    plot.margin = margin(7, 1.5, 3.5, 1.5)
  ) +
  panel_border() +
  transition_states(.draw, 0, 1)
