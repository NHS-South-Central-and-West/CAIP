#' Get FFT data aggregated at a national level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_fft_national_data <- function(date_from, date_to) {
  CAIP::fft |>
    dplyr::filter(
      dplyr::between(date, as.Date(date_from), as.Date(date_to)),
      !is.na(.data$response_scale)
    ) |>
    dplyr::summarise(
      value = sum(.data$value),
      .by = c(
        "date", "answer", "response_scale"
      )
    )
}

#' Get FFT data aggregated at a regional level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_fft_region_data <- function(date_from, date_to, org) {
  CAIP::fft |>
    dplyr::filter(
      dplyr::between(date, as.Date(date_from), as.Date(date_to)),
      conditional(org != "", region == org),
      !is.na(.data$response_scale)
    ) |>
    dplyr::summarise(
      value = sum(.data$value),
      .by = c(
        "date", "region", "answer",
        "response_scale"
      )
    )
}

#' Get FFT data aggregated at an ICB level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_fft_icb_data <- function(date_from, date_to, org) {
  CAIP::fft |>
    dplyr::filter(
      dplyr::between(date, as.Date(date_from), as.Date(date_to)),
      conditional(org != "", icb == org),
      !is.na(.data$response_scale)
    ) |>
    dplyr::summarise(
      value = sum(.data$value),
      .by = c(
        "date", "icb", "answer",
        "response_scale"
      )
    )
}


#' Get FFT data aggregated at a PCN level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_fft_pcn_data <- function(date_from, date_to, org) {
  CAIP::fft |>
    dplyr::filter(
      dplyr::between(date, as.Date(date_from), as.Date(date_to)),
      conditional(org != "", pcn == org),
      !is.na(.data$response_scale)
    ) |>
    dplyr::summarise(
      value = sum(.data$value),
      .by = c(
        "date", "pcn", "answer",
        "response_scale"
      )
    )
}


#' Get FFT data aggregated at a GP Practice level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_fft_practice_data <- function(date_from, date_to, org) {
  CAIP::fft |>
    dplyr::filter(
      dplyr::between(date, as.Date(date_from), as.Date(date_to)),
      conditional(org != "", practice == org),
      !is.na(.data$response_scale)
    ) |>
    dplyr::summarise(
      value = sum(.data$value),
      .by = c(
        "date", "practice", "answer",
        "response_scale"
      )
    )
}

#' Get FFT data aggregated at a regional, ICB, PCN, or GP Practice level
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

get_fft_data <- function(level, date_from, date_to, org = NULL) {
  switch(level,
    "National" = get_fft_national_data(date_from, date_to),
    "Regional" = get_fft_region_data(date_from, date_to, org),
    "ICB" = get_fft_icb_data(date_from, date_to, org),
    "PCN" = get_fft_pcn_data(date_from, date_to, org),
    "GP Practice" = get_fft_practice_data(date_from, date_to, org),
    stop("Unknown fft Level")
  )
}
