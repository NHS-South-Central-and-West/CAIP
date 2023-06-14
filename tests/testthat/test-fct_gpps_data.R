test_that("returns correct number of columns", {
  qn <- "Q01 - Ease of getting through to someone at GP practice on the phone"
  region <- "Y59 - SOUTH EAST COMMISSIONING REGION"
  icb <- "QHL - BIRMINGHAM AND SOLIHULL ICB"
  pcn <- "U53896 - NORTH LEWISHAM PCN"
  practice <- "F86025 - OAK TREE MEDICAL CENTRE"

  expect_equal(ncol(get_gpps_national_data(qn)), 6)
  expect_equal(ncol(get_gpps_region_data(qn, region)), 7)
  expect_equal(ncol(get_gpps_icb_data(qn, icb)), 7)
  expect_equal(ncol(get_gpps_pcn_data(qn, pcn)), 7)
  expect_equal(ncol(get_gpps_practice_data(qn, practice)), 7)
})
