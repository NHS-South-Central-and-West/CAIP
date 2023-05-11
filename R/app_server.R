#' The Server Side of the Application
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # List the first level callModules here
  r <- reactiveValues()

  mod_sidebar_server("sidebar", r)
  mod_gppt_server("gppt_1")
  mod_fft_server("fft_1")
}
