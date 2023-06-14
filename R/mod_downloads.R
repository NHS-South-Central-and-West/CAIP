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
      div(
        "To download displayed plots and data, use the ",
        fontawesome::fa_i(name = "download", fill_opacity = 1),
        " buttons in the main panel."
      ),
      # br(),
      # p("For a detailed report about the organisation you have selected in the
      #   dropdown filters above, including national comparisons and comparisons
      #   with similar organisations, use the download button below:"),
      # br()
      # ),
      # column(
      #   width = 12,
      #   align = "center",
      #   downloadButton(outputId = ns("download_report"),
      #                  label = "Download Report")
    ),
    column(
      width = 12,
      align = "center",
      offset = 0.5,
      hr(),
      div("This app is in active development. Features will be added and
        bugs will be squashed.",
        style = "color:#B82A4E; font-weight: bold;"
      ),
      br(),
      div("If you spot any errors, however, please let us know:",
        style = "color:#B82A4E; font-weight: bold;"
      )
    ),
    column(
      width = 6,
      align = "center",
      br(),
      div(class = "fa-regular fa-envelope", style = "color:#B82A4E"),
      a("Email",
        target = "_blank",
        href = "mailto:scwcsu.primarycaresupport@nhs.net",
        style = "color:#B82A4E; font-weight: bold;"
      )
    ),
    column(
      width = 6,
      align = "center",
      br(),
      div(class = "fa-brands fa-github", style = "color:#B82A4E"),
      a("GitHub",
        target = "_blank",
        href = "https://github.com/NHS-South-Central-and-West/CAIP/issues",
        style = "color:#B82A4E; font-weight: bold;"
      )
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
