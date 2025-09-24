StatCI <- ggplot2::ggproto(
  "StatCI",
  ggplot2::Stat,
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
  ggplot2::Geom,
  required_aes = c("x", "y", "ymin", "ymax", "linewidth"),
  default_aes = ggplot2::aes(
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

#' Graded error bars
#'
#' Plot graded error bars defined by `x`, `y`, and `se`. This draws a set of
#'     overlapping line ranges, at different confidence interval widths.
#'
#' @param mapping Set of aesthetic mappings created by [ggplot2::aes()]. If
#'     specified and `inherit.aes = TRUE` (the default), it is combined with the
#'     default mapping at the top level of the plot. You must supply mapping if
#'     there is no plot mapping.
#' @param data The data to be displayed in this layer. There are three options:
#' 
#'     If NULL, the default, the data is inherited from the plot data as
#'     specified in the call to [ggplot2::ggplot()].
#' 
#'     A data.frame, or other object, will override the plot data. All objects
#'     will be fortified to produce a data frame. See [ggplot2::fortify()] for
#'     which variables will be created.
#' 
#'     A function will be called with a single argument, the plot data. The
#'     return value must be a data.frame, and will be used as the layer data. A
#'     function can be created from a formula (e.g. `~ head(.x, 10)`).
#' @param conf.levels The confidence interval bands to display, from narrowest
#'     to widest. These are specified on the 0--1 scale (e.g. 0.5 for 50% CI).
#' @param widths Corresponding widths of the range bars. Must be a vector of the
#'     same length as `conf.levels`.
#' @param geom The geometric object to use to display the data for this layer.
#'     When using a `stat_*()` function to construct a layer, the `geom`
#'     argument can be used to override the default coupling between stats and
#'     geoms. The `geom` argument accepts the following:
#'     * A `Geom` ggproto subclass, for example `GeomPoint`.
#'     * A string naming the geom. To give the geom as a string, strip the
#'       function name of the `geom_` prefix. For example, to use `geom_point()`,
#'       give the geom as `"point"`.
#'     * For more information and other ways to specify the geom, see the
#'       [layer geom][ggplot2::layer_geoms] documentation.
#' @param stat The statistical transformation to use on the data for this layer.
#'     When using a `geom_*()` function to construct a layer, the `stat`
#'     argument can be used to override the default coupling between geoms and
#'     stats. The `stat` argument accepts the following:
#'     * A `Stat` ggproto subclass, for example `StatCount`.
#'     * A string naming the stat. To give the stat as a string, strip the
#'       function name of the `stat_` prefix. For example, to use
#'       `stat_count()`, give the stat as `"count"`.
#'     * For more information and other ways to specify the stat, see the
#'       [layer stat][ggplot2::layer_stats] documentation.
#' @param position A position adjustment to use on the data for this layer. This
#'     can be used in various ways, including to prevent overplotting and
#'     improving the display. The `position` argument accepts the following:
#'     * The result of calling a position function, such as `position_jitter()`.
#'       This method allows for passing extra arguments to the position.
#'     * A string naming the position adjustment. To give the position as a
#'       string, strip the function name of the `position_` prefix. For example,
#'       to use `position_jitter()`, give the position as `"jitter"`.
#'     * For more information and other ways to specify the position, see the
#'       [layer position][ggplot2::layer_positions] documentation.
#' @param show.legend logical. Should this layer be included in the legends?
#'     `NA`, the default, includes if any aesthetics are mapped.
#'     `FALSE` never includes, and `TRUE` always includes.
#'     It can also be a named logical vector to finely select the aesthetics to
#'     display. To include legend keys for all levels, even when no data exists,
#'     use `TRUE`.  If `NA`, all levels are shown in legend, but unobserved
#'     levels are omitted.
#' @param inherit.aes If `FALSE`, overrides the default aesthetics, rather than
#'     combining with them. This is most useful for helper functions that define
#'     both data and aesthetics and shouldn't inherit behaviour from the default
#'     plot specification.
#' @param ... Other arguments passed on to [ggplot2::layer()]'s `params`
#'     argument.
#' @name geom_ci
NULL

#' @rdname geom_ci
#' @export
stat_ci <- function(
  mapping = NULL,
  data = NULL,
  conf.levels = c(0.5, 0.8, 0.9, 0.95, 0.99),
  widths = c(1.5, 1.3, 1, 0.5, 0.2),
  geom = GeomCI,
  position = "identity",
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
      conf.levels = conf.levels,
      widths = widths,
      ...
    )
  )
}

#' @rdname geom_ci
#' @export
geom_ci <- function(
  mapping = NULL,
  data = NULL,
  conf.levels = c(0.5, 0.8, 0.9, 0.95, 0.99),
  widths = c(2, 1.5, 1, 0.5, 0.2),
  stat = StatCI,
  position = "identity",
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
      conf.levels = conf.levels,
      widths = widths,
      ...
    )
  )
}
