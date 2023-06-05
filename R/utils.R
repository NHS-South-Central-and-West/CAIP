#' Conditional function for handling default inputs for filters
#'
#' @description A utility function for reducing reliance on many nested if
#' statements in the app's filtering process. Where default values (\code{""})
#' are returned in one of the app's \code{selectizeInput()} boxes, this function
#' returns \bold{TRUE} so that dplyr's \code{filter()} doesn't filter that
#' column.
#'
#' @param condition The condition to be evaluated, returning \bold{TRUE} or
#' \bold{FALSE}
#' @param success The result to be returned if the condition returns \bold{TRUE}
#'
#' @return If \code{condition = TRUE} then returns \bold{success}, else returns
#' \bold{TRUE}.
#'
#' @noRd
conditional <- function(condition, success) {
  if (condition) success else TRUE
}

#' Set the date returned by the date range inputs in the app as the first day of
#' that month.
#'
#' @description A utility function for ensuring that the date range returned
#' includes any data for the month selected.
#'
#' @param date A date object
#'
#' @return \code{date} The first day of the selected month (for example,
#' selecting June 2023 returns \code{"2023/06/01}).
#'
#' @noRd
reset_monthday <- function(date) {
  date <- as.POSIXlt(date)
  date$mday <- 1
  as.Date(date)
}
