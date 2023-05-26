# Data Sources for GP comparison

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

postcodes_raw <- readr::read_csv(
  "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//GP Postcode.csv"
)

imd_raw <- readxl::read_excel(
  "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//IMD_for_upload.xlsx"
)

population_raw <- readr::read_csv(
  "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//Population 1 yr band.csv"
)

workforce_raw <- readr::read_csv(
  "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//GP_workforce.csv"
)

library(dplyr)
postcodes <- postcodes_raw |>
  select("Organisation_Code", "Postcode", "Prescribing_Setting")

imd <- imd_raw |>
  select("GP_Code", "IMD_2019", "Decile", "Rank")

workforce <- workforce_raw |>
  select(
    "PRAC_CODE", "TOTAL_PATIENTS", "TOTAL_MALE", "TOTAL_FEMALE", "MALE_PATIENTS_0TO4",
    "MALE_PATIENTS_5TO14", "MALE_PATIENTS_15TO44", "MALE_PATIENTS_45TO64",
    "MALE_PATIENTS_65TO74", "MALE_PATIENTS_75TO84", "MALE_PATIENTS_85PLUS",
    "FEMALE_PATIENTS_0TO4", "FEMALE_PATIENTS_5TO14", "FEMALE_PATIENTS_15TO44",
    "FEMALE_PATIENTS_45TO64", "FEMALE_PATIENTS_65TO74", "FEMALE_PATIENTS_75TO84",
    "FEMALE_PATIENTS_85PLUS", "TOTAL_GP_HC", "TOTAL_GP_EXTG_HC", "TOTAL_GP_EXL_HC",
    "TOTAL_GP_EXTGL_HC", "TOTAL_GP_SEN_PTNR_HC", "TOTAL_GP_PTNR_PROV_HC",
    "TOTAL_GP_SAL_BY_PRAC_HC", "TOTAL_GP_FTE", "TOTAL_GP_EXTG_FTE", "TOTAL_GP_EXL_FTE",
    "TOTAL_GP_EXTGL_FTE", "TOTAL_GP_SEN_PTNR_FTE", "TOTAL_GP_PTNR_PROV_FTE",
    "TOTAL_GP_SAL_BY_PRAC_FTE", "TOTAL_NURSES_HC", "TOTAL_N_PRAC_NURSE_HC",
    "TOTAL_N_ADV_NURSE_PRAC_HC", "TOTAL_N_NURSE_SPEC_HC", "TOTAL_N_EXT_ROLE_NURSE_HC",
    "TOTAL_N_TRAINEE_NURSE_HC", "TOTAL_N_NURSE_DISP_HC", "TOTAL_N_NURSE_PTNR_HC",
    "TOTAL_N_NURSE_OTH_HC", "TOTAL_NURSES_FTE", "TOTAL_N_PRAC_NURSE_FTE",
    "TOTAL_N_ADV_NURSE_PRAC_FTE", "TOTAL_N_NURSE_SPEC_FTE", "TOTAL_N_EXT_ROLE_NURSE_FTE",
    "TOTAL_N_TRAINEE_NURSE_FTE", "TOTAL_N_NURSE_DISP_FTE", "TOTAL_N_NURSE_PTNR_FTE",
    "TOTAL_N_NURSE_OTH_FTE", "TOTAL_DPC_HC", "TOTAL_DPC_ADV_PARAMED_PRAC_HC",
    "TOTAL_DPC_ADV_PHARMA_PRAC_HC", "TOTAL_DPC_ADV_PHYSIO_PRAC_HC",
    "TOTAL_DPC_ADV_PODIA_PRAC_HC", "TOTAL_DPC_ADV_THERA_OCC_PRAC_HC",
    "TOTAL_DPC_DIETICIAN_HC", "TOTAL_DPC_DISPENSER_HC", "TOTAL_DPC_GPA_HC",
    "TOTAL_DPC_HCA_HC", "TOTAL_DPC_PHLEB_HC", "TOTAL_DPC_PHARMA_HC", "TOTAL_DPC_PHYSIO_HC",
    "TOTAL_DPC_PODIA_HC", "TOTAL_DPC_PHYSICIAN_ASSOC_HC", "TOTAL_DPC_THERA_COU_HC",
    "TOTAL_DPC_THERA_OCC_HC", "TOTAL_DPC_THERA_OTH_HC", "TOTAL_DPC_NURSE_ASSOC_HC",
    "TOTAL_DPC_TRAINEE_NURSE_ASSOC_HC", "TOTAL_DPC_PARAMED_HC", "TOTAL_DPC_PHARMT_HC",
    "TOTAL_DPC_SPLW_HC", "TOTAL_DPC_FTE", "TOTAL_DPC_ADV_PARAMED_PRAC_FTE",
    "TOTAL_DPC_ADV_PHARMA_PRAC_FTE", "TOTAL_DPC_ADV_PHYSIO_PRAC_FTE",
    "TOTAL_DPC_ADV_PODIA_PRAC_FTE", "TOTAL_DPC_ADV_THERA_OCC_PRAC_FTE",
    "TOTAL_DPC_DIETICIAN_FTE", "TOTAL_DPC_DISPENSER_FTE", "TOTAL_DPC_GPA_FTE",
    "TOTAL_DPC_HCA_FTE", "TOTAL_DPC_PHLEB_FTE", "TOTAL_DPC_PHARMA_FTE", "TOTAL_DPC_PHYSIO_FTE",
    "TOTAL_DPC_PODIA_FTE", "TOTAL_DPC_PHYSICIAN_ASSOC_FTE", "TOTAL_DPC_THERA_COU_FTE",
    "TOTAL_DPC_THERA_OCC_FTE", "TOTAL_DPC_THERA_OTH_FTE", "TOTAL_DPC_NURSE_ASSOC_FTE",
    "TOTAL_DPC_TRAINEE_NURSE_ASSOC_FTE", "TOTAL_DPC_PARAMED_FTE", "TOTAL_DPC_PHARMT_FTE",
    "TOTAL_DPC_SPLW_FTE", "TOTAL_ADMIN_HC", "TOTAL_ADMIN_MANAGER_HC",
    "TOTAL_ADMIN_MANAGE_PTNR_HC", "TOTAL_ADMIN_MED_SECRETARY_HC", "TOTAL_ADMIN_RECEPT_HC",
    "TOTAL_ADMIN_TELEPH_HC", "TOTAL_ADMIN_ESTATES_ANC_HC", "TOTAL_ADMIN_OTH_HC",
    "TOTAL_ADMIN_APP_HC", "TOTAL_ADMIN_FTE", "TOTAL_ADMIN_MANAGER_FTE",
    "TOTAL_ADMIN_MANAGE_PTNR_FTE", "TOTAL_ADMIN_MED_SECRETARY_FTE",
    "TOTAL_ADMIN_RECEPT_FTE", "TOTAL_ADMIN_TELEPH_FTE", "TOTAL_ADMIN_ESTATES_ANC_FTE",
    "TOTAL_ADMIN_OTH_FTE", "TOTAL_ADMIN_APP_FTE"
  )

workforce <- janitor::clean_names(workforce)




comparison <- ods_raw |>
  inner_join(postcodes, join_by("practice_code" == "Organisation_Code")) |>
  inner_join(imd, join_by("practice_code" == "GP_Code")) |>
  inner_join(workforce, join_by("practice_code" == "prac_code"))
