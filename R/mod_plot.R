#' plot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      plotOutput(
        ns("plot"), height = 650
      )
    )
  )
}


#' plot Server Functions
#'
#' @noRd
mod_plot_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$plot <- renderPlot({
      shinipsum::random_ggplot("histogram")
    })
  })
}
## To be copied in the UI
# mod_plot_ui("plot_1")

## To be copied in the server
# mod_plot_server("plot_1")
