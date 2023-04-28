
fft_raw <- readxl::read_excel(
  "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw DataGP FFT Data.xlsx")

ods_raw <- readr::read_csv(
  "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//ODS.csv",
  col_names = FALSE
  )

gppt_raw <- readr::read_csv(
  "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//GPPT_Data.csv", 
  col_names = FALSE
  )

gppt <-dplyr::rename(
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

ods <-dplyr::rename(
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

pcn_code <-unique(ods$pcn_code)
pcn_name <-unique(ods$pcn_name)
gp_code <-unique(ods$practice_code)
gp_name <-unique(ods$practice_name)
icb_code <-unique(ods$icb_code)
icb_name <-unique(ods$icb_name)
region_code <-unique(ods$region_code)
region_name <-unique(ods$region_name)

