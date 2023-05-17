## code to prepare `ods` dataset goes here

ods_raw <-
  readr::read_csv(
    "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//ODS.csv",
    col_names = FALSE
  )

library(stringr)

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
) %>%
  mutate(
    practice = str_c(practice_code, ' - ', practice_name)
  )%>%
  mutate(
    pcn = str_c(pcn_code, ' - ', pcn_name)
  ) %>%
  mutate(
   icb = str_c(icb_code, ' - ', icb_name)
  ) %>%
  mutate(
    region = str_c(region_code, ' - ', region_name)
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
