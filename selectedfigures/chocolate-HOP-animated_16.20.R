source("../_common.R")

library(gganimate)

cacao %>% 
  filter(location %in% c("Canada", "U.S.A.")) %>%
  mutate(location = fct_recode(location, US = "U.S.A.")) -> cacao_US_CA

set.seed(49316)
n <- 30

CA_ratings <- sample_n(filter(cacao_US_CA, location == "Canada"), n, replace = TRUE) %>%
  mutate(.draw = 1:n())
US_ratings <- sample_n(filter(cacao_US_CA, location == "US"), n, replace = TRUE) %>%
  mutate(.draw = 1:n())

sample_df <- rbind(CA_ratings, US_ratings) %>%
  mutate(location = fct_relevel(location, "US", "Canada"))

ggplot(sample_df) +
  geom_segment(
    aes(
      x = rating, xend = rating,
      y = as.integer(location) - 0.35,
      yend = as.integer(location) + 0.35,
      group = .draw
    ),
    size = 1.5, color = darken("#009E73", .3)
  ) +
  scale_x_continuous(
    limits = c(1.95, 4.1),
    expand = c(0, 0),
    name = "chocolate flavor rating"
  ) +
  scale_y_discrete(
    name = NULL,
    limits = c("US", "Canada"),
    expand = c(0, 0.25)
  ) +
  theme_dviz_hgrid() +
  theme(
    axis.line.x = element_line(color = "black"),
    axis.ticks.x = element_line(color = "black"),
    axis.title.x = element_text(hjust = 1),
    axis.line.y = element_blank(),
    axis.ticks.y = element_blank(),
    strip.text = element_blank()
  ) + 
  #panel_border() +
  transition_states(.draw, 1, 2)
