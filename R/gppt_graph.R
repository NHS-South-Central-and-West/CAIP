## Detailed Level GPPT Graphs

# install.packages("devtools")
# install.packages("tidyverse")
# devtools::install_github("NHS-South-Central-and-West/scwplot")
# devtools::install_github("bbc/bbplot")


library(tidyverse)
library(bbplot)
library(scwplot)

#### Practice Level Graphs
## practice_code and question_number to be dependent on the selected item on the app
gppt_practice_graph <- filter(
  gppt_final, practice_code == "K84028",
  question_number == "Q21", summary_flag == FALSE,
  total_flag == FALSE
)


# gppt_practice_graph <- gppt_practice_graph[order(gppt_practice_graph$sort_order),]


practice_stack <- ggplot(gppt_practice_graph, aes(x = year, y = value, fill = reorder(answers, sort_order))) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = gppt_practice_graph$question,
    subtitle = gppt_practice_graph$practice_name,
    y = "Number of Patients",
    x = "Year"
  )
practice_stack



practice_perc <- ggplot(gppt_practice_graph, aes(x = year, y = value, fill = reorder(answers, sort_order))) +
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
    title = gppt_practice_graph$question,
    subtitle = gppt_practice_graph$practice_name,
    x = "Year"
  )
practice_perc


#### PCN Level Graphs
## pcn_code and question_number to be dependent on the selected item on the app
gppt_pcn_graph <- gppt_final %>%
  select(
    pcn_code, pcn_name, question_number, summary_flag,
    total_flag, question, answers, year, value, sort_order
  ) %>%
  filter(
    pcn_code == "U20931", question_number == "Q32", summary_flag == FALSE,
    total_flag == FALSE
  ) %>%
  group_by(pcn_code, pcn_name, question, question_number, answers, year, sort_order) %>%
  summarise(value = sum(value))


pcn_stack <- ggplot(gppt_pcn_graph, aes(x = year, y = value, fill = reorder(answers, sort_order))) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = gppt_pcn_graph$question,
    subtitle = gppt_pcn_graph$pcn_name,
    y = "Number of Patients",
    x = "Year"
  )
pcn_stack

pcn_perc <- ggplot(gppt_pcn_graph, aes(x = year, y = value, fill = reorder(answers, sort_order))) +
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
    title = gppt_pcn_graph$question,
    subtitle = gppt_pcn_graph$pcn_name,
    x = "Year"
  )
pcn_perc

#### ICB Level Graphs
## icb_code and question_number to be dependent on the selected item on the app
gppt_icb_graph <- gppt_final %>%
  select(
    icb_code, icb_name, question_number, summary_flag,
    total_flag, question, answers, year, value, sort_order
  ) %>%
  filter(
    icb_code == "QU9", question_number == "Q01", summary_flag == FALSE,
    total_flag == FALSE
  ) %>%
  group_by(icb_code, icb_name, question, question_number, answers, year, sort_order) %>%
  summarise(value = sum(value))


icb_stack <- ggplot(gppt_icb_graph, aes(x = year, y = value, fill = reorder(answers, sort_order))) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = gppt_icb_graph$question,
    subtitle = gppt_icb_graph$icb_name,
    y = "Number of Patients",
    x = "Year"
  )
icb_stack

icb_perc <- ggplot(gppt_icb_graph, aes(x = year, y = value, fill = reorder(answers, sort_order))) +
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
    title = gppt_icb_graph$question,
    subtitle = gppt_icb_graph$icb_name,
    x = "Year"
  )
icb_perc

#### Region Level Graphs
## region_code and question_number to be dependent on the selected item on the app
gppt_region_graph <- gppt_final %>%
  select(
    region_code, region_name, question_number, summary_flag,
    total_flag, question, answers, year, value, sort_order
  ) %>%
  filter(
    region_code == "Y59", question_number == "Q01", summary_flag == FALSE,
    total_flag == FALSE
  ) %>%
  group_by(region_code, region_name, question, question_number, answers, year, sort_order) %>%
  summarise(value = sum(value))


region_stack <- ggplot(gppt_region_graph, aes(x = year, y = value, fill = reorder(answers, sort_order))) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = gppt_region_graph$question,
    subtitle = gppt_region_graph$region_name,
    y = "Number of Patients",
    x = "Year"
  )
region_stack

region_perc <- ggplot(gppt_region_graph, aes(x = year, y = value, fill = reorder(answers, sort_order))) +
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
    title = gppt_region_graph$question,
    subtitle = gppt_region_graph$region_name,
    x = "Year"
  )
region_perc

#### National Level Graphs

gppt_national_graph <- gppt_final %>%
  select(
    question_number, summary_flag,
    total_flag, question, answers, year, value, sort_order
  ) %>%
  filter(
    question_number == "Q01", summary_flag == FALSE,
    total_flag == FALSE
  ) %>%
  group_by(question, question_number, answers, year, sort_order) %>%
  summarise(value = sum(value))


national_stack <- ggplot(gppt_national_graph, aes(x = year, y = value, fill = reorder(answers, sort_order))) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = gppt_national_graph$question,
    subtitle = "National Results",
    y = "Number of Patients",
    x = "Year"
  )
national_stack

national_perc <- ggplot(gppt_national_graph, aes(x = year, y = value, fill = reorder(answers, sort_order))) +
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
    title = gppt_national_graph$question,
    subtitle = "National Results",
    x = "Year"
  )
national_perc
