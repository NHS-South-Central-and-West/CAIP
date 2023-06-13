#' Get GPPS data aggregated at a national level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_gpps_national_data <- function(qn) {
  CAIP::gpps |>
    dplyr::filter(
      question == qn,
      !is.na(.data$response_scale)
    ) |>
    dplyr::summarise(
      value = sum(.data$value),
      .by = c(
        "year", "question", "question_number",
        "answer", "response_scale"
      )
    )
}

#' Get GPPS data aggregated at a regional level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_gpps_region_data <- function(qn, org) {
  CAIP::gpps |>
    dplyr::filter(
      question == qn,
      conditional(org != "", region == org),
      !is.na(.data$response_scale)
    ) |>
    dplyr::summarise(
      value = sum(.data$value),
      .by = c(
        "year", "region", "question",
        "question_number", "answer",
        "response_scale"
      )
    )
}

#' Get GPPS data aggregated at an ICB level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_gpps_icb_data <- function(qn, org) {
  CAIP::gpps |>
    dplyr::filter(
      question == qn,
      conditional(org != "", icb == org),
      !is.na(.data$response_scale)
    ) |>
    dplyr::summarise(
      value = sum(.data$value),
      .by = c(
        "year", "icb", "question",
        "question_number", "answer",
        "response_scale"
      )
    )
}


#' Get GPPS data aggregated at a PCN level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_gpps_pcn_data <- function(qn, org) {
  CAIP::gpps |>
    dplyr::filter(
      question == qn,
      conditional(org != "", pcn == org),
      !is.na(.data$response_scale)
    ) |>
    dplyr::summarise(
      value = sum(.data$value),
      .by = c(
        "year", "pcn", "question",
        "question_number", "answer",
        "response_scale"
      )
    )
}


#' Get GPPS data aggregated at a GP Practice level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_gpps_practice_data <- function(qn, org) {
  CAIP::gpps |>
    dplyr::filter(
      question == qn,
      conditional(org != "", practice == org),
      !is.na(.data$response_scale)
    ) |>
    dplyr::summarise(
      value = sum(.data$value),
      .by = c(
        "year", "practice", "question",
        "question_number", "answer",
        "response_scale"
      )
    )
}

#' Get GPPS data aggregated at a regional, ICB, PCN, or GP Practice level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_gpps_data <- function(level, qn, org = NULL) {
  switch(level,
    "National" = get_gpps_national_data(qn),
    "Regional" = get_gpps_region_data(qn, org),
    "ICB" = get_gpps_icb_data(qn, org),
    "PCN" = get_gpps_pcn_data(qn, org),
    "GP Practice" = get_gpps_practice_data(qn, org),
    stop("Unknown GPPS Level")
  )
}
