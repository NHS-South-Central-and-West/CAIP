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

#' Stylized font awesome icons
#'
#' @description A utility function for outputting font awesome icons that
#' follow a consistent style.
#'
#' @param name The name of the icon taken from the font awesome website
#' (https://fontawesome.com/icons)
#' @param fill Icon colour
#' @param fill_opacity Icon opacity
#'
#' @noRd
fa_icon <- function(name, fill = "#231F20", fill_opacity = 0.8) {
  fontawesome::fa(name = name, fill = fill, fill_opacity = fill_opacity)
}

#' Create an url
#'
#' @param url the URL
#' @param text the text to display
#'
#' @return an a tag
#' @noRd
#'
#' @examples
#' enurl("https://www.thinkr.fr", "ThinkR")
#' @importFrom shiny tags
enurl <- function(url, text) {
  tags$a(href = url, text)
}

#' Columns wrappers
#'
#' These are convenient wrappers around
#' `column(12, ...)`, `column(6, ...)`, `column(4, ...)`...
#'
#' @noRd
#'
#' @importFrom shiny column
col_12 <- function(...) {
  column(12, ...)
}

#' @importFrom shiny column
col_10 <- function(...) {
  column(10, ...)
}

#' @importFrom shiny column
col_8 <- function(...) {
  column(8, ...)
}

#' @importFrom shiny column
col_6 <- function(...) {
  column(6, ...)
}


#' @importFrom shiny column
col_4 <- function(...) {
  column(4, ...)
}


#' @importFrom shiny column
col_3 <- function(...) {
  column(3, ...)
}


#' @importFrom shiny column
col_2 <- function(...) {
  column(2, ...)
}

#' @importFrom shiny column
col_1 <- function(...) {
  column(1, ...)
}
