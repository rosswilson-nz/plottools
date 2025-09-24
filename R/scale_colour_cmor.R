#' CMOR standard colour scales
#'
#' Several standard colour schemes for CMOR outputs. Only qualitative
#'     (including paired) scales are currently implemented (sequential,
#'     diverging, and continuous scales are planned).
#'
#' All included palettes are colour-blind friendly.
#'
#' Sources:
#'
#' \code{CUD}: 'Color Universal Design' palette
#'     (https://jfly.uni-koeln.de/color/#pallet)
#'
#' \code{Bright}, \code{High-Contrast}, \code{Vibrant}, \code{Muted},
#'     \code{Medium-Contrast}, \code{Light}:
#'     https://personal.sron.nl/~pault/#sec:qualitative
#'
#' \code{Paired}: ColorBrewer 4-class PuOr
#'     (https://colorbrewer2.org/#type=diverging&scheme=PuOr&n=4)
#'
#' @param ... Passed on to \code{\link[ggplot2]{discrete_scale}} to control
#'     name, limits, breaks, etc.
#' @param palette If a string, will use that named palette; if a number, will
#'     index into the list of available palettes.
#' @param direction Sets the order of colours in the scale (1 for standard, -1
#'     for reversed).
#' @param grey If \code{TRUE}, a grey/black colour will always be used as the
#'     last group colour (regardless of the number of groups in the data). If
#'     \code{FALSE} (the default), the colours and their order is as in the
#'     original source palette.
#' @param aesthetics Which aesthetic(s) should the scale work with. This can be
#'     useful, for example, to apply the same settings to both the
#'     \code{colour} and \code{fill} aesthetics simultaneously.
#'
#' @name scale_colour_cmor
NULL

#' @rdname scale_colour_cmor
#' @export
scale_colour_cmor <- function(..., palette = 1, direction = 1, grey = FALSE,
                              aesthetics = "colour") {
  ggplot2::discrete_scale(
    aesthetics,
    palette = cmor_pal(palette, direction, grey),
    ...
  )
}

#' @rdname scale_colour_cmor
#' @export
scale_color_cmor <- function(..., palette = 1, direction = 1, grey = FALSE,
                             aesthetics = "colour") {
  ggplot2::discrete_scale(
    aesthetics,
    palette = cmor_pal(palette, direction, grey),
    ...
  )
}

#' @rdname scale_colour_cmor
#' @export
scale_fill_cmor <- function(..., palette = 1, direction = 1, grey = FALSE,
                            aesthetics = "fill") {
  ggplot2::discrete_scale(
    aesthetics,
    palette = cmor_pal(palette, direction, grey),
    ...
  )
}
