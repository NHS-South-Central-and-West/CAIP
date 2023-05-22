## code to prepare `gppt` dataset goes here

gppt_raw <- readr::read_csv(
  "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//gppt.csv",
  col_names = FALSE, skip = 1
)

gppt <- dplyr::rename(
  gppt_raw,
  practice_code = X1,
  practice_name = X2,
  pcn_code = X3,
  pcn_name = X4,
  icb_code = X5,
  icb_name = X6,
  region_code = X7,
  region_name = X8,
  source_question_number = X9,
  question_number = X10,
  question_description = X11,
  value = X12,
  year = X13
)

#### Format questions
library(stringr)
library(dplyr)

questions <- unique(gppt[c("source_question_number", "question_number", "question_description")])

questions <- questions %>%
  mutate(
    question = case_when(
      questions$question_number == "Q01" ~ "Q01 - Ease of getting through to someone at GP practice on the phone",
      questions$question_number == "Q04" ~ "Q04 - Ease of using GP practice's website to look for information or access services",
      questions$question_number == "Q16" ~ "Q16 - Satisfaction with type of appointment offered",
      questions$question_number == "Q21" ~ "Q21 - Overall experience of making an appointment",
      questions$question_number == "Q32" ~ "Q32 - Overall experience of GP practice"
    )
  ) %>%
  mutate(
    summary_flag = case_when(
      str_detect(question_description, "Summary") ~ TRUE,
      TRUE ~ FALSE
    )
  ) %>%
#  mutate(
#    confidence_flag = case_when(
#      str_detect(question_description, "confidence") ~ TRUE,
#      TRUE ~ FALSE
#    )
#  ) %>%
  mutate(
    total_flag = case_when(
      str_detect(question_description, "Total") ~ TRUE,
      TRUE ~ FALSE
    )
  ) %>%
  mutate(
    answers = sapply(strsplit(questions$question_description, " - ", fixed = TRUE), tail, 1)
  ) %>%
  mutate(
    sort_order = case_when(answers == "Very easy" ~ 1, answers =="Fairly easy" ~ 2, answers == "Not very easy" ~ 3,
                      answers == "Not at all easy" ~ 4, answers == "Haven't tried" ~ 5, answers =="Very good" ~ 1,
                      answers == "Fairly good" ~ 2, answers == "Neither good nor poor" ~ 3,
                      answers == "Fairly poor" ~ 4, answers == "Very poor" ~ 5,
                      answers == 'Yes, and I accepted an appointment' ~ 1,
                      answers == 'No, but I still took an appointment' ~ 2,
                      answers == 'No, and I did not take an appointment' ~ 3,
                      answers == 'I was not offered an appointment' ~ 4)

  )


#### Merge to final data

gppt_merge <- gppt %>%
  left_join(questions, by = "source_question_number")

gppt_final <- gppt_merge %>%
  select(
    practice_code,
    practice_name,
    pcn_code,
    pcn_name,
    icb_code,
    icb_name,
    region_code,
    region_name,
    source_question_number,
    question_number.x,
    question,
    answers,
    summary_flag,
#    confidence_flag,
    total_flag,
    year,
    value,
    sort_order
  )


gppt_final <- rename(
  gppt_final,
  question_number = question_number.x
)


#### Creation of summary dataset
gppt_summary <- gppt_final %>%
  filter(summary_flag == FALSE, total_flag == FALSE) %>%
  mutate(
    calc_group = case_when(answers == "Very easy" ~ 1, answers =="Fairly easy" ~ 1, answers == "Not very easy" ~ 2,
                           answers == "Not at all easy" ~ 2, answers =="Very good" ~ 3,
                           answers == "Fairly good" ~ 3,
                           answers == "Fairly poor" ~ 4, answers == "Very poor" ~ 4,
                           answers == 'Yes, and I accepted an appointment' ~ 5,
                           answers == 'No, but I still took an appointment' ~ 6,
                           answers == 'No, and I did not take an appointment' ~ 6
                           )
  ) %>%
   mutate(
      summary_desc = case_when (calc_group == 1 ~ 'Good', calc_group == 2 ~ "Poor", calc_group == 3 ~"Good",
                                calc_group == 4 ~"Poor", calc_group ==5 ~"Satisfied", calc_group == 6 ~"Dissatisfied")
   )




usethis::use_data(gppt, overwrite = TRUE)
