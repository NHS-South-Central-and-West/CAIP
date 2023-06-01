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
#' @param filters_output Parameters passed from filters module
#'
#' @noRd
mod_gppt_server <- function(id, data, filters_output) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    updateSelectizeInput(
      session,
      "question",
      choices = sort(unique(data$question)),
      server = TRUE
    )

    gppt_data <- reactive({
      if (filters_output$level() == "National") {
        data |>
          dplyr::filter(
            question == input$question,
            !is.na(.data$response_scale)
          ) |>
          dplyr::summarise(
            value = sum(.data$value),
            .by = c(
              .data$year, .data$question, .data$question_number,
              .data$answer, .data$response_scale
            )
          )
      } else if (filters_output$level() == "Regional") {
        data |>
          dplyr::filter(
            question == input$question,
            conditional(
              filters_output$region() != "",
              region == filters_output$region()
            ),
            !is.na(.data$response_scale)
          ) |>
          dplyr::summarise(
            value = sum(.data$value),
            .by = c(
              .data$year, .data$region, .data$question,
              .data$question_number, .data$answer,
              .data$response_scale
            )
          )
      } else if (filters_output$level() == "ICB") {
        data |>
          dplyr::filter(
            question == input$question,
            conditional(
              filters_output$region() != "",
              region == filters_output$region()
            ),
            conditional(
              filters_output$icb() != "",
              icb == filters_output$icb()
            ),
            !is.na(.data$response_scale)
          ) |>
          dplyr::summarise(
            value = sum(.data$value),
            .by = c(
              .data$year, .data$icb, .data$question,
              .data$question_number, .data$answer,
              .data$response_scale
            )
          )
      } else if (filters_output$level() == "PCN") {
        data |>
          dplyr::filter(
            question == input$question,
            conditional(
              filters_output$region() != "",
              region == filters_output$region()
            ),
            conditional(
              filters_output$icb() != "",
              icb == filters_output$icb()
            ),
            conditional(
              filters_output$pcn() != "",
              pcn == filters_output$pcn()
            ),
            !is.na(.data$response_scale)
          ) |>
          dplyr::summarise(
            value = sum(.data$value),
            .by = c(
              .data$year, .data$pcn, .data$question,
              .data$question_number, .data$answer,
              .data$response_scale
            )
          )
      } else {
        data |>
          dplyr::filter(
            question == input$question,
            conditional(
              filters_output$region() != "",
              region == filters_output$region()
            ),
            conditional(
              filters_output$icb() != "",
              icb == filters_output$icb()
            ),
            conditional(
              filters_output$pcn() != "",
              pcn == filters_output$pcn()
            ),
            conditional(
              filters_output$practice() != "",
              practice == filters_output$practice()
            ),
            !is.na(.data$response_scale)
          ) |>
          dplyr::select(
            .data$region, .data$icb, .data$pcn, .data$practice,
            .data$question_number, .data$question, .data$answer,
            .data$value, .data$region, .data$year, .data$response_scale
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
          x = factor(.data$year), y = .data$value,
          fill = stats::reorder(.data$answer, .data$response_scale)
        )) +
        ggplot2::geom_col(
          position = "fill", colour = "#333333",
          linewidth = 0.6
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
            total = sum(.data$value),
            value = scales::percent(.data$value / .data$total),
            .by = .data$year
          ) |>
          dplyr::arrange(.data$year, .data$response_scale) |>
          dplyr::select(!c(
            .data$total, .data$response_scale,
            .data$question, .data$question_number
          )) |>
          tidyr::pivot_wider(
            names_from = .data$answer,
            values_from = .data$value
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
      list(
        data = reactive({
          gppt_data()
        }),
        plot = reactive({
          gppt_plot()
        })
      )
    )
  })
}
