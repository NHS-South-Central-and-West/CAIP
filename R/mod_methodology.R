#' methodology UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_methodology_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        width = 12,
        align = "left",
        tags$h3("Technical Details"),
        tags$h4("GP Patient Survey"),
        tags$p("This report contains data for the GP Patient Survey
               collected from patients aged 16+ registered with a
               GP practice in England."),
        tags$p("The GP Patient Survey is an independent survey run by Ipsos on
        behalf of NHS England. The survey is sent out to over two million people
        across the UK. The results show how people feel about their GP practice."),
        tags$p(
          tags$a(
            href = "https://gp-patient.co.uk/practices-search",
            target = "_blank", icon("link"),
            "See the GP Patient Survey website for
            further information."
          ),
        ),
        tags$hr(),
        tags$h3("Frequently asked questions"),
        tags$a(
          href = "https://gp-patient.co.uk/faq",
          target = "_blank", icon("link"),
          "See the GP Patient Survey website FAQ
          for more information about the survey."
        ),
        tags$p("Data is used within this app is weighted by age and gender to
        reflect the population of eligible patients within each practice and ICS."),
        tags$p(
          tags$a(
            href = "https://gp-patient.co.uk/weighted-data",
            target = "_blank", icon("link"),
            "See the GP Patient Survey website for
            further information about weighting."
          )
        ),
        tags$h4("Friends and Family Test"),
        tags$p("Friends and Family Test results are provided
               for practices which have submitted them."),
        tags$p("The Friends and Family Test (FFT) is an important feedback tool
               that supports the fundamental principle that people who use NHS
               services should have the opportunity to provide feedback on
               their experience. Listening to the views of patients and staff
               helps identify what is working well, what can be improved and how."),
        tags$p("The FFT asks people if they would recommend the services they
               have used and offers a range of responses. From April 2020, a
               new question has replaced the original FFT question about whether
               people would recommend the service they used to their friends and
               family."),
        tags$p("Data submission and publication for the Friends and Family Test (FFT)
               restarted for GP Practices from July 2022, following the pause
               during the response to COVID-19. "),
        tags$p(
          tags$a(
            href = "https://www.england.nhs.uk/fft/friends-and-family-test-data/",
            target = "_blank", icon("link"),
            "See the Friends and Family Test website for further information."
          )
        ),
        tags$h3("Comparison between Practices"),
        tags$p("The second iteration of this tool will contain the ability to
               compare between similar practices.  This will be developed using
               practice location, workforce, population and deprivation data."),
        tags$hr(),
        tags$h3("Code"),
        tags$a(
          href = "https://github.com/NHS-South-Central-and-West/CAIP",
          target = "_blank", icon("code"),
          "The app has been developed using RShiny.  All code is available via github.
          Use the link above to report any errors."
        ),
        tags$hr(),
        tags$h3("Contact"),
        tags$a(
          href = "mailto:scwcsu.primarycaresupport@nhs.net",
          target = "_blank", icon("inbox"),
          "For further enquiries about this tool and find out how South, Central
          and West can support you achieve the CAIP target."
        ),
        tags$hr()
      )
    )
  )
}

#' methodology Server Functions
#'
#' @noRd
mod_methodology_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}
