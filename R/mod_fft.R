#' Friends & Family Test UI Function
#'
#' @description A Shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
mod_fft_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidRow(
      column(
        width = 9,
        offset = 1,
        align = "center",
        dateRangeInput(
          inputId = ns("fft_years"),
          label = "Date Range",
          format = "yyyy", startview = "year",
          width = "120%"
        )
      ),
      column(
        width = 9,
        align = "center",
        plotOutput(ns("fft_plot"), width = "120%"),
        DT::DTOutput(ns("fft_table"), width = "120%")
      )
    )
  )
}

#' Friends & Family Test Server Functions
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
  })
}
