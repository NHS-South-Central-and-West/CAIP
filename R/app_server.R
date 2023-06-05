#' The Server Side of the Application
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # List the first level callModules here
  r <- reactiveValues()

  gppt <- CAIP::gppt
  fft <- CAIP::fft

  mod_filters <- mod_filters_server("filters", gppt)

  mod_gppt <- mod_gppt_server("gppt", gppt, mod_filters)
  mod_fft <- mod_fft_server("fft", fft, mod_filters)
  mod_methodology_server("methodology")

  mod_downloads_server("downloads", mod_filters, mod_gppt)
}
