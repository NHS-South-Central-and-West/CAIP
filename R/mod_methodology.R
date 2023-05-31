#' methodology UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_methodology_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        width = 12,
        align = "left",
        tags$h3("Technical Details"),
        tags$p("This report contains data for the GP Patient Survey
               collected from patients aged 16+ registered with a
               GP practice in England."),
        tags$p("Data are weighted by age and gender to reflect the population
               of eligible patients within each practice and ICS."),
        tags$p(
          tags$a(
            href = "https://gp-patient.co.uk/weighted-data",
            target = "_blank", icon("link"),
            "See the GP Patient Survey website for
            further information about weighting."
          )
        ),
        tags$p("Friends and Family Test results are provided
               for practices which have submitted them."),
        tags$p(
          tags$a(
            href = "https://www.england.nhs.uk/fft/friends-and-family-test-data/",
            target = "_blank", icon("link"),
            "See the Friends and Family Test website for further information."
          )
        ),
        tags$hr(),
        tags$h3("More Information"),
        tags$a(
          href = "https://gp-patient.co.uk/faq",
          target = "_blank", icon("link"),
          "See the GP Patient Survey website FAQ
          for more information about the survey."
        ),
        tags$hr(),
        tags$h3("Code"),
        tags$a(
          href = "https://github.com/NHS-South-Central-and-West/CAP",
          target = "_blank", icon("code"),
          "For all code, and to report bugs."
        ),
        tags$hr(),
        tags$h3("Contact"),
        tags$a(
          href = "mailto:scwcsu.primarycaresupport@nhs.net",
          target = "_blank", icon("inbox"),
          "For enquiries, issues, bugs etc."
        ),
        tags$hr()
      )
    )
  )
}

#' methodology Server Functions
#'
#' @noRd
mod_methodology_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}
