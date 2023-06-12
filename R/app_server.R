#' The Server Side of the Application
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # List the first level callModules here
  r <- reactiveValues()


  w <- waiter::Waiter$new()

  # load data
  gppt <- CAIP::gppt
  fft <- CAIP::fft

  mod_filters <- mod_filters_server("filters", gppt)

  mod_gppt <- mod_gppt_server("gppt", gppt, mod_filters)
  mod_fft <- mod_fft_server("fft", fft, mod_filters)
  mod_about_server("about")

  mod_downloads_server("downloads", mod_filters, mod_gppt)

  # set disconnector
  sever::sever(
    html = sever::sever_default(
      title = "You've Been Disconnected!",
      subtitle = "Your session ended because you were idle for too long.",
      button = "Reconnect", button_class = "default"
      ),
    bg_color = "white", color = "black"
    )
}
