#' Plot GP Patient Survey responses
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

gpps_plot <- function(data, national = FALSE) {
  # get plot title
  plot_title <- data |> dplyr::distinct(.data$question)

  # get plot subtitle based on aggregate level
  if (national == TRUE) {
    plot_subtitle <- "NATIONALLY AGGREGATED RESULTS"
  } else {
    plot_subtitle <- data |> dplyr::distinct(.data$organisation_name)
  }

  data |>
    ggplot2::ggplot(ggplot2::aes(
      x = .data$year, y = .data$value,
      fill = stats::reorder(.data$answer, .data$response_scale)
    )) +
    ggplot2::geom_bar(
      stat = "identity", position = "fill",
      colour = "#333333", linewidth = 1
    ) +
    ggplot2::geom_hline(yintercept = 0, linewidth = 1, colour = "#333333") +
    ggplot2::scale_y_continuous(labels = scales::label_percent()) +
    scwplot::theme_scw() +
    scwplot::scale_fill_diverging(reverse = FALSE, discrete = TRUE) +
    ggplot2::labs(
      title = plot_title,
      subtitle = plot_subtitle,
      x = NULL, y = "% Respondents"
    )
}
