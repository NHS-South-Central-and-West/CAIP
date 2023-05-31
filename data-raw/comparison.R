## Script to Import & Wrangle GP Practice Data Sources for Comparison Model

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

postcodes_raw <-
  readr::read_csv(
    "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//GP Postcode.csv"
  ) |>
  janitor::clean_names()

imd_raw <-
  readxl::read_excel(
    "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//IMD_for_upload.xlsx"
  ) |>
  janitor::clean_names()

population_raw <-
  readr::read_csv(
    "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//Population 1 yr band.csv"
  ) |>
  janitor::clean_names()

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
    total_gp_extg_hc,
    total_gp_exl_hc,
    total_gp_extgl_hc,
    total_gp_sen_ptnr_hc,
    total_gp_ptnr_prov_hc,
    total_gp_sal_by_prac_hc,
    total_gp_fte,
    total_gp_extg_fte,
    total_gp_exl_fte,
    total_gp_extgl_fte,
    total_gp_sen_ptnr_fte,
    total_gp_ptnr_prov_fte,
    total_gp_sal_by_prac_fte,
    total_nurses_hc,
    total_n_prac_nurse_hc,
    total_n_adv_nurse_prac_hc,
    total_n_nurse_spec_hc,
    total_n_ext_role_nurse_hc,
    total_n_trainee_nurse_hc,
    total_n_nurse_disp_hc,
    total_n_nurse_ptnr_hc,
    total_n_nurse_oth_hc,
    total_nurses_fte,
    total_n_prac_nurse_fte,
    total_n_adv_nurse_prac_fte,
    total_n_nurse_spec_fte,
    total_n_ext_role_nurse_fte,
    total_n_trainee_nurse_fte,
    total_n_nurse_disp_fte,
    total_n_nurse_ptnr_fte,
    total_n_nurse_oth_fte,
    total_dpc_hc,
    total_dpc_adv_paramed_prac_hc,
    total_dpc_adv_pharma_prac_hc,
    total_dpc_adv_physio_prac_hc,
    total_dpc_adv_podia_prac_hc,
    total_dpc_adv_thera_occ_prac_hc,
    total_dpc_dietician_hc,
    total_dpc_dispenser_hc,
    total_dpc_gpa_hc,
    total_dpc_hca_hc,
    total_dpc_phleb_hc,
    total_dpc_pharma_hc,
    total_dpc_physio_hc,
    total_dpc_podia_hc,
    total_dpc_physician_assoc_hc,
    total_dpc_thera_cou_hc,
    total_dpc_thera_occ_hc,
    total_dpc_thera_oth_hc,
    total_dpc_nurse_assoc_hc,
    total_dpc_trainee_nurse_assoc_hc,
    total_dpc_paramed_hc,
    total_dpc_pharmt_hc,
    total_dpc_splw_hc,
    total_dpc_fte,
    total_dpc_adv_paramed_prac_fte,
    total_dpc_adv_pharma_prac_fte,
    total_dpc_adv_physio_prac_fte,
    total_dpc_adv_podia_prac_fte,
    total_dpc_adv_thera_occ_prac_fte,
    total_dpc_dietician_fte,
    total_dpc_dispenser_fte,
    total_dpc_gpa_fte,
    total_dpc_hca_fte,
    total_dpc_phleb_fte,
    total_dpc_pharma_fte,
    total_dpc_physio_fte,
    total_dpc_podia_fte,
    total_dpc_physician_assoc_fte,
    total_dpc_thera_cou_fte,
    total_dpc_thera_occ_fte,
    total_dpc_thera_oth_fte,
    total_dpc_nurse_assoc_fte,
    total_dpc_trainee_nurse_assoc_fte,
    total_dpc_paramed_fte,
    total_dpc_pharmt_fte,
    total_dpc_splw_fte,
    total_admin_hc,
    total_admin_manager_hc,
    total_admin_manage_ptnr_hc,
    total_admin_med_secretary_hc,
    total_admin_recept_hc,
    total_admin_teleph_hc,
    total_admin_estates_anc_hc,
    total_admin_oth_hc,
    total_admin_app_hc,
    total_admin_fte,
    total_admin_manager_fte,
    total_admin_manage_ptnr_fte,
    total_admin_med_secretary_fte,
    total_admin_recept_fte,
    total_admin_teleph_fte,
    total_admin_estates_anc_fte,
    total_admin_oth_fte,
    total_admin_app_fte
  )

comparison <-
  ods_raw |>
  inner_join(postcodes) |>
  inner_join(imd) |>
  inner_join(workforce)
