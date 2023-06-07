#' About UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_about_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        width = 12,
        align = "left",
        offset = 0.5,
        tags$br(),
        includeHTML(
          system.file("app/www/about.html", package = "CAIP")
        )
      )
    )
  )
}

#' About Server Functions
#'
#' @noRd
mod_about_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}
