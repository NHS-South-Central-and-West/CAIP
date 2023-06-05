#' Month Date Range Input
#'
#' @description A function for restricting the minimum level that Shiny's date
#' range input shows to months (as opposed to days). The code for this function
#' was initially inspired by a StackOverflow answer about this issue
#' (https://stackoverflow.com/a/38974106). This is just an updated version of
#' that code.
#'
#' @inheritParams shiny::dateRangeInput
#' @param minviewmode The minimum level that the dropdown date menu should show
#'
#' @noRd
dateRangeMonthsInput <- function(inputId, label, start = NULL, end = NULL,
                                 min = NULL, max = NULL, format = "yyyy-mm-dd",
                                 startview = "month", minviewmode = "months",
                                 weekstart = 0, language = "en",
                                 separator = " to ", width = NULL,
                                 autoclose = TRUE) {
  # If start, end, mix, or max are date objects, convert to a string with
  # yyyy-mm-dd format
  if (inherits(start, "Date")) start <- format(start, "%Y-%m-%d")
  if (inherits(end, "Date")) end <- format(end, "%Y-%m-%d")
  if (inherits(min, "Date")) min <- format(min, "%Y-%m-%d")
  if (inherits(max, "Date")) max <- format(max, "%Y-%m-%d")

  restored <- restoreInput(id = inputId, default = list(start, end))
  start <- restored[[1]]
  end <- restored[[2]]

  htmltools::attachDependencies(
    div(
      id = inputId,
      class = "shiny-date-range-input form-group shiny-input-container",
      style = htmltools::css(width = validateCssUnit(width)),

      # controlLabel(inputId, label),
      shinyInputLabel(inputId, label),
      # input-daterange class is needed for dropdown behavior
      div(
        class = "input-daterange input-group input-group-sm",
        tags$input(
          class = "form-control",
          type = "text",
          # `aria-labelledby` attribute is required for accessibility
          `aria-labelledby` = paste0(inputId, "-label"),
          # title attribute is announced for screen readers for date format.
          title = paste("Date format:", format),
          `data-date-language` = language,
          `data-date-week-start` = weekstart,
          `data-date-format` = format,
          `data-date-start-view` = startview,
          `data-date-min-view-mode` = minviewmode,
          `data-min-date` = min,
          `data-max-date` = max,
          `data-initial-date` = start,
          `data-date-autoclose` = if (autoclose) "true" else "false"
        ),
        span(
          class = "input-group-addon input-group-prepend input-group-append",
          span(
            class = "input-group-text",
            separator
          )
        ),
        tags$input(
          class = "form-control",
          type = "text",
          # `aria-labelledby` attribute is required for accessibility
          `aria-labelledby` = paste0(inputId, "-label"),
          # title attribute is announced for screen readers for date format.
          title = paste("Date format:", format),
          `data-date-language` = language,
          `data-date-week-start` = weekstart,
          `data-date-format` = format,
          `data-date-start-view` = startview,
          `data-date-min-view-mode` = minviewmode,
          `data-min-date` = min,
          `data-max-date` = max,
          `data-initial-date` = end,
          `data-date-autoclose` = if (autoclose) "true" else "false"
        )
      )
    ),
    datePickerDependency()
  )
}

shinyInputLabel <- function(inputId, label = NULL) {
  tags$label(
    label,
    class = "control-label",
    class = if (is.null(label)) "shiny-label-null",
    # `id` attribute is required for `aria-labelledby` used by screen readers:
    id = paste0(inputId, "-label"),
    `for` = inputId
  )
}

datePickerDependency <- function(theme) {
  list(
    htmltools::htmlDependency(
      name = "bootstrap-datepicker-js",
      version = version_bs_date_picker,
      src = "www/shared/datepicker",
      package = "shiny",
      script = if (getOption("shiny.minified", TRUE)) {
        "js/bootstrap-datepicker.min.js"
      } else {
        "js/bootstrap-datepicker.js"
      },
      # Need to enable noConflict mode. See #1346.
      head = "<script>(function() {
        var datepicker = $.fn.datepicker.noConflict();
        $.fn.bsDatepicker = datepicker;
      })();
     </script>"
    ),
    bslib::bs_dependency_defer(datePickerCSS)
  )
}

datePickerCSS <- function(theme) {
  if (!bslib::is_bs_theme(theme)) {
    return(htmltools::htmlDependency(
      name = "bootstrap-datepicker-css",
      version = version_bs_date_picker,
      src = "www/shared/datepicker",
      package = "shiny",
      stylesheet = "css/bootstrap-datepicker3.min.css"
    ))
  }

  scss_file <- system_file(package = "shiny",
                           "www/shared/datepicker/scss/build3.scss")

  bslib::bs_dependency(
    input = sass::sass_file(scss_file),
    theme = theme,
    name = "bootstrap-datepicker",
    version = version_bs_date_picker,
    cache_key_extra = get_package_version("shiny")
  )
}

version_bs_date_picker <- "1.9.0"
