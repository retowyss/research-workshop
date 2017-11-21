create_trials <- function(t, d = 800, vs = seq(d / t, 0, - d / t / 10)) {
  x <- purrr::map_df(vs, function(v) {
    list(
      v = v,
      a = (d - v * t) / t^2 * 2
    )
  })
  jsonlite::toJSON(x)
}
