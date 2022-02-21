test_that("plot_cmor_colours works", {
  p <- plot_cmor_colours()
  expect_s3_class(p, "gg")
  expect_setequal(names(p$mapping), c("x", "y", "fill"))
  expect_setequal(levels(p$data$palette), names(cmor_palettes))
  expect_s3_class(p$layers[[1]]$geom, "GeomTile")
  p <- plot_cmor_colors()
  expect_s3_class(p, "gg")
  expect_setequal(names(p$mapping), c("x", "y", "fill"))
  expect_setequal(levels(p$data$palette), names(cmor_palettes))
  expect_s3_class(p$layers[[1]]$geom, "GeomTile")
})

test_that("list_cmor_colours works", {
  expect_equal(list_cmor_colours(), names(cmor_palettes))
  expect_equal(list_cmor_colors(), names(cmor_palettes))
})
