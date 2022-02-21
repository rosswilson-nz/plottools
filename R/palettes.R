cmor_pal <- function(palette = "CUD", direction = 1, grey = FALSE) {
  ## Options to be added (?):
  ### `type` String: similar to ColorBrewer's `type`
  pal <- cmor_pal_name(palette)
  force(direction)
  function(n) {
    max_n <- max_pal_n(pal)
    check_pal_n(n, max_n, pal)
    if (grey) n <- n - 1
    ret <- cmor_palettes[[pal]][seq_len(n)]
    if (direction == -1) ret <- rev(ret)
    if (grey) ret <- c(ret, cmor_palette_greys[[pal]])
    ret
  }
}

cmor_pal_name <- function(palette) {
  if (rlang::is_scalar_character(palette)) {
    if (!palette %in% names(cmor_palettes)) stop_unknown_palette("character", palette)
    palette
  }
  else if (rlang::is_scalar_integerish(palette) && palette > 0) {
    if (palette > 8) stop_unknown_palette("numeric", palette)
    names(cmor_palettes)[palette]
  } else stop_unknown_palette("unknown")
}

max_pal_n <- function(pal) {
  length(cmor_palettes[[pal]])
}

check_pal_n <- function(n, max_n, pal) {
  if (n > max_n) stop_too_many_colours(n, max_n, pal)
}

cmor_palettes <- list(
  CUD = grDevices::rgb(c(230, 86, 0, 240, 0, 213, 204, 0),
                       c(159, 180, 158, 228, 114, 94, 121, 0),
                       c(0, 233, 115, 66, 178, 0, 167, 0), maxColorValue = 255),
  Bright = grDevices::rgb(c(68, 238, 34, 204, 102, 170, 187),
                          c(119, 102, 136, 187, 204, 51, 187),
                          c(170, 119, 51, 68, 238, 119, 187), maxColorValue = 255),
  "High-Contrast" = grDevices::rgb(c(0, 221, 187, 0), c(68, 170, 85, 0), c(136, 51, 102, 0),
                                   maxColorValue = 255),
  Vibrant = grDevices::rgb(c(238, 0, 51, 238, 204, 0, 187),
                           c(119, 119, 187, 51, 51, 153, 187),
                           c(51, 187, 238, 119, 17, 136, 187), maxColorValue = 255),
  Muted = grDevices::rgb(c(204, 51, 221, 17, 136, 136, 68, 153, 170, 221),
                         c(102, 34, 204, 119, 204, 34, 170, 153, 68, 221),
                         c(119, 136, 119, 51, 238, 85, 153, 51, 153, 221), maxColorValue = 255),
  "Medium-Contrast" = grDevices::rgb(c(102, 0, 238, 153, 238, 153, 255, 0),
                                     c(153, 68, 204, 119, 153, 68, 255, 0),
                                     c(204, 136, 102, 0, 170, 85, 255, 0), maxColorValue = 255),
  Light = grDevices::rgb(c(119, 238, 238, 255, 153, 68, 187, 170, 221),
                         c(170, 136, 221, 170, 221, 187, 204, 170, 221),
                         c(221, 102, 136, 187, 255, 153, 51, 0, 221), maxColorValue = 255),
  Paired = grDevices::rgb(c(178, 94, 253, 230, 247),
                          c(171, 60, 187, 97, 247),
                          c(210, 153, 99, 1, 247), maxColorValue = 255)
)

cmor_palette_greys <- list(
  CUD = grDevices::rgb(0, 0, 0),
  Bright = grDevices::rgb(187, 187, 187, maxColorValue = 255),
  "High-Contrast" = grDevices::rgb(0, 0, 0),
  Vibrant = grDevices::rgb(187, 187, 187, maxColorValue = 255),
  Muted = grDevices::rgb(221, 221, 221, maxColorValue = 255),
  "Medium-Contrast" = grDevices::rgb(0, 0, 0),
  Light = grDevices::rgb(221, 221, 221, maxColorValue = 255),
  Paired = grDevices::rgb(247, 247, 247, maxColorValue = 255)
)
