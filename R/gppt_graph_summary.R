## Summary Level GPPT Graphs

library(tidyverse)
library(bbplot)
library(scwplot)

#### Practice Level Graphs
## practice_code and question_number to be dependent on the selected item on the app
gppt_practice_summary <-
  filter(gppt_summary, practice_code == "K84028", question_number == "Q04", calc_group != "NA") %>%
  group_by(practice_code, practice_name, question, question_number, summary_desc, year, calc_group) %>%
  summarise(value = sum(value))



practice_stack_summary <- ggplot(gppt_practice_summary, aes(x = year, y = value, fill = summary_desc)) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  labs(
    title = gppt_practice_summary$question,
    subtitle = gppt_practice_summary$practice_name,
    y = "Number of Patients",
    x = "Year"
  )
practice_stack_summary



practice_perc_summary <- ggplot(gppt_practice_summary, aes(x = year, y = value, fill = summary_desc)) +
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
    title = gppt_practice_summary$question,
    subtitle = gppt_practice_summary$practice_name,
    x = "Year"
  )
practice_perc_summary

#### PCN Level Graphs
## PCN_code and question_number to be dependent on the selected item on the app
gppt_pcn_summary <-
  filter(gppt_summary, pcn_code == "U20931", question_number == "Q32", calc_group != "NA") %>%
  group_by(pcn_code, pcn_name, question, question_number, summary_desc, year, calc_group) %>%
  summarise(value = sum(value))



pcn_stack_summary <- ggplot(gppt_pcn_summary, aes(x = year, y = value, fill = summary_desc)) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = gppt_pcn_summary$question,
    subtitle = gppt_pcn_summary$pcn_name,
    y = "Number of Patients",
    x = "Year"
  )
pcn_stack_summary



pcn_perc_summary <- ggplot(gppt_pcn_summary, aes(x = year, y = value, fill = summary_desc)) +
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
    title = gppt_pcn_summary$question,
    subtitle = gppt_pcn_summary$pcn_name,
    x = "Year"
  )
pcn_perc_summary

#### ICB Level Graphs
## ICB_code and question_number to be dependent on the selected item on the app
gppt_icb_summary <-
  filter(gppt_summary, icb_code == "QU9", question_number == "Q01", calc_group != "NA") %>%
  group_by(icb_code, icb_name, question, question_number, summary_desc, year, calc_group) %>%
  summarise(value = sum(value))



icb_stack_summary <- ggplot(gppt_icb_summary, aes(x = year, y = value, fill = summary_desc)) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = gppt_icb_summary$question,
    subtitle = gppt_icb_summary$icb_name,
    y = "Number of Patients",
    x = "Year"
  )
icb_stack_summary



icb_perc_summary <- ggplot(gppt_icb_summary, aes(x = year, y = value, fill = summary_desc)) +
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
    title = gppt_icb_summary$question,
    subtitle = gppt_icb_summary$icb_name,
    x = "Year"
  )
icb_perc_summary

#### Regional Level Graphs
## Region_code and question_number to be dependent on the selected item on the app
gppt_region_summary <-
  filter(gppt_summary, region_code == "Y59", question_number == "Q01", calc_group != "NA") %>%
  group_by(region_code, region_name, question, question_number, summary_desc, year, calc_group) %>%
  summarise(value = sum(value))



region_stack_summary <- ggplot(gppt_region_summary, aes(x = year, y = value, fill = summary_desc)) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = gppt_region_summary$question,
    subtitle = gppt_region_summary$region_name,
    y = "Number of Patients",
    x = "Year"
  )
region_stack_summary



region_perc_summary <- ggplot(gppt_region_summary, aes(x = year, y = value, fill = summary_desc)) +
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
    title = gppt_region_summary$question,
    subtitle = gppt_region_summary$region_name,
    x = "Year"
  )
region_perc_summary

#### National Level Graphs
## Question_number to be dependent on the selected item on the app
gppt_national_summary <-
  filter(gppt_summary, question_number == "Q01", calc_group != "NA") %>%
  group_by(question, question_number, summary_desc, year, calc_group) %>%
  summarise(value = sum(value))



national_stack_summary <- ggplot(gppt_national_summary, aes(x = year, y = value, fill = summary_desc)) +
  geom_bar(
    stat = "identity",
    position = "stack"
  ) +
  geom_hline(yintercept = 0, size = 1, colour = "#333333") +
  theme_scw() +
  scale_fill_diverging(discrete = TRUE) +
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(
    title = gppt_national_summary$question,
    subtitle = "National Results",
    y = "Number of Patients",
    x = "Year"
  )
national_stack_summary



national_perc_summary <- ggplot(gppt_national_summary, aes(x = year, y = value, fill = summary_desc)) +
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
    title = gppt_national_summary$question,
    subtitle = "National Results",
    x = "Year"
  )
national_perc_summary
