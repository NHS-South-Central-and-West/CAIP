test_that("conditional correctly evaluates sums", {
  expect_equal(conditional(1 + 1, 2), 2)
  expect_equal(conditional(1 + 3 == 2, 2), TRUE)
})

test_that("conditional correctly evaluates strings", {
  empty_input <- ""
  test_input <- "test"
  expect_equal(conditional(empty_input != "", empty_input), TRUE)
  expect_equal(conditional(test_input != "", test_input), "test")
})

test_that("reset_monthday function returns correct dates", {
  expect_equal(reset_monthday("2023-06-05"), as.Date("2023-06-01"))
  expect_equal(reset_monthday("1989-04-19"), as.Date("1989-04-01"))
  expect_equal(reset_monthday("2015-01-01"), as.Date("2015-01-01"))
})
