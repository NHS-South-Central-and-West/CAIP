## Plot Development

# Setup ----

library(dplyr)
library(ggplot2)
library(scwplot)

# GPPT ----

## Detailed Plots ----

### GP Practice ----
# practice_code and question_number dependent on the selected item on the app
gppt_practice_data <-
  CAIP::gppt |>
  filter(practice_code == "K84028" & question_number == "Q21")

# response totals
gppt_practice_data |>
  ggplot(aes(x = year, y = value, fill = reorder(answer, response_scale))) +
  geom_col(colour = "#333333", linewidth = 0.6) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = gppt_practice_data$question,
    subtitle = gppt_practice_data$practice,
    y = "Total Respondents",
    x = "Year"
  )

# response proportions
gppt_practice_data |>
  ggplot(aes(x = year, y = value, fill = reorder(answer, response_scale))) +
  geom_col(position = "fill", colour = "#333333", linewidth = 0.6) +
  theme_scw() +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  scale_y_continuous(
    name = "% Respondents",
    labels = scales::label_percent()
  ) +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = gppt_practice_data$question,
    subtitle = gppt_practice_data$practice,
    x = "Year"
  )

### National ----

gppt_national_data <-
  CAIP::gppt |>
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
  geom_col(colour = "#333333", linewidth = 0.6) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = gppt_national_data$question,
    subtitle = "National Results",
    y = "Total Respondents",
    x = "Year"
  )

# response proportions
gppt_national_data |>
  ggplot(aes(x = year, y = value, fill = reorder(answer, response_scale))) +
  geom_col(position = "fill", colour = "#333333", linewidth = 0.6) +
  theme_scw() +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  scale_y_continuous(labels = scales::label_percent()) +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = gppt_national_data$question,
    subtitle = "National Results",
    y = "% Respondents",
    x = "Year", y = "Percentage of Patients"
  )

## Summary Plots ----

### GP Practice ----

gppt_summary_data <-
  CAIP::gppt |>
  filter(!is.na(response_summary) &
    practice_code == "K84028" &
    question_number == "Q04") |>
  group_by(
    practice_code, practice, year, question,
    question_number, response_summary
  ) |>
  summarise(value = sum(value))

# response totals
gppt_summary_data |>
  ggplot(aes(x = year, y = value, fill = response_summary)) +
  geom_col(colour = "#333333", linewidth = 0.6) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = gppt_summary_data$question,
    subtitle = gppt_summary_data$practice,
    y = "Number of Patients",
    x = "Year"
  )

# response proportions
gppt_summary_data |>
  ggplot(aes(x = year, y = value, fill = response_summary)) +
  geom_col(position = "fill", colour = "#333333", linewidth = 0.6) +
  theme_scw() +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  scale_y_continuous(labels = scales::label_percent()) +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = gppt_summary_data$question,
    subtitle = gppt_summary_data$practice,
    x = "Year", y = "Percentage of Patients"
  )

# FFT ----

## Detailed Plots ----

### GP Practice ----
# practice_code and question_number dependent on the selected item on the app
fft_practice_data <-
  CAIP::fft |>
  filter(practice_code == "K84045" & !is.na(response_scale))

# response totals
fft_practice_data |>
  ggplot(aes(x = date, y = value, fill = reorder(answer, response_scale))) +
  geom_col(colour = "#333333", linewidth = 0.6) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = "Friends and Family Test",
    subtitle = fft_practice_data$practice,
    x = NULL, y = "Total Respondents"
  )

# response proportions
fft_practice_data |>
  ggplot(aes(x = date, y = value, fill = reorder(answer, response_scale))) +
  geom_col(position = "fill", colour = "#333333", linewidth = 0.6) +
  theme_scw() +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  scale_y_continuous(labels = scales::label_percent()) +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = "Friends and Family Test",
    subtitle = fft_practice_data$practice,
    x = NULL, y = "% Respondents"
  )

# line plots
fft_practice_data |>
  group_by(date = lubridate::floor_date(date, "year"),
           answer, response_scale) |>
  reframe(value = sum(value)) |>
  mutate(
    total = sum(value),
    value = value / total,
    .by = c(date)
  ) |>
  ggplot(aes(x = as.Date(date), y = value,
             colour = reorder(answer, response_scale),
             fill = reorder(answer, response_scale),
             group = answer)) +
  geom_line(size = 1*1.2, colour = "#333333") +
  geom_line(size = 1) +
  geom_point(shape = 21, size = 5, colour = "#333333") +
  theme_scw() +
  scale_x_date(date_breaks = "1 years", date_labels = "%Y") +
  scale_y_continuous(labels = scales::label_percent()) +
  scale_colour_diverging(discrete = TRUE) +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = "Friends and Family Test",
    subtitle = fft_practice_data$practice,
    x = NULL, y = "% Respondents"
  )

### National ----

fft_national_data <-
  CAIP::fft |>
  filter(!is.na(response_scale)) |>
  select(date, answer, value, response_scale) |>
  group_by(date, answer, response_scale) |>
  summarise(value = sum(value))

# response totals
fft_national_data |>
  ggplot(aes(x = date, y = value, fill = reorder(answer, response_scale))) +
  geom_col(colour = "#333333", linewidth = 0.6) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = "Friends and Family Test",
    subtitle = "National Results",
    x = NULL, y = "Total Respondents"
  )

# response proportions
fft_national_data |>
  ggplot(aes(x = date, y = value, fill = reorder(answer, response_scale))) +
  geom_col(position = "fill", colour = "#333333", linewidth = 0.6) +
  theme_scw() +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  scale_y_continuous(labels = scales::label_percent()) +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = "Friends and Family Test",
    subtitle = "National Results",
    x = NULL, y = "% Respondents"
  )

# line plots
fft_national_data |>
  group_by(date = lubridate::floor_date(date, "year"),
           answer, response_scale) |>
  reframe(value = sum(value)) |>
  mutate(
    total = sum(value),
    value = value / total,
    .by = date
  ) |>
  ggplot(aes(x = date, y = value,
             colour = reorder(answer, response_scale),
             fill = reorder(answer, response_scale),
             group = answer)) +
  geom_line(size = 1*1.2, colour = "#333333") +
  geom_line(size = 1) +
  geom_point(shape = 21, size = 5, colour = "#333333") +
  theme_scw() +
  scale_x_date(date_breaks = "1 years", date_labels = "%Y") +
  scale_y_continuous(labels = scales::label_percent()) +
  scale_colour_diverging(discrete = TRUE) +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = "Friends and Family Test",
    subtitle = "National Results",
    x = NULL, y = "% Respondents"
  )
