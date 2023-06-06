#' Friends & Family Test UI Function
#'
#' @description A Shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
mod_fft_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidRow(
      column(
        width = 12,
        offset = 0.5,
        align = "center",
        tags$br(),
        dateRangeMonthsInput(
          inputId = ns("date_range"),
          label = "Date Range",
          format = "M yyyy",
          startview = "year",
          start = "2015-12-01",
          end = Sys.Date(),
          min = "2015-12-01",
          max = Sys.Date(),
          width = "120%"
        )
      ),
      column(
        width = 12,
        align = "center",
        plotOutput(ns("fft_plot"), width = 1000, height = 500),
        DT::DTOutput(ns("fft_table"), width = 1000)
      )
    )
  )
}


#' Friends & Family Test Server Functions
#'
#' @noRd
mod_fft_server <- function(id, data, filters_res) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    fft_data <- reactive({
      if (filters_res$level() == "National") {
        get_fft_data(
          level = "National",
          date_from = reset_monthday(input$date_range[1]),
          date_to = reset_monthday(input$date_range[2])
        )
      } else if (filters_res$level() == "Regional") {
        if (filters_res$region() == "") {
          get_fft_data(
            level = "National",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2])
          )
        } else {
          get_fft_data(
            level = "Regional",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2]),
            org = filters_res$region()
          )
        }
      } else if (filters_res$level() == "ICB") {
        if ((filters_res$icb() == "") &
          (filters_res$region() == "")) {
          get_fft_data(
            level = "National",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2])
          )
        } else if (filters_res$icb() == "") {
          get_fft_data(
            level = "Regional",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2]),
            org = filters_res$region()
          )
        } else {
          get_fft_data(
            level = "ICB",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2]),
            org = filters_res$icb()
          )
        }
      } else if (filters_res$level() == "PCN") {
        if ((filters_res$pcn() == "") &
          (filters_res$icb() == "") &
          (filters_res$region() == "")) {
          get_fft_data(
            level = "National",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2])
          )
        } else if ((filters_res$pcn() == "") &
          (filters_res$icb() == "")) {
          get_fft_data(
            level = "Regional",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2]),
            org = filters_res$region()
          )
        } else if (filters_res$pcn() == "") {
          get_fft_data(
            level = "ICB",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2]),
            org = filters_res$icb()
          )
        } else {
          get_fft_data(
            level = "PCN",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2]),
            org = filters_res$pcn()
          )
        }
      } else {
        if ((filters_res$practice() == "") &
          (filters_res$pcn() == "") &
          (filters_res$icb() == "") &
          (filters_res$region() == "")) {
          get_fft_data(
            level = "National",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2])
          )
        } else if ((filters_res$practice() == "") &
          (filters_res$pcn() == "") &
          (filters_res$icb() == "")) {
          get_fft_data(
            level = "Regional",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2]),
            org = filters_res$region()
          )
        } else if ((filters_res$practice() == "") &
          (filters_res$pcn() == "")) {
          get_fft_data(
            level = "ICB",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2]),
            org = filters_res$icb()
          )
        } else if (filters_res$practice() == "") {
          get_fft_data(
            level = "PCN",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2]),
            org = filters_res$pcn()
          )
        } else {
          get_fft_data(
            level = "GP Practice",
            date_from = reset_monthday(input$date_range[1]),
            date_to = reset_monthday(input$date_range[2]),
            org = filters_res$practice()
          )
        }
      }
    })

    plot_title <- reactive({
      paste0("Friends and Family Test", input$date_range[1] - input$date_range[2])
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

    fft_plot <- reactive({
      plot <- fft_data() |>
        dplyr::group_by(
          date = lubridate::floor_date(date, "year"),
          answer, response_scale
        ) |>
        dplyr::reframe(value = sum(value)) |>
        dplyr::mutate(
          total = sum(value),
          value = value / total,
          .by = c(date)
        ) |>
        ggplot2::ggplot(ggplot2::aes(
          x = as.Date(date), y = value,
          colour = stats::reorder(answer, response_scale),
          fill = stats::reorder(answer, response_scale)
        )) +
        ggplot2::geom_line(size = 1 * 1.2, colour = "#333333") +
        ggplot2::geom_line(size = 1) +
        ggplot2::geom_point(shape = 21, size = 5, colour = "#333333") +
        scwplot::theme_scw() +
        ggplot2::scale_x_date(date_breaks = "1 years", date_labels = "%Y") +
        ggplot2::scale_y_continuous(
          labels = scales::label_percent(),
          limits = c(0, 1)
        ) +
        scwplot::scale_colour_diverging(discrete = TRUE) +
        scwplot::scale_fill_diverging(discrete = TRUE) +
        ggplot2::labs(
          title = "Friends and Family Test",
          subtitle = plot_subtitle(),
          x = NULL, y = "% Respondents"
        ) +
        ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, vjust = 0.5))

      return(plot)
    })

    output$fft_plot <- renderPlot({
      fft_plot()
    })

    output$fft_table <- DT::renderDT({
      DT::datatable(
        fft_data() |>
          dplyr::mutate(
            total = sum(.data$value),
            value = scales::percent(.data$value / .data$total),
            .by = "date"
          ) |>
          dplyr::arrange(.data$date, .data$response_scale) |>
          dplyr::mutate(date = format(.data$date, format = "%b %Y")) |>
          dplyr::select(!c("total", "response_scale")) |>
          tidyr::pivot_wider(
            names_from = "answer",
            values_from = "value"
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
          fft_data()
        }),
        plot = reactive({
          fft_plot()
        })
      )
    )
  })
}
