## code to prepare `gppt` dataset goes here

gppt_raw <- readr::read_csv(
  "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//GPPT_Data.csv",
  col_names = FALSE
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
  mutate(
    confidence_flag = case_when(
      str_detect(question_description, "confidence") ~ TRUE,
      TRUE ~ FALSE
    )
  ) %>%
  mutate(
    total_flag = case_when(
      str_detect(question_description, "Total") ~ TRUE,
      TRUE ~ FALSE
    )
  ) %>%
  mutate(
    answers = sapply(strsplit(questions$question_description, " - ", fixed = TRUE), tail, 1)
  )


#### Trying to remove the string after the brackets in the answer question for the summary questions



# questions_test <- questions_test %>%
#  str_replace(questions_test$answers, " \\s*\\([^\\)]+\\)", "")


# questions$summary_flag == TRUE,


# questions <- questions %>%
#  filter(questions$summary_flag == TRUE) %>%
#  mutate(
#    answers = sapply(strsplit(questions$answers, " (", fixed = TRUE), head, 1)
#  ) %>%
#  mutate(
#    summary_context = sapply(strsplit(questions$answers, " (", fixed = TRUE), tail, 1)
#  ) %>%
#  mutate(
#    summary_context = str_sub(summary_context, 1, -2)
#  )



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
    confidence_flag,
    total_flag,
    year,
    value
  )

gppt_final <- rename(
  gppt_final,
  question_number = question_number.x
)



usethis::use_data(gppt, overwrite = TRUE)
