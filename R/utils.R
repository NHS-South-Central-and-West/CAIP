#' helpers
#'
#' @description A utils function
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd
conditional <- function(condition, success) {
  if (condition) success else TRUE
}