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
          width = "auto"
        )
      )
    ),
    column(
      width = 12,
      align = "right",
      shinyWidgets::downloadBttn(
        outputId = ns("download_plot"),
        label = "Download",
        style = "material-circle",
        color = "default",
        size = "sm",
        icon = fa_icon(name = "download", fill_opacity = 1)
      )
    ),
    column(
      width = 12,
      align = "center",
      tags$br(),
      plotOutput(ns("gppt_plot"), width = "auto"),
      tags$br()
    ),
    column(
      width = 12,
      align = "right",
      shinyWidgets::downloadBttn(
        outputId = ns("download_data"),
        label = "Download",
        style = "material-circle",
        color = "default",
        size = "sm",
        icon = fa_icon(name = "download", fill_opacity = 1)
      )
    ),
    column(
      width = 12,
      align = "center",
      tags$br(),
      DT::DTOutput(ns("gppt_table"), width = "auto")
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
      input$question |>
        stringr::str_remove(pattern = ".*\\ - ") |>
        snakecase::to_title_case(abbreviations = c("GP", "Using", "/", "'"))
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
          position = "fill", colour = "#2E2F30",
          linewidth = 0.6
        ) +
        ggplot2::geom_hline(yintercept = 0, linewidth = 1, colour = "#2E2F30") +
        ggplot2::scale_y_continuous(labels = scales::label_percent()) +
        scwplot::theme_scw(base_size = 10) +
        scwplot::scale_fill_diverging(
          labels = scales::label_wrap(20),
          reverse = FALSE, discrete = TRUE
        ) +
        ggplot2::labs(
          title = plot_title(),
          subtitle = plot_subtitle(),
          x = NULL, y = "% Respondents"
        ) +
        ggplot2::theme(
          plot.margin = ggplot2::margin(t = 10, r = 20, b = 10, l = 20),
          legend.key.width = ggplot2::unit(1.5, "cm"),
          legend.text.align = .5
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

    org <-
      reactive({
        if (filters_res$level() == "National") {
          filters_res$level() |>
            stringr::str_to_lower()
        } else if (filters_res$level() == "Regional") {
          if (filters_res$region() == "") {
            "National" |>
              stringr::str_to_lower()
          } else {
            filters_res$region() |>
              stringr::str_remove(pattern = "\\ - .*") |>
              stringr::str_to_lower()
          }
        } else if (filters_res$level() == "ICB") {
          if ((filters_res$icb() == "") &
            (filters_res$region() == "")) {
            "National" |>
              stringr::str_to_lower()
          } else if (filters_res$icb == "") {
            filters_res$region() |>
              stringr::str_remove(pattern = "\\ - .*") |>
              stringr::str_to_lower()
          } else {
            filters_res$icb() |>
              stringr::str_remove(pattern = "\\ - .*") |>
              stringr::str_to_lower()
          }
        } else if (filters_res$level() == "PCN") {
          if ((filters_res$pcn() == "") &
            (filters_res$icb() == "") &
            (filters_res$region() == "")) {
            "National" |>
              stringr::str_to_lower()
          } else if ((filters_res$pcn() == "") &
            (filters_res$icb() == "")) {
            filters_res$region() |>
              stringr::str_remove(pattern = "\\ - .*") |>
              stringr::str_to_lower()
          } else if (filters_res$pcn() == "") {
            filters_res$icb() |>
              stringr::str_remove(pattern = "\\ - .*") |>
              stringr::str_to_lower()
          } else {
            filters_res$pcn() |>
              stringr::str_remove(pattern = "\\ - .*") |>
              stringr::str_to_lower()
          }
        } else if (filters_res$level() == "GP Practice") {
          if ((filters_res$practice() == "") &
            (filters_res$pcn() == "") &
            (filters_res$icb() == "") &
            (filters_res$region() == "")) {
            "National" |>
              stringr::str_to_lower()
          } else if ((filters_res$practice() == "") &
            (filters_res$pcn() == "") &
            (filters_res$icb() == "")) {
            filters_res$region() |>
              stringr::str_remove(pattern = "\\ - .*") |>
              stringr::str_to_lower()
          } else if ((filters_res$practice() == "") &
            (filters_res$pcn() == "")) {
            filters_res$icb() |>
              stringr::str_remove(pattern = "\\ - .*") |>
              stringr::str_to_lower()
          } else if (filters_res$practice() == "") {
            filters_res$pcn() |>
              stringr::str_remove(pattern = "\\ - .*") |>
              stringr::str_to_lower()
          } else {
            filters_res$practice() |>
              stringr::str_remove(pattern = "\\ - .*") |>
              stringr::str_to_lower()
          }
        }
      })

    qn <- reactive({
      input$question |>
        # dplyr::pull() |>
        stringr::str_remove(pattern = "\\ - .*") |>
        stringr::str_to_lower()
    })

    formatted_plot <- reactive({

      logo <-
        magick::image_read(here::here("inst", "app", "www", "logo.svg"))

      gppt_plot() +
        ggplot2::labs(
          title = plot_title(),
          subtitle = plot_subtitle(),
          x = NULL, y = "% Respondents",
          caption = glue::glue(
            "Graphic: **CAIP App** | Source: **GP Patient Survey** | " ,
            "Contact: **scwcsu.primarycaresupport<span>&#64;</span>nhs.net**"
          )
        ) +
        ggplot2::annotation_custom(
          grid::rasterGrob(image = logo, x = 0.96, y = -0.115, width = 0.06)
        ) +
        ggplot2::coord_cartesian(clip = "off") +
        scwplot::theme_scw(base_size = 13) +
        ggplot2::theme(
          plot.margin = ggplot2::margin(t = 20, r = 20, b = 40, l = 20),
          legend.key.width = ggplot2::unit(2, "cm"),
          plot.caption = ggtext::element_markdown()
          )

    })

    output$download_data <- downloadHandler(
      filename = function() {
        # Use the selected dataset as the suggested file name
        paste0("gppt-", org(), "-", qn(), ".csv")
      },
      content = function(file) {
        # Write the dataset to the `file` that will be downloaded
        readr::write_csv(gppt_data(), file)
      }
    )

    output$download_plot <- downloadHandler(
      filename = function() {
        # Use the selected dataset as the suggested file name
        paste0("gppt-", org(), "-", qn(), ".png")
      },
      content = function(file) {
        # Write the dataset to the `file` that will be downloaded

        ggplot2::ggsave(file, formatted_plot(), width = 20, height = 10, dpi = 320)
      }
    )
  })
}
