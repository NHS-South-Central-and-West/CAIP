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
        width = 12,
        offset = 0.5,
        align = "center",
        tags$br(),
        selectizeInput(
          ns("question"),
          "Question",
          choices = NULL,
          width = "120%"
        )
      )
    ),
    column(
      width = 12,
      align = "center",
      plotOutput(ns("gppt_plot"), width = 1000, height = 500),
      DT::DTOutput(ns("gppt_table"), width = 1000)
    )
  )
}


#' GP Patient Survey Server Functions
#'
#' @param filters_res Parameters passed from filters module
#'
#' @noRd
mod_gppt_server <- function(id, data, filters_res) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    updateSelectizeInput(
      session,
      "question",
      choices = sort(unique(data$question)),
      server = TRUE
    )

    gppt_data <- reactive({
      if (filters_res$level() == "National") {
        get_gppt_data(level = "National", qn = input$question)
      } else if (filters_res$level() == "Regional") {
        if (filters_res$region() == "") {
          get_gppt_data(level = "National", qn = input$question)
        } else {
          get_gppt_data(
            level = "Regional", qn = input$question,
            org = filters_res$region()
          )
        }
      } else if (filters_res$level() == "ICB") {
        if ((filters_res$icb() == "") &
          (filters_res$region() == "")) {
          get_gppt_data(level = "National", qn = input$question)
        } else if (filters_res$icb() == "") {
          get_gppt_data(
            level = "Regional", qn = input$question,
            org = filters_res$region()
          )
        } else {
          get_gppt_data(
            level = "ICB", qn = input$question,
            org = filters_res$icb()
          )
        }
      } else if (filters_res$level() == "PCN") {
        if ((filters_res$pcn() == "") &
          (filters_res$icb() == "") &
          (filters_res$region() == "")) {
          get_gppt_data(level = "National", qn = input$question)
        } else if ((filters_res$pcn() == "") &
          (filters_res$icb() == "")) {
          get_gppt_data(
            level = "Regional", qn = input$question,
            org = filters_res$region()
          )
        } else if (filters_res$pcn() == "") {
          get_gppt_data(
            level = "ICB", qn = input$question,
            org = filters_res$icb()
          )
        } else {
          get_gppt_data(
            level = "PCN", qn = input$question,
            org = filters_res$pcn()
          )
        }
      } else {
        if ((filters_res$practice() == "") &
          (filters_res$pcn() == "") &
          (filters_res$icb() == "") &
          (filters_res$region() == "")) {
          get_gppt_data(level = "National", qn = input$question)
        } else if ((filters_res$practice() == "") &
          (filters_res$pcn() == "") &
          (filters_res$icb() == "")) {
          get_gppt_data(
            level = "Regional", qn = input$question,
            org = filters_res$region()
          )
        } else if ((filters_res$practice() == "") &
          (filters_res$pcn() == "")) {
          get_gppt_data(
            level = "ICB", qn = input$question,
            org = filters_res$icb()
          )
        } else if (filters_res$practice() == "") {
          get_gppt_data(
            level = "PCN", qn = input$question,
            org = filters_res$pcn()
          )
        } else {
          get_gppt_data(
            level = "GP Practice", qn = input$question,
            org = filters_res$practice()
          )
        }
      }
    })

    plot_title <- reactive({
      input$question
    })

    plot_subtitle <- reactive({
      if (filters_res$level() == "National") {
        "AGGREGATED NATIONAL AVERAGE"
      } else if (filters_res$level() == "Regional") {
        filters_res$region()
      } else if (filters_res$level() == "ICB") {
        filters_res$icb()
      } else if (filters_res$level() == "PCN") {
        filters_res$pcn()
      } else if (filters_res$level() == "GP Practice") {
        filters_res$practice()
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
