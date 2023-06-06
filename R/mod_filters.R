#' Sidebar Filters UI Function
#'
#' @description Module for the app sidebar's filters. The main data processing
#' is handled by it.
#'
#' @param id Module's ID
#'
#' @noRd
mod_filters_ui <- function(id) {
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
    #   tags$p("If you would like to compare an organisation (Region, ICB, PCN,
    #          GP Practice) with similar organisations of the same aggregate
    #          level, click the switch below:"),
    # ),
    # column(
    #   width = 12,
    #   align = "center",
    #   shinyWidgets::switchInput(
    #     inputId = ns("comparison"),
    #     label = "Compare",
    #     size = "normal",
    #     width = "50%",
    #     value = FALSE
    #   )
    )
  )
}

#' Sidebar Filters Server Function
#'
#' @param id Module's ID
#' @param data Input GPPT data
#' @param input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_filters_server <- function(id, data) {
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

      region_selection <- reactive({
        data |>
          dplyr::distinct(.data$region) |>
          dplyr::pull()
      })

      icb_selection <- reactive({
        data |>
          dplyr::filter(
            conditional(input$region != "", region == input$region)
          ) |>
          dplyr::distinct(.data$icb) |>
          dplyr::pull()
      })

      pcn_selection <- reactive({
        data |>
          dplyr::filter(
            conditional(input$region != "", region == input$region),
            conditional(input$icb != "", icb == input$icb)
          ) |>
          dplyr::distinct(.data$pcn) |>
          dplyr::pull()
      })

      practice_selection <- reactive({
        data |>
          dplyr::filter(
            conditional(input$region != "", region == input$region),
            conditional(input$icb != "", icb == input$icb),
            conditional(input$pcn != "", pcn == input$pcn)
          ) |>
          dplyr::distinct(.data$practice) |>
          dplyr::pull()
      })

      observeEvent(ignoreInit = TRUE, input$level, {
        updateSelectizeInput(
          session,
          "region",
          choices = c(
            "ALL" = "",
            region_selection()
          ),
          server = TRUE
        )
      })

      observeEvent(
        ignoreInit = TRUE,
        list(input$level, input$region),
        {
          updateSelectizeInput(
            session,
            "icb",
            choices = c(
              "ALL" = "",
              icb_selection()
            ),
            server = TRUE
          )
        }
      )

      observeEvent(
        ignoreInit = TRUE,
        list(input$level, input$region, input$icb),
        {
          updateSelectizeInput(
            session,
            "pcn",
            choices = c(
              "ALL" = "",
              pcn_selection()
            ),
            server = TRUE
          )
        }
      )

      observeEvent(
        ignoreInit = TRUE,
        list(
          input$level, input$region,
          input$icb, input$pcn
        ),
        {
          updateSelectizeInput(
            session,
            "practice",
            choices = c(
              "ALL" = "",
              practice_selection()
            ),
            server = TRUE
          )
        }
      )

      return(
        list(
          level = reactive({
            input$level
          }),
          region = reactive({
            input$region
          }),
          icb = reactive({
            input$icb
          }),
          pcn = reactive({
            input$pcn
          }),
          practice = reactive({
            input$practice
          })
        )
      )
    }
  )
}
