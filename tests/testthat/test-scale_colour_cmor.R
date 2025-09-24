test_that("scale_colour_cmor works", {
  expect_s3_class(scale_colour_cmor(), "ScaleDiscrete")
})

test_that("scale_fill_cmor works", {
  expect_s3_class(scale_fill_cmor(), "ScaleDiscrete")
})
