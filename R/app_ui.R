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
          h1("PCN Local Capacity and Access Improvement Payment Dashboard",
            class = "h-title"
          ),
          mod_sidebar_ui("sidebar")
        )
      ),
      mainPanel(
        tabsetPanel(
          tabPanel("GP Patient Survey", mod_gppt_ui("gppt_1")),
          tabPanel("Friends & Family Test", mod_fft_ui("fft_1"))
        )
      )
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
      app_title = "CAP"
    ),
    # Add here other external resources
    shinyjs::useShinyjs()
  )
}
