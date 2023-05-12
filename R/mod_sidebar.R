#' Sidebar UI Function
#'
#' @description Module for the app sidebar. The main data processing is handled
#' by it.
#'
#' @param id Module's ID
#'
#' @noRd
mod_sidebar_ui <- function(id) {
  ns <- NS(id)

  tagList(
    column(12,
      align = "left",
      tags$p(
        "National, PCN, and practice level aggregated",
        "responses to the GP Patient Survey."
      ),
      selectInput(
        inputId = ns("level"),
        label = "Level",
        choices = c("National", "ICB", "PCN", "Practice"),
        selected = "National"
      ),
      shinyjs::hidden(
        selectInput(
          inputId = ns("region"),
          label = "Region",
          choices = c(
            "All",
            "Y63 - North East and Yorkshire",
            "Y60 - Midlands",
            "Y58 - South West"
          ),
          selected = "All"
        )
      ),
      shinyjs::hidden(
        selectInput(
          inputId = ns("icb"),
          label = "ICB",
          choices = c(
            "All",
            "QOQ - Humber and North Yorkshire",
            "QHL - Birmingham and Solihull",
            "QK1 - Leicester, Leicestershire and Rutland"
          ),
          selected = "All"
        )
      ),
      shinyjs::hidden(
        selectInput(
          inputId = ns("pcn"),
          label = "PCN",
          choices = c(
            "All",
            "U49944 - Upper Don Valley",
            "U52297 - Sunderland East",
            "U41928 - Solihull Rural",
            "U81960 - St John's Wood & Maida Vale"
          ),
          selected = "All"
        )
      ),
      shinyjs::hidden(
        selectInput(
          inputId = ns("practice"),
          label = "GP Practice",
          choices = list(
            "All",
            "K84003 - Islip Surgery",
            "K84042 - Woodstock Surgery",
            "K84028 - Banbury Cross Health Centre"
          ),
          selected = "All",
          multiple = FALSE
        )
      ),
      tags$p("If you would like to compare an organisation (Region, ICB, PCN,
             GP Practice) with similar organisations of the same aggregate
             level, click the switch below:"),
    ),
    column(
      width = 12,
      align = "center",
      shinyWidgets::switchInput(
        inputId = ns("comparison"),
        label = "Compare",
        size = "normal",
        width = "50%",
        value = FALSE
      )
    ),
    column(
      width = 12,
      align = "left",
      tags$h4("Technical Details"),
      tags$p("This report contains data for the GP Patient Survey collected from
           patients aged 16+ registered with a GP practice in England."),
      tags$p("Data are weighted by age and gender to reflect the population of
           eligible patients within each practice and ICS."),
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
      tags$h4("More Information"),
      tags$a(
        href = "https://gp-patient.co.uk/faq",
        target = "_blank", icon("link"),
        "See the GP Patient Survey website FAQ
             for more information about the survey."
      ),
      tags$hr()
    ),
    column(
      width = 6,
      align = "center",
      downloadButton(outputId = ns("download_data"), label = "Download Data")
    ),
    column(
      width = 6,
      align = "center",
      downloadButton(outputId = ns("download_plot"), label = "Download Plot")
    )
  )
}

#' Sidebar Server Function
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


      observeEvent(input$level, {
        if (input$level != "National") {
          shinyjs::show("region", anim = TRUE, animType = "fade", time = .2)
          shinyjs::show("icb", anim = TRUE, animType = "slide", time = 1.2)
          shinyjs::show("pcn", anim = TRUE, animType = "slide", time = 1.2)
          shinyjs::show("practice", anim = TRUE, animType = "slide", time = 1.2)
        } else {
          shinyjs::hide("region", anim = TRUE, animType = "fade", time = .2)
          shinyjs::hide("icb", anim = TRUE, animType = "slide", time = 1.2)
          shinyjs::hide("pcn", anim = TRUE, animType = "slide", time = 1.2)
          shinyjs::hide("practice", anim = TRUE, animType = "slide", time = 1.2)
        }
      })
    }
  )
}
