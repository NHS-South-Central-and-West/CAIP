## GPPT Plot Development

# Setup ----

library(dplyr)
library(ggplot2)
library(scwplot)

# Detailed Plots ----

## GP Practice ----
# practice_code and question_number dependent on the selected item on the app
gppt_practice_data <-
  gppt |>
  filter(practice_code == "K84028" & question_number == "Q21")

# response totals
gppt_practice_data |>
  ggplot(aes(x = year, y = value, fill = reorder(answer, response_scale))) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = gppt_practice_data$question,
    subtitle = gppt_practice_data$practice_name,
    y = "Number of Patients",
    x = "Year"
  )

# response proportions
gppt_practice_data |>
  ggplot(aes(x = year, y = value, fill = reorder(answer, response_scale))) +
  geom_bar(
    stat = "identity",
    position = "fill"
  ) +
  theme_scw() +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  scale_y_continuous(
    name = "Percentage of Patients",
    labels = scales::label_percent()
  ) +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = gppt_practice_data$question,
    subtitle = gppt_practice_data$practice_name,
    x = "Year"
  )

## National ----

gppt_national_data <-
  gppt |>
  select(
    question_number, question, answer, value,
    year, response_scale, response_summary
  ) |>
  filter(question_number == "Q01") |>
  group_by(question, question_number, answer, year, response_scale) |>
  summarise(value = sum(value))

# response totals
gppt_national_data |>
  ggplot(aes(x = year, y = value, fill = reorder(answer, response_scale))) +
  geom_bar(stat = "identity", position = "stack") +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = gppt_national_data$question,
    subtitle = "National Results",
    y = "Number of Patients",
    x = "Year"
  )

# response proportions
gppt_national_data |>
  ggplot(aes(x = year, y = value, fill = reorder(answer, response_scale))) +
  geom_bar(stat = "identity", position = "fill") +
  theme_scw() +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  scale_y_continuous(labels = scales::label_percent()) +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = gppt_national_data$question,
    subtitle = "National Results",
    y = "Percentage of Patients",
    x = "Year", y = "Percentage of Patients"
  )

# Summary Plots ----

## GP Practice ----

gppt_summary_data <-
  gppt |>
  filter(!is.na(response_summary) &
    practice_code == "K84028" &
    question_number == "Q04") |>
  group_by(
    practice_code, practice_name, year, question,
    question_number, response_summary
  ) |>
  summarise(value = sum(value))

# response totals
gppt_summary_data |>
  ggplot(aes(x = year, y = value, fill = response_summary)) +
  geom_bar(stat = "identity", position = "stack") +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = gppt_summary_data$question,
    subtitle = gppt_summary_data$practice_name,
    y = "Number of Patients",
    x = "Year"
  )

gppt_summary_data |>
  ggplot(aes(x = year, y = value, fill = response_summary)) +
  geom_bar(stat = "identity", position = "fill") +
  theme_scw() +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  scale_y_continuous(labels = scales::label_percent()) +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = gppt_summary_data$question,
    subtitle = gppt_summary_data$practice_name,
    x = "Year", y = "Percentage of Patients"
  )
