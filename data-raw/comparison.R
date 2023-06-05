## Script to Import & Wrangle GP Practice Data Sources for Comparison Model

## Data source - NCDR ODS table
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

## SP05 - [UK_Health_Dimensions].[ODS].[GP_Practices_And_Prescribing_CCs_SCD]
postcodes_raw <-
  readr::read_csv(
    "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//GP Postcode.csv"
  ) |>
  janitor::clean_names()

## Data for General Practice (IMD 2019) - Sorted to rank and assign decile
## https://fingertips.phe.org.uk/profile/general-practice/data#page/9/gid/2000005/pat/204/par/U00070/ati/7/are/H85026/iid/93553/age/1/sex/4/cat/-1/ctp/-1/yrr/1/cid/4/tbm/1
imd_raw <-
  readxl::read_excel(
    "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//IMD_for_upload.xlsx"
  ) |>
  janitor::clean_names()

## NCDR - [NHSE_UKHF].[Demography].[vw_No_Of_Patients_Regd_At_GP_Practice_Single_Age1]
population_raw <-
  readr::read_csv(
    "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//Population 1 yr band.csv"
  ) |>
  janitor::clean_names()

## https://digital.nhs.uk/data-and-information/publications/statistical/general-and-personal-medical-services
workforce_raw <-
  readr::read_csv(
    "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//GP_workforce.csv"
  ) |>
  janitor::clean_names()


postcodes <-
  postcodes_raw |>
  dplyr::select(organisation_code, postcode, prescribing_setting) |>
  dplyr::rename(practice_code = organisation_code)

imd <-
  imd_raw |>
  dplyr::select(gp_code, imd_2019, decile, rank) |>
  dplyr::rename(practice_code = gp_code)


workforce <-
  workforce_raw |>
  dplyr::rename(practice_code = prac_code) |>
  dplyr::select(
    practice_code,
    total_patients,
    total_male,
    total_female,
    male_patients_0to4,
    male_patients_5to14,
    male_patients_15to44,
    male_patients_45to64,
    male_patients_65to74,
    male_patients_75to84,
    male_patients_85plus,
    female_patients_0to4,
    female_patients_5to14,
    female_patients_15to44,
    female_patients_45to64,
    female_patients_65to74,
    female_patients_75to84,
    female_patients_85plus,
    total_gp_hc,
    total_gp_fte,
    total_nurses_hc,
    total_nurses_fte,
    total_admin_hc,
    total_admin_fte
  )

comparison <-
  ods_raw |>
  inner_join(postcodes) |>
  inner_join(imd) |>
  inner_join(workforce)
