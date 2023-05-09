#' sidebar UI Function
#'
#' @description Module for the sidebar. The main data processing is handled by it.
#'
#' @param id Module's ID
#'
#' @import shiny
#'
#' @noRd
mod_sidebar_ui <- function(id) {
  ns <- NS(id)

  tagList(
    column(8,
      align = "left",
      tags$p(
        "National, PCN, and practice level aggregated",
        "responses to the GP Patient Survey."
      ),
      selectizeInput(
        inputId = ns("level"),
        label = "Level",
        choices = c("National", "PCN", "Practice")
      ),
      selectInput(
        ns("practice_code"),
        "GP Practice",
        choices = list(
          "Islip Surgery" = "K84003",
          "Woodstock Surgery" = "K84042",
          "Banbury Cross Health Centre" = "K84028"
        ), multiple = FALSE
      ),
      selectInput(
        ns("question"),
        "Question",
        choices = list(
          glue::glue(
            "How easy is it to use your GP practice's website to look ",
            "for information or access services?" = "Q04"
          ),
          glue::glue(
            "Were you satisfied with the appointment (or appointments) ",
            "you were offered?" = "Q16",
          ),
          glue::glue(
            "Generally, how easy is it to get through to someone at ",
            "your GP practice on the phone?" = "Q01"
          )
        ), multiple = FALSE
      )
    )
  )
}

#' sidebar Server Function
#'
#' @param id Module's ID
#' @param input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_sidebar_server <- function(id, r) {
  moduleServer(
    id = id,
    function(input, output, session) {
      ns <- session$ns

      observeEvent(input$level, {})

      observeEvent(input$practice_code, {})

      observeEvent(input$question, {})

      return(
        list(
          level = reactive({
            input$level
          }),
          practice_code = reactive({
            input$practice_code
          }),
          question = reactive({
            input$question
          })
        )
      )
    }
  )
}
