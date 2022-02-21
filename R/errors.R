stop_unknown_palette <- function(type, palette) {
  x <- if (type == "numeric") {
    c("Only 8 colour palettes are defined.",
      x = paste0(" You've provided `palette = ", palette, "`."))
  } else if (type == "character") {
    c("Unknown colour palette.",
      x = paste0(" You've provided `palette = ", palette, "`."),
      i = "Use `list_cmor_colours()` to list the available colour palettes.")
  } else "Unknown colour palette."
  rlang::abort(x, "CMORplots_error_unknown_palette", type = type, palette = palette)
}

stop_too_many_colours <- function(n, max_n, pal) {
  x <- c(paste0("Palette '", pal, "' has a maximum of ", max_n, " colours."),
         x = paste0(" You've provided `n = ", n, "`."))
  rlang::abort(x, "CMORplots_error_too_many_colours", n = n, max_n = max_n, pal = pal)
}
