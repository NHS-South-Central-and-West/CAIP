testServer(
  mod_gpps_server,
  # Add here your module params
  args = list(data = CAIP::gpps),
  {
    ns <- session$ns
    expect_true(
      inherits(ns, "function")
    )
    expect_true(
      grepl(id, ns(""))
    )
    expect_true(
      grepl("test", ns("test"))
    )

    # - Testing the setting of inputs
    session$setInputs(
      question =
        "Q01 - Ease of getting through to someone at GP practice on the phone"
      )
    expect_true(
      input$question ==
        "Q01 - Ease of getting through to someone at GP practice on the phone"
      )
    expect_false(
      input$question ==
        "Ease of getting through to someone at GP practice on the phone"
    )
    expect_false(
      input$question ==
        "Q16 - Satisfaction with appointment offered"
    )

    # - If ever your input updates a reactiveValues
    # - Note that this reactiveValues must be passed
    # - to the testServer function via args = list()
    # expect_true(r$x == 1)
    # - Testing output
    # expect_true(inherits(output$gpps_plot$html, "html"))
  }
)

test_that("module ui works", {
  ui <- mod_gpps_ui(id = "test")
  golem::expect_shinytaglist(ui)
  # Check that formals have not been removed
  fmls <- formals(mod_gpps_ui)
  for (i in c("id")) {
    expect_true(i %in% names(fmls))
  }
})
