## code to prepare `fft` dataset goes here

library(tidyverse)

fft_raw <- readxl::read_excel(
  "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//GP FFT Data.xlsx"
)

ods_raw <-
  readr::read_csv(
    "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//ODS.csv",
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

fft_pivot <- fft_raw |>
  pivot_longer(
    cols = !c(month, region_code, practice_code),
    names_to = "answers",
    values_to = "value"
  ) |>
  left_join(ods, by = join_by("practice_code")) |>
  mutate(
    total_flag = case_when(
      str_detect(answers, "Total") ~ TRUE,
      TRUE ~ FALSE
    )
  ) |>
  mutate(
    popn_flag = case_when(
      str_detect(answers, "population") ~ TRUE,
      TRUE ~ FALSE
    )
  ) |>
  mutate(
    perc_recomm_flag = case_when(
      str_detect(answers, "%") ~ TRUE,
      TRUE ~ FALSE
    )
  ) |>
  mutate(
    sort_order = case_when(
      answers == "Extremely Likely/Very Good" ~ 1, answers == "Likely/Good" ~ 2, answers == "Neither Likely nor Unlikely/Neither Good nor Poor" ~ 3,
      answers == "Unlikely/Poor" ~ 4, answers == "Extremely Unlikely/Very Poor" ~ 5, answers == "Do not Know" ~ 6
    )
  )

fft_final <- subset(fft_pivot, popn_flag == FALSE & total_flag == FALSE &
  perc_recomm_flag == FALSE) |>
  select(
    practice_code,
    practice_name,
    pcn_code,
    pcn_name,
    icb_code,
    icb_name,
    region_code.x,
    region_name,
    month,
    answers,
    value,
    sort_order
  )


fft_final <- rename(
  fft_final,
  region_code = region_code.x
)



usethis::use_data(fft, overwrite = TRUE)
