#' GP Patient Survey UI Function
#'
#' @description A Shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
mod_gppt_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidRow(
      column(
        width = 9,
        offset = 1,
        align = "center",
        selectizeInput(
          ns("question"),
          "Question",
          choices = NULL,
          width = "120%"
        )
      )
    ),
    column(
      width = 9,
      align = "center",
      plotOutput(ns("gppt_plot"), width = 1000, height = 500),
      DT::DTOutput(ns("gppt_table"), width = 1000)
    )
  )
}


#' GP Patient Survey Server Functions
#'
#' @noRd
mod_gppt_server <- function(id, data, filters_output) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    updateSelectizeInput(
      session,
      "question",
      choices = data |> dplyr::distinct(question) |> dplyr::pull(),
      server = TRUE
    )

    gppt_data <- reactive({
      if (filters_output$level() == "National") {
        data |>
          dplyr::filter(
            question == input$question,
            !is.na(response_scale)
          ) |>
          dplyr::summarise(
            value = sum(value),
            .by = c(year, question, question_number, answer, response_scale)
          )
      } else {
        data |>
          dplyr::filter(
            question == input$question,
            conditional(filters_output$region() != "", region == filters_output$region()),
            conditional(filters_output$icb() != "", icb == filters_output$icb()),
            conditional(filters_output$pcn() != "", pcn == filters_output$pcn()),
            conditional(filters_output$practice() != "", practice == filters_output$practice()),
            !is.na(response_scale)
          ) |>
          dplyr::select(
            region, icb, pcn, practice,
            question_number, question, answer, value,
            year, response_scale
          )
      }
    })

    plot_title <- reactive({
      input$question
    })

    plot_subtitle <- reactive({
      if (filters_output$level() == "National") {
        "AGGREGATED NATIONAL AVERAGE"
      } else if (filters_output$level() == "Regional") {
        filters_output$region()
      } else if (filters_output$level() == "ICB") {
        filters_output$icb()
      } else if (filters_output$level() == "PCN") {
        filters_output$pcn()
      } else if (filters_output$level() == "GP Practice") {
        filters_output$practice()
      }
    })

    gppt_plot <- reactive({
      plot <- gppt_data() |>
        ggplot2::ggplot(ggplot2::aes(
          x = factor(year), y = value,
          fill = stats::reorder(answer, response_scale)
        )) +
        ggplot2::geom_bar(
          stat = "identity", position = "fill",
          colour = "#333333", linewidth = 1
        ) +
        ggplot2::geom_hline(yintercept = 0, linewidth = 1, colour = "#333333") +
        ggplot2::scale_y_continuous(labels = scales::label_percent()) +
        scwplot::theme_scw(base_size = 12) +
        scwplot::scale_fill_diverging(reverse = FALSE, discrete = TRUE) +
        ggplot2::labs(
          title = plot_title(),
          subtitle = plot_subtitle(),
          x = NULL, y = "% Respondents"
        )

      return(plot)
    })

    output$gppt_plot <- renderPlot({
      gppt_plot()
    })


    output$gppt_table <- DT::renderDT({
      DT::datatable(
        gppt_data() |>
          dplyr::mutate(
            total = sum(value),
            value = scales::percent(value / total),
            .by = year
          ) |>
          dplyr::arrange(year, response_scale) |>
          dplyr::select(!c(total, response_scale, question, question_number)) |>
          tidyr::pivot_wider(
            names_from = answer,
            values_from = value
          ) |>
          dplyr::rename_with(
            ~ snakecase::to_title_case(
              .x,
              abbreviations = c("ICB", "PCN", "I", "'")
            )
          ),
        options = list(
          dom = "tip",
          columnDefs = list(list(targets = "_all", className = "dt-center"))
        ),
        rownames = FALSE
      )
    })

    return(
      list(data = reactive({gppt_data()}),
           plot = reactive({gppt_plot()}))
      )


  })
}
