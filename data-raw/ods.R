## Script to Import & Wrangle Organisation Data Service (ODS) Data

# import raw data from file
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

ods <-
  ods_raw |>
  # remove null columns
  dplyr::filter(dplyr::if_any(dplyr::ends_with("name"), ~ . != "NULL")) |>
  dplyr::mutate(
    # clean up organisation names
    dplyr::across(
      dplyr::ends_with("name"),
      ~ stringr::str_replace_all(.x, "INTEGRATED CARE BOARD", "ICB")
    ),
    # concatenate organisation codes and names
    region = stringr::str_c(region_code, " - ", region_name),
    icb = stringr::str_c(icb_code, " - ", icb_name),
    pcn = stringr::str_c(pcn_code, " - ", pcn_name),
    practice = stringr::str_c(practice_code, " - ", practice_name)
  ) |>
  # reorder columns for simplicity
  dplyr::select(
    dplyr::starts_with("region"),
    dplyr::starts_with("icb"),
    dplyr::starts_with("pcn"),
    dplyr::starts_with("practice")
  )

usethis::use_data(ods, overwrite = TRUE)
