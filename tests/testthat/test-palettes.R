test_that("cmor_pal works", {
  is_hexcolour <- function(x) grepl("^#[a-f0-9]{6}$", x, ignore.case = TRUE)
  expect_hexcolour <- function(object) {
    act <- testthat::quasi_label(rlang::enquo(object), arg = "object")

    valid <- is_hexcolour(act$val)
    testthat::expect(
      all(valid),
      paste0("Not all elements of ", act$lab, " are hex colors.")
    )

    invisible(act$val)
  }

  for (pal in c("CUD", "Bright", "High-Contrast", "Vibrant", "Muted",
                "Medium-Contrast", "Light", "Paired")) {
    p <- cmor_pal(pal)
    expect_type(p, "closure")
    for (i in 1:max_pal_n(pal)) expect_hexcolour(p(i))
  }
})
