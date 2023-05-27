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
    tags$hr(),
    column(12,
      align = "left",
      tags$p(
        "National, Regional, ICB, PCN, and GP Practice level aggregated
        responses to the GP Patient (GPPT) and Friends & Family Test (FFT)
        surveys."
      ),
      tags$br(),
      tags$p("Select the level at which you want to aggregate the GPPT and FFT
             responses, before choosing any filters needed for the data that you
             are interested in."),
      selectInput(
        inputId = ns("level"),
        label = "Level",
        choices = c("National", "Regional", "ICB", "PCN", "GP Practice"),
        selected = "National"
      ),
      shinyjs::hidden(
        selectizeInput(
          inputId = ns("region"),
          label = "Region",
          choices = NULL
          )
      ),
      shinyjs::hidden(
        selectizeInput(
          inputId = ns("icb"),
          label = "ICB",
          choices = NULL
        )
      ),
      shinyjs::hidden(
        selectizeInput(
          inputId = ns("pcn"),
          label = "PCN",
          choices = NULL
        )
      ),
      shinyjs::hidden(
        selectizeInput(
          inputId = ns("practice"),
          label = "GP Practice",
          choices = NULL
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
    )
  )
}

#' Sidebar Server Function
#'
#' @param id Module's ID
#' @param input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_sidebar_server <- function(id, data) {
  moduleServer(
    id = id,
    function(input, output, session) {
      ns <- session$ns

      observeEvent(input$level, {
        if (input$level == "Regional") {
          shinyjs::show("region", anim = TRUE, animType = "fade", time = .2)
          shinyjs::hide("icb", anim = TRUE, animType = "slide", time = 1.2)
          shinyjs::hide("pcn", anim = TRUE, animType = "slide", time = 1.2)
          shinyjs::hide("practice", anim = TRUE, animType = "slide", time = 1.2)
        } else if (input$level == "ICB") {
          shinyjs::show("region", anim = TRUE, animType = "fade", time = .2)
          shinyjs::show("icb", anim = TRUE, animType = "slide", time = 1.2)
          shinyjs::hide("pcn", anim = TRUE, animType = "slide", time = 1.2)
          shinyjs::hide("practice", anim = TRUE, animType = "slide", time = 1.2)
        } else if (input$level == "PCN") {
          shinyjs::show("region", anim = TRUE, animType = "fade", time = .2)
          shinyjs::show("icb", anim = TRUE, animType = "slide", time = 1.2)
          shinyjs::show("pcn", anim = TRUE, animType = "slide", time = 1.2)
          shinyjs::hide("practice", anim = TRUE, animType = "slide", time = 1.2)
        } else if (input$level == "GP Practice") {
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

      updateSelectizeInput(
        session,
       "region",
        choices = c(
          "ALL" = "",
          data |> dplyr::distinct(region) |> dplyr::pull()
          ),
        server = TRUE
        )

      updateSelectizeInput(
        session,
       "icb",
        choices = c(
          "ALL" = "",
          data |> dplyr::distinct(icb) |> dplyr::pull()
          ),
        server = TRUE
        )

      updateSelectizeInput(
        session,
       "pcn",
        choices = c(
          "ALL" = "",
          data |> dplyr::distinct(pcn) |> dplyr::pull()
          ),
        server = TRUE
      )

      updateSelectizeInput(
        session,
       "practice",
        choices = c(
          "ALL" = "",
          data |> dplyr::distinct(practice) |> dplyr::pull()
          ),
        server = TRUE
      )

      gppt_data <- reactive({
        if (input$level == "National") {
          data |>
            dplyr::filter(
              question_number == "Q32",
              !is.na(response_scale)) |>
            dplyr::summarise(
              value = sum(value),
              .by = c(year, question, question_number, answer, response_scale)
            )
        } else {
          data |>
            dplyr::filter(
              question_number == "Q32",
              conditional(input$region != "", region == input$region),
              conditional(input$icb != "", icb == input$icb),
              conditional(input$pcn != "", pcn == input$pcn),
              conditional(input$practice != "", practice == input$practice),
              !is.na(response_scale)
            ) |>
            dplyr::select(
              region, icb, pcn, practice,
              question_number, question, answer, value,
              year, response_scale
            )
        }
      })

      output$download_data <- downloadHandler(
        filename = function() {
          # Use the selected dataset as the suggested file name
          paste0(input$level, "_gppt_data.csv")
        },
        content = function(file) {
          # Write the dataset to the `file` that will be downloaded
          readr::write_csv(gppt_data(), file)
        }
      )

      # plot_title <- reactive({ input$question })

      plot_subtitle <- reactive({
        if (input$level == "National") {
          "AGGREGATED NATIONAL AVERAGE"
        } else if (input$level == "Regional") {
          input$region
        } else if (input$level == "ICB") {
          input$icb
        } else if (input$level == "PCN") {
          input$pcn
        } else if (input$level == "GP Practice") {
          input$practice
        }
      })

      gppt_plot <- reactive({
        gppt_plot <- gppt_data() |>
          ggplot2::ggplot(ggplot2::aes(
            x = factor(year), y = value,
            fill = stats::reorder(answer, response_scale))
          ) +
          ggplot2::geom_bar(
            stat = "identity", position = "fill",
            colour = "#333333", linewidth = 1
          ) +
          ggplot2::geom_hline(yintercept = 0, linewidth = 1, colour = "#333333") +
          ggplot2::scale_y_continuous(labels = scales::label_percent()) +
          scwplot::theme_scw(base_size = 12) +
          scwplot::scale_fill_diverging(reverse = FALSE, discrete = TRUE) +
          ggplot2::labs(
            # title = plot_title(),
            subtitle = plot_subtitle(),
            x = NULL, y = "% Respondents"
          )

        return(gppt_plot)
      })

      output$download_plot <- downloadHandler(
        filename = function() {
          # Use the selected dataset as the suggested file name
          paste0(input$level, "_gppt_plot.png")
        },
        content = function(file) {
          # Write the dataset to the `file` that will be downloaded

          ggplot2::ggsave(file, gppt_plot(), width = 12, height = 9, dpi = 320)
        }
      )

      return(
        list(
          level = reactive({ input$level }),
          region = reactive({ input$region }),
          icb = reactive({ input$icb }),
          pcn = reactive({ input$pcn }),
          practice = reactive({ input$practice })
        )
      )

    }
  )
}
