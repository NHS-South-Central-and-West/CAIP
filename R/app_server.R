#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  r = reactiveValues(
    level = NULL,
    practice_code = NULL,
    question = NULL
  )
  mod_sidebar_server("sidebar", r)
  mod_plot_server("plot_1")
  mod_table_server("table_1")

}
