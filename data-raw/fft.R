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
    icb_name = stringr::str_remove(icb_name, "NHS "),
    icb_name = stringr::str_replace(icb_name, "INTEGRATED CARE BOARD", "ICB"),
    # concatenate organisation codes and names
    region = stringr::str_c(region_code, " - ", region_name),
    icb = stringr::str_c(icb_code, " - ", icb_name),
    pcn = stringr::str_c(pcn_code, " - ", pcn_name),
    practice = stringr::str_c(practice_code, " - ", practice_name),
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
  ) |>
  dplyr::select(!dplyr::all_of(dplyr::ends_with("name"))) |>
  dplyr::relocate(region, .after = region_code) |>
  dplyr::relocate(icb, .after = icb_code) |>
  dplyr::relocate(pcn, .after = pcn_code) |>
  dplyr::relocate(practice, .after = practice_code)

usethis::use_data(fft, overwrite = TRUE)
