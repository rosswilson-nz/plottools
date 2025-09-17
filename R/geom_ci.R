StatCI <- ggplot2::ggproto(
  "StatCI",
  Stat,
  compute_group = function(data, scales, conf.levels, widths) {
    out <- data.frame(
      conf.level = numeric(),
      x = numeric(),
      y = numeric(),
      ymin = numeric(),
      ymax = numeric(),
      linewidth = numeric()
    )
    for (i in seq_along(conf.levels)) {
      level <- conf.levels[[i]]
      p <- 1 - ((1 - level) / 2)
      df <- data.frame(
        conf.level = level * 100,
        x = data$x,
        y = data$y,
        se = data$se,
        ymin = data$y - qnorm(p) * data$se,
        ymax = data$y + qnorm(p) * data$se,
        linewidth = widths[[i]]
      )
      out <- rbind(out, df)
    }
    out
  },
  required_aes = c("x", "y", "se")
)

GeomCI <- ggplot2::ggproto(
  "GeomCI",
  Geom,
  required_aes = c("x", "y", "ymin", "ymax", "linewidth"),
  default_aes = aes(
    colour = "black",
    alpha = 0.2
  ),
  draw_panel = function(data, panel_params, coord, ...) {
    components <- lapply(unique(data$conf.level), \(level) {
      GeomLinerange$draw_panel(
        data[data$conf.level == level, , drop = FALSE],
        panel_params,
        coord,
        ...
      )
    })
    rlang::exec(grid::gList, !!!components)
  }
)

stat_ci <- function(
  mapping = NULL,
  data = NULL,
  conf.levels = c(0.5, 0.8, 0.9, 0.95, 0.99),
  widths = c(1.5, 1.3, 1, 0.5, 0.2),
  geom = GeomCI,
  position = "identity",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  ggplot2::layer(
    stat = StatCI,
    data = data,
    mapping = mapping,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      conf.levels = conf.levels,
      widths = widths,
      ...
    )
  )
}

geom_ci <- function(
  mapping = NULL,
  data = NULL,
  conf.levels = c(0.5, 0.8, 0.9, 0.95, 0.99),
  widths = c(2, 1.5, 1, 0.5, 0.2),
  stat = StatCI,
  position = "identity",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  ggplot2::layer(
    geom = GeomCI,
    data = data,
    mapping = mapping,
    stat = stat,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      conf.levels = conf.levels,
      widths = widths,
      ...
    )
  )
}
