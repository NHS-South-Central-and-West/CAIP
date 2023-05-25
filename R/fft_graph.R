## FFT Plot Development

# Setup ----

library(dplyr)
library(ggplot2)
library(scwplot)

# Detailed Plots ----

## GP Practice ----
# practice_code and question_number dependent on the selected item on the app


fft_practice_graph <- filter(
  fft_final, practice_code == "K84045"
)

# gppt_practice_graph <- gppt_practice_graph[order(gppt_practice_graph$sort_order),]

fft_practice_stack <- ggplot(fft_practice_graph, aes(x = month, y = value, fill = reorder(answers, sort_order))) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = "Friends and Family Test",
    subtitle = fft_practice_graph$practice_name,
    y = "Number of Patients",
    x = "Month"
  )
fft_practice_stack


fft_practice_perc <- ggplot(fft_practice_graph, aes(x = month, y = value, fill = reorder(answers, sort_order))) +
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
    title = "Friends and Family Test",
    subtitle = fft_practice_graph$practice_name,
    x = "Month"
  )
fft_practice_perc


#### National Level Graphs

fft_national_graph <- fft_final |>
  select(
    answers, month, value, sort_order
  ) |>
  group_by(answers, month, sort_order) |>
  summarise(value = sum(value))


fft_national_stack <- ggplot(fft_national_graph, aes(x = month, y = value, fill = reorder(answers, sort_order))) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = "Friends and Family Test",
    subtitle = "National Results",
    y = "Number of Patients",
    x = "Month"
  )
fft_national_stack

fft_national_perc <- ggplot(fft_national_graph, aes(x = month, y = value, fill = reorder(answers, sort_order))) +
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
    title = "Friends and Family Test",
    subtitle = "National Results",
    x = "Month"
  )
fft_national_perc
