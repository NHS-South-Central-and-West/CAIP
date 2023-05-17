install.packages("devtools")
devtools::install_github("NHS-South-Central-and-West/scwplot")

devtools::install_github("bbc/bbplot")

install.packages("tidyverse")
library(tidyverse)
library(bbplot)
library(scwplot)

####Practice Level Graphs
##practice_code and question_number to be dependent on the selected item on the app
gppt_practice_graph <- filter(gppt_final, practice_code == "K84028", question_number == "Q16", summary_flag == FALSE, confidence_flag ==FALSE, total_flag ==FALSE)

practice_stack <- ggplot(gppt_practice_graph, aes(fill = answers, x = year, y = value)) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour="#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = gppt_practice_graph$question,
    subtitle = gppt_practice_graph$practice_name,
    y = 'Number of Patients',
    x = "Year"
  )
practice_stack

practice_perc <- ggplot(gppt_practice_graph, aes(fill = answers, x = year, y = value)) +
  geom_bar(
    stat = "identity",
    position = "fill"
  )  +
  theme_scw() +
  geom_hline(yintercept = 0, size = 1, colour="#333333") +
  scale_y_continuous(name = "Percentage of Patients",
                     labels = scales::label_percent()) +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = gppt_practice_graph$question,
    subtitle = gppt_practice_graph$practice_name,
    x = "Year"
  )

practice_perc

####PCN Level Graphs
##pcn_code and question_number to be dependent on the selected item on the app
gppt_pcn_graph <- filter(gppt_final, pcn_code == "U36809", question_number == "Q16", summary_flag == FALSE, confidence_flag ==FALSE, total_flag ==FALSE)

pcn_stack <- ggplot(gppt_pcn_graph, aes(fill = answers, x = year, y = value)) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour="#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = gppt_pcn_graph$question,
    subtitle = gppt_pcn_graph$practice_name,
    y = 'Number of Patients',
    x = "Year"
  )
pcn_stack

pcn_perc <- ggplot(gppt_pcn_graph, aes(fill = answers, x = year, y = value)) +
  geom_bar(
    stat = "identity",
    position = "fill"
  )  +
  theme_scw() +
  geom_hline(yintercept = 0, size = 1, colour="#333333") +
  scale_y_continuous(name = "Percentage of Patients",
                     labels = scales::label_percent()) +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = gppt_pcn_graph$question,
    subtitle = gppt_pcn_graph$practice_name,
    x = "Year"
  )
pcn_perc

