cmor_pal <- function(type = "qual", direction = 1, grey = FALSE) {
  force(direction)
  switch(
    type,
    qual = function(n) {
      if (grey) {
        n <- n - 1
      }

      pal <- if (n == 0) {
        character()
      } else if (n == 1) {
        "#060d87"
      } else if (n == 2) {
        c("#060d87", "#f4b142")
      } else {
        qualpalr::qualpal(
          n = n,
          list(h = c(0, 360), s = c(0.5, 1), l = c(0.3, 0.8)),
          bg = "#fbf9ed",
          extend = c("#060d87", "#f4b142")
        )$hex
      }
      if (direction == -1) {
        pal <- rev(pal)
      }
      if (grey) {
        pal <- c(pal, "#aaaaaa")
      }
      pal
    },
    seq = function(n) {
      if (grey) {
        n <- n - 1
      }
      if (n > 5) {
        stop(paste(
          "\"qual\" colour palette has only 5 colours; your data has",
          n,
          "distinct levels."
        ))
      }
      blues <- c("#000044", "#060d87", "#0000ff", "#317bff", "#daebfc")
      pal <- if (n == 0) {
        character()
      } else if (n == 1) {
        "#060d87"
      } else {
        blues[1:n]
      }
      if (direction == -1) {
        pal <- rev(pal)
      }
      if (grey) {
        pal <- c(pal, "#aaaaaa")
      }
      pal
    }
  )
}
