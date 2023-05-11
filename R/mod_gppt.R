#' gppt UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
mod_gppt_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidRow(
      column(9,
        selectInput(
          ns("question"),
          "Question",
          choices = list(
            "How easy is it to use your GP practice's website to look for information or access services?" = "Q04",
            "Were you satisfied with the appointment (or appointments) you were offered?" = "Q16",
            "Generally, how easy is it to get through to someone at your GP practice on the phone?" = "Q01"
          ), width = "100%"
          ), multiple = FALSE
      )
    ),
    column(9, plotOutput(ns("gppt_plot"), width = "100%")),
    column(9, DT::DTOutput(ns("gppt_table"), width = "100%"))
  )
}


#' gppt Server Functions
#'
#' @noRd
mod_gppt_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    observeEvent(input$question, {})

    output$gppt_plot <- renderPlot({
      shinipsum::random_ggplot("histogram")
    })

    output$gppt_table <- DT::renderDT({
      shinipsum::random_DT(nrow = 100, ncol = 5)
    })
  })
}
