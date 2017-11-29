library(tidyverse)
library(jsonlite)

mnf <- function(a, b, c) {
  root <- sqrt(b ** 2 - 4 * a * c)
  data.frame(x1 = (-b + root) / (2 * a),  x2 = (-b - root) / (2 * a)) 
}

create_trials <- function(t_box = 2000, 
                          x_box = 800,
                          x_max = 1200,
                          vs = seq(x_box / t_box, 0, - x_box / t_box / 4)) {
  vs %>% 
    map_df(function(v) {
      list(
        t_box = t_box, 
        x_box = x_box, 
        x_max = x_max, 
        v = v, 
        a = (x_box - v * t_box) / t_box^2 * 2
      )
    }) %>% 
    mutate(
      t_max = mnf(0.5 * a, v, - x_max)[[1]],
      t_max = if_else(is.na(t_max), t_box * (x_max / x_box), t_max),
      x_box_num_acc = v * t_box + 0.5 * a * t_box ** 2
    )
}

trials <- seq(1500, 3500, 500) %>% 
  map(create_trials) %>% 
  bind_rows()

json_trials <- toJSON(trials)


