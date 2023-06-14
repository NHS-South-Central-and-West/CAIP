test_that("check number of columns in GPPS national data", {
  gpps_national_test <-
    get_gpps_national_data(
      qn = "Q01 - Ease of getting through to someone at GP practice on the phone"
    )

  expect_equal(ncol(gpps_national_test), 6)
})

test_that("check number of columns in GPPS regional data", {
  gpps_region_test <-
    get_gpps_region_data(
      qn = "Q01 - Ease of getting through to someone at GP practice on the phone",
      org = "Y59 - SOUTH EAST COMMISSIONING REGION"
    )

  expect_equal(ncol(gpps_region_test), 7)
})

test_that("check number of columns in GPPS ICB data", {
  gpps_icb_test <-
    get_gpps_icb_data(
      qn = "Q01 - Ease of getting through to someone at GP practice on the phone",
      org = "QHL - BIRMINGHAM AND SOLIHULL ICB"
    )

  expect_equal(ncol(gpps_icb_test), 7)
})

test_that("check number of columns in GPPS PCN data", {
  gpps_pcn_test <-
    get_gpps_icb_data(
      qn = "Q01 - Ease of getting through to someone at GP practice on the phone",
      org = "U53896 - NORTH LEWISHAM PCN"
    )

  expect_equal(ncol(gpps_pcn_test), 7)
})

test_that("check number of columns in GPPS practice data", {
  gpps_practice_test <-
    get_gpps_icb_data(
      qn = "Q01 - Ease of getting through to someone at GP practice on the phone",
      org = "F86025 - OAK TREE MEDICAL CENTRE"
    )

  expect_equal(ncol(gpps_practice_test), 7)
})
