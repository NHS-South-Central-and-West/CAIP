#' Sidebar Downloads UI Function
#'
#' @description Module for the app sidebar's download functionality.
#'
#' @param id Module's ID
#'
#' @noRd
mod_downloads_ui <- function(id) {
  ns <- NS(id)

  tagList(
    column(
      width = 12,
      align = "left",
      tags$br(),
      tags$p(
        "To download the plots or the data shown in the tab you are currently
        viewing, use the ",
        fontawesome::fa_i(name = "download", fill_opacity = 1),
        " buttons in the main panel."
      ),
      tags$br(),
      #   tags$br(),
      #   tags$p(
      #     "For a detailed report about the organisation you have selected in the
      #     dropdown filters above, including national comparisons and comparisons
      #     with similar organisations, use the download button below:"
      #   ),
      #   tags$br()
      # ),
      # column(
      #   width = 12,
      #   align = "center",
      #   downloadButton(outputId = ns("download_report"), label = "Download Report")
    ),
    column(
      width = 12,
      align = "center",
      offset = 0.5,
      tags$hr(),
      tags$b("This app is in active development. Features will be added and
               bugs will be squashed.",
        style = "color:#B82A4E"
      ),
      tags$br(),
      tags$br(),
      tags$b("If you spot any errors, however, please let us know!",
        style = "color:#B82A4E"
      ),
      tags$br()
    )
  )
}

#' Sidebar Downloads Server Function
#'
#' @param id Module's ID
#' @param input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_downloads_server <- function(id, filters_res, panel_res) {
  moduleServer(
    id = id,
    function(input, output, session) {
      ns <- session$ns
    }
  )
}
