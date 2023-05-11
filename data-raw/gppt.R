## code to prepare `gppt` dataset goes here

gppt_raw <- readr::read_csv(
  glue::glue("O://T&C//BI Consultancy//A - Projects//",
             "UoM - SCW - PC CAP//Raw Data//GPPT_Data.csv"),
  col_names = FALSE
)

gppt <- dplyr::rename(
  gppt_raw,
  practice_code = X1,
  practice_name = X2,
  pcn_code = X3,
  pcn_name = X4,
  icb_code = X5,
  icb_name = X6,
  region_code = X7,
  region_name = X8,
  source_question_number = X9,
  question_number = X10,
  question_description = X11,
  value = X12,
  year = X13
)

usethis::use_data(gppt, overwrite = TRUE)
