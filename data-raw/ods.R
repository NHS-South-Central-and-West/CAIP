## code to prepare `ods` dataset goes here

ods_raw <- readr::read_csv(
  glue::glue(
    "O://T&C//BI Consultancy//A - Projects//",
    "UoM - SCW - PC CAP//Raw Data//ODS.csv"
  ),
  col_names = FALSE
)

ods <- dplyr::rename(
  ods_raw,
  practice_code = X1,
  practice_name = X2,
  pcn_code = X3,
  pcn_name = X4,
  icb_code = X5,
  icb_name = X6,
  region_code = X7,
  region_name = X8
)

pcn_code <- unique(ods$pcn_code)
pcn_name <- unique(ods$pcn_name)
gp_code <- unique(ods$practice_code)
gp_name <- unique(ods$practice_name)
icb_code <- unique(ods$icb_code)
icb_name <- unique(ods$icb_name)
region_code <- unique(ods$region_code)
region_name <- unique(ods$region_name)

usethis::use_data(ods, overwrite = TRUE)
