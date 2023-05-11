#' fft UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
mod_fft_ui <- function(id) {

  ns <- NS(id)

  tagList(
    fluidRow(
      column(9, plotOutput(ns("fft_plot"), width = "100%")),
      column(9, DT::DTOutput(ns("fft_table"), width = "100%"))
    )
  )
}

#' fft Server Functions
#'
#' @noRd
mod_fft_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$fft_plot <- renderPlot({
      shinipsum::random_ggplot("histogram")
    })

    output$fft_table <- DT::renderDT({
      shinipsum::random_DT(nrow = 100, ncol = 5)
    })

  }
  )
}
