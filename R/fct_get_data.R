#' Get GPPT data aggregated at a national level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_gppt_national_data <- function(question_code) {
  CAP::gppt |>
    dplyr::select(
      .data$question_number, .data$question, .data$answer, .data$value,
      .data$year, .data$response_scale, .data$response_summary
    ) |>
    dplyr::filter(.data$question_number == question_code) |>
    dplyr::group_by(
      .data$question, .data$question_number,
      .data$answer, .data$year, .data$response_scale
    ) |>
    dplyr::summarise(value = sum(.data$value)) |>
    dplyr::ungroup()
}

#' Get GPPT data aggregated at a regional, ICB, PCN, or GP Practice level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_gppt_org_data <- function(
    level = c("Regional", "ICB", "PCN", "GP Practice"),
    org_code, question_code, summary = FALSE) {
  CAP::gppt |>
    dplyr::filter(!is.na(.data$response_scale)) |>
    dplyr::mutate(
      organisation_code = dplyr::case_when(
        level == "Regional" ~ .data$region_code,
        level == "ICB" ~ .data$icb_code,
        level == "PCN" ~ .data$pcn_code,
        level == "GP Practice" ~ .data$practice_code
      ),
      organisation_name = dplyr::case_when(
        level == "Regional" ~ .data$region_name,
        level == "ICB" ~ .data$icb_name,
        level == "PCN" ~ .data$pcn_name,
        level == "GP Practice" ~ .data$practice_name
      )
    ) |>
    dplyr::select(
      .data$organisation_code, .data$organisation_name, .data$question_number,
      .data$question, .data$answer, .data$value, .data$year,
      .data$response_scale, .data$response_summary
    ) |>
    dplyr::filter(.data$organisation_code == org_code &
      .data$question_number == question_code) |>
    dplyr::group_by(
      .data$organisation_code, .data$organisation_name, .data$question,
      .data$question_number, .data$answer, .data$year, .data$response_scale
    ) |>
    dplyr::summarise(value = sum(.data$value)) |>
    dplyr::ungroup()
}
