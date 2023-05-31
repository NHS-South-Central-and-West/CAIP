## Script to Import & Wrangle Friends & Family Test (FFT) Survey Data

fft_raw <- readxl::read_excel(
  "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//GP FFT Data.xlsx"
)

ods_raw <-
  readr::read_csv(
    "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//ODS.csv",
    col_names = FALSE
  ) |>
  dplyr::rename(
    practice_code = X1,
    practice_name = X2,
    pcn_code = X3,
    pcn_name = X4,
    icb_code = X5,
    icb_name = X6,
    region_code = X7,
    region_name = X8
  )

fft <- fft_raw |>
  dplyr::select(!region_code) |>
  dplyr::left_join(ods_raw, by = "practice_code") |>
  tidyr::pivot_longer(
    cols = !c(month, dplyr::ends_with(c("code", "name"))),
    names_to = "answer", values_to = "value"
  ) |>
  dplyr::rename(date = month) |>
  dplyr::filter(!answer %in% c(
    "% Recommend", "% Not Recommend", "Total Responses",
    "patient_registered_population"
  )) |>
  dplyr::mutate(
    date = lubridate::round_date(date, unit = "month"),
    answer = dplyr::case_when(
      answer == "Extremely Likely/Very Good" ~ "Very Good",
      answer == "Likely/Good" ~ "Good",
      answer == "Neither Likely nor Unlikely/Neither Good nor Poor" ~
        "Neither Good nor Poor",
      answer == "Unlikely/Poor" ~ "Poor",
      answer == "Extremely Unlikely/Very Poor" ~ "Very Poor",
      answer == "Do not Know" ~ "Don't Know"
    ),
    response_scale = dplyr::case_when(
      answer == "Very Good" ~ 1,
      answer == "Good" ~ 2,
      answer == "Neither Good nor Poor" ~ 3,
      answer == "Poor" ~ 4,
      answer == "Very Poor" ~ 5,
      answer == "Don't Know" ~ NA
    )
  )

usethis::use_data(fft, overwrite = TRUE)
