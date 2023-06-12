#' The Application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    golem_add_external_resources(),
    fluidPage(
      sidebarPanel(
        width = 3,
        fluidRow(
          h1("PCN Local Capacity & Access Improvement Payment (CAIP) App",
            class = "h-title",
            align = "center"
          ),
          mod_filters_ui("filters"),
          mod_downloads_ui("downloads")
        )
      ),
      mainPanel(
        tabsetPanel(
          tabPanel("GP Patient Survey", mod_gppt_ui("gppt")),
          tabPanel("Friends & Family Test", mod_fft_ui("fft")),
          tabPanel("About", mod_about_ui("about"))
        )
      )
    ),
    waiter::waiterPreloader(
      html = tagList(
        waiter::spin_loaders(
          3,
          color = "#005EB8", style = "width: 80px; height: 80px"
        ),
        h2("Loading...", style = "color: #2E2F30;"),
      ),
      color = "white",
      fadeout = TRUE
    )
  )
}

#' Add External Resources to the Application
#'
#' This function is internally used to add external resources inside the Shiny
#' application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "CAIP"
    ),
    # Add here other external resources
    shinyjs::useShinyjs(),
    waiter::useWaiter(),
    sever::useSever()
  )
}
