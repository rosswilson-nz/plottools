#' Show available CMOR colour palettes
#'
#' List or plot the currently available CMOR colour palettes.
#'
#' @export
plot_cmor_colours <- function() {
  out <- data.frame(palette = character(), value = character())
  for (i in names(cmor_palettes))
    out <- rbind(
      out,
      data.frame(palette = i, value = cmor_palettes[[i]], y = seq_along(cmor_palettes[[i]]))
    )
  out$palette <- factor(out$palette, rev(unique(out$palette)))

  ggplot2::ggplot(out, ggplot2::aes(.data$palette, .data$y, fill = .data$value)) +
    ggplot2::geom_tile(width = 0.8, linetype = 1, colour = "black") +
    ggplot2::scale_fill_identity() +
    ggplot2::scale_x_discrete(NULL) +
    ggplot2::scale_y_discrete(NULL) +
    ggplot2::coord_flip() +
    ggplot2::theme_void() +
    ggplot2::theme(axis.text = ggplot2::element_text(hjust = 1))
}

#' @rdname plot_cmor_colours
#' @export
plot_cmor_colors <- function() plot_cmor_colours()

#' @rdname plot_cmor_colours
#' @export
list_cmor_colours <- function() names(cmor_palettes)

#' @rdname plot_cmor_colours
#' @export
list_cmor_colors <- function() list_cmor_colours()
