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


questions <-unique(gppt[c('source_question_number', 'question_number', 'question_description')])


library(stringr)
library(dplyr)
questions <- questions %>%
       mutate(
         question = case_when (
           questions$question_number == 'Q01' ~ "Ease of getting through to someone at GP practice on the phone",
           questions$question_number == 'Q04' ~ "Ease of using GP practice's website to look for information or access services",
           questions$question_number == 'Q16' ~ "Satisfaction with type of appointment offered",
           questions$question_number == 'Q21' ~ "Overall experience of making an appointment",
           questions$question_number == 'Q32' ~ "Overall experience of GP practice"
           )  )

questions <- questions %>%
        mutate(
         summary_flag = case_when (
                str_detect(question_description,"Summary") ~ TRUE,
                TRUE~ FALSE
                )
         )

questions <- questions %>%
  mutate(
    confidence_flag = case_when (
      str_detect(question_description,"confidence") ~ TRUE,
      TRUE~ FALSE
    )
  )

questions <- questions %>%
        mutate(
          answers = sapply(strsplit(questions$question_description," - ",fixed=TRUE),tail, 1)
        )



questions_summary <-questions %>%
  filter(questions$summary_flag == TRUE)

questions_summary <-  questions_summary %>%
  mutate(
    summary_context = sapply(strsplit(questions_summary$answers," (",fixed=TRUE),tail, 1)
        )

questions_summary <- gsub("[()]","",questions_summary$summary_context)






usethis::use_data(gppt, overwrite = TRUE)


