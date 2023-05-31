#' The Server Side of the Application
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # List the first level callModules here
  r <- reactiveValues()

  gppt <- CAP::gppt

  mod_filters <- mod_filters_server("filters", gppt)

  mod_gppt <- mod_gppt_server("gppt", gppt, mod_filters)
  mod_fft_server("fft")
  mod_methodology_server("methodology")

  mod_downloads_server("downloads", mod_filters, mod_gppt)
}
