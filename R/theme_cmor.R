#' Classic `ggplot` Theme for CMOR Outputs
#'
#' This is a preliminary draft of a standard CMOR ggplot theme (just directly
#'     calls `theme_classic()` for now).
#'
#' @param base_size Base font size, in pts
#' @param base_family Base font family
#'
#' @export
theme_cmor_classic <- function(base_size = 11, base_family = "") {
  ggplot2::theme_classic(base_size = base_size, base_family = base_family)
}
