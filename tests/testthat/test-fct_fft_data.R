test_that("check number of columns in fft national data", {
  fft_national_test <-
    get_fft_national_data(
      date_from = "2021-01-01",
      date_to = "2023-01-01"
    )

  expect_equal(ncol(fft_national_test), 4)
})

test_that("check number of columns in fft regional data", {
  fft_region_test <-
    get_fft_region_data(
      date_from = "2021-01-01",
      date_to = "2023-01-01",
      org = "Y59 - SOUTH EAST COMMISSIONING REGION"
    )

  expect_equal(ncol(fft_region_test), 5)
})

test_that("check number of columns in fft ICB data", {
  fft_icb_test <-
    get_fft_icb_data(
      date_from = "2021-01-01",
      date_to = "2023-01-01",
      org = "QHL - BIRMINGHAM AND SOLIHULL ICB"
    )

  expect_equal(ncol(fft_icb_test), 5)
})

test_that("check number of columns in fft PCN data", {
  fft_pcn_test <-
    get_fft_icb_data(
      date_from = "2021-01-01",
      date_to = "2023-01-01",
      org = "U53896 - NORTH LEWISHAM PCN"
    )

  expect_equal(ncol(fft_pcn_test), 5)
})

test_that("check number of columns in fft practice data", {
  fft_practice_test <-
    get_fft_icb_data(
      date_from = "2021-01-01",
      date_to = "2023-01-01",
      org = "F86025 - OAK TREE MEDICAL CENTRE"
    )

  expect_equal(ncol(fft_practice_test), 5)
})
