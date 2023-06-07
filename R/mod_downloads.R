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
      tags$p("To download the plot or the data in the tab you are currently
             viewing, click the buttons below:")
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
mod_downloads_server <- function(id, filters_output, panel_output) {
  moduleServer(
    id = id,
    function(input, output, session) {
      ns <- session$ns

      filename <-
        reactive({
          if (filters_output$level() == "National") {
            filters_output$level() |>
              stringr::str_to_lower()
          } else if (filters_output$level() == "Regional") {
            if (filters_output$region() == "") {
              "National" |>
                stringr::str_to_lower()
            } else {
              filters_output$region() |>
                stringr::str_remove(pattern = "\\ - .*") |>
                stringr::str_to_lower()
            }
          } else if (filters_output$level() == "ICB") {
            if ((filters_output$icb() == "") &
              (filters_output$region() == "")) {
              "National" |>
                stringr::str_to_lower()
            } else if (filters_output$icb == "") {
              filters_output$region() |>
                stringr::str_remove(pattern = "\\ - .*") |>
                stringr::str_to_lower()
            } else {
              filters_output$icb() |>
                stringr::str_remove(pattern = "\\ - .*") |>
                stringr::str_to_lower()
            }
          } else if (filters_output$level() == "PCN") {
            if ((filters_output$pcn() == "") &
              (filters_output$icb() == "") &
              (filters_output$region() == "")) {
              "National" |>
                stringr::str_to_lower()
            } else if ((filters_output$pcn() == "") &
              (filters_output$icb() == "")) {
              filters_output$region() |>
                stringr::str_remove(pattern = "\\ - .*") |>
                stringr::str_to_lower()
            } else if (filters_output$pcn() == "") {
              filters_output$icb() |>
                stringr::str_remove(pattern = "\\ - .*") |>
                stringr::str_to_lower()
            } else {
              filters_output$pcn() |>
                stringr::str_remove(pattern = "\\ - .*") |>
                stringr::str_to_lower()
            }
          } else if (filters_output$level() == "GP Practice") {
            if ((filters_output$practice() == "") &
              (filters_output$pcn() == "") &
              (filters_output$icb() == "") &
              (filters_output$region() == "")) {
              "National" |>
                stringr::str_to_lower()
            } else if ((filters_output$practice() == "") &
              (filters_output$pcn() == "") &
              (filters_output$icb() == "")) {
              filters_output$region() |>
                stringr::str_remove(pattern = "\\ - .*") |>
                stringr::str_to_lower()
            } else if ((filters_output$practice() == "") &
              (filters_output$pcn() == "")) {
              filters_output$icb() |>
                stringr::str_remove(pattern = "\\ - .*") |>
                stringr::str_to_lower()
            } else if (filters_output$practice() == "") {
              filters_output$pcn() |>
                stringr::str_remove(pattern = "\\ - .*") |>
                stringr::str_to_lower()
            } else {
              filters_output$practice() |>
                stringr::str_remove(pattern = "\\ - .*") |>
                stringr::str_to_lower()
            }
          }
        })

      data <- reactive({
        panel_output$data()
      })

      plot <- reactive({
        panel_output$plot()
      })

      output$download_data <- downloadHandler(
        filename = function() {
          # Use the selected dataset as the suggested file name
          paste0(filename(), "_gppt_data.csv")
        },
        content = function(file) {
          # Write the dataset to the `file` that will be downloaded
          readr::write_csv(data(), file)
        }
      )

      output$download_plot <- downloadHandler(
        filename = function() {
          # Use the selected dataset as the suggested file name
          paste0(filename(), "_gppt_plot.png")
        },
        content = function(file) {
          # Write the dataset to the `file` that will be downloaded

          ggplot2::ggsave(file, plot(), width = 20, height = 10, dpi = 320)
        }
      )
    }
  )
}
