
test_that("fft data functions return data frames", {
  date_from = "2021-01-01"
  date_to = "2023-01-01"
  region = "Y59 - SOUTH EAST COMMISSIONING REGION"
  icb = "QHL - BIRMINGHAM AND SOLIHULL ICB"
  pcn = "U53896 - NORTH LEWISHAM PCN"
  practice = "F86025 - OAK TREE MEDICAL CENTRE"

  expect_true(inherits(get_fft_national_data(date_from, date_to), "data.frame"))
  expect_true(inherits(get_fft_region_data(date_from, date_to, region), "data.frame"))
  expect_true(inherits(get_fft_icb_data(date_from, date_to, icb), "data.frame"))
  expect_true(inherits(get_fft_pcn_data(date_from, date_to, pcn), "data.frame"))
  expect_true(inherits(get_fft_practice_data(date_from, date_to, practice), "data.frame"))
})

test_that("fft data functions return correct number of columns", {
  date_from = "2021-01-01"
  date_to = "2023-01-01"
  region = "Y59 - SOUTH EAST COMMISSIONING REGION"
  icb = "QHL - BIRMINGHAM AND SOLIHULL ICB"
  pcn = "U53896 - NORTH LEWISHAM PCN"
  practice = "F86025 - OAK TREE MEDICAL CENTRE"

  expect_equal(ncol(get_fft_national_data(date_from, date_to)), 4)
  expect_equal(ncol(get_fft_region_data(date_from, date_to, region)), 5)
  expect_equal(ncol(get_fft_icb_data(date_from, date_to, icb)), 5)
  expect_equal(ncol(get_fft_pcn_data(date_from, date_to, pcn)), 5)
  expect_equal(ncol(get_fft_practice_data(date_from, date_to, practice)), 5)
})
