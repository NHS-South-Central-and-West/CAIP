## Script to Import & Wrangle GP Patient (GPPT) Survey Data

# import raw data from file
gppt_raw <-
  readr::read_csv(
    "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//gppt.csv",
    col_names = FALSE, skip = 1,
    # specify encoding for fixing how apostrophes are processed
    locale = readr::locale(encoding = "ISO-8859-1")
  ) |>
  dplyr::rename(
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

gppt <-
  gppt_raw |>
  # dplyr::distinct(source_question_number, .keep_all = TRUE) |>
  dplyr::mutate(
    question_description = stringr::str_replace_all(
      question_description, "ï¿½", "'"
    ),
    question_type = dplyr::case_when(
      stringr::str_detect(question_description, "Summary") ~ "summary",
      stringr::str_detect(question_description, "Total") ~ "total",
      .default = "response"
    ),
    icb_name = stringr::str_remove(icb_name, "NHS "),
    icb_name = stringr::str_replace(icb_name, "INTEGRATED CARE BOARD", "ICB"),
    # concatenate organisation codes and names
    region = stringr::str_c(region_code, " - ", region_name),
    icb = stringr::str_c(icb_code, " - ", icb_name),
    pcn = stringr::str_c(pcn_code, " - ", pcn_name),
    practice = stringr::str_c(practice_code, " - ", practice_name)
  ) |>
  dplyr::select(!dplyr::all_of(dplyr::ends_with("name"))) |>
  dplyr::relocate(region, .after = region_code) |>
  dplyr::relocate(icb, .after = icb_code) |>
  dplyr::relocate(pcn, .after = pcn_code) |>
  dplyr::relocate(practice, .after = practice_code) |>
  # filter for response counts only
  # reconstruct summary/total from response if necessary
  dplyr::filter(question_type == "response") |>
  tidyr::separate_wider_regex(
    question_description, c(question = ".*", "-", answer = ".*"),
    too_few = "align_start"
  ) |>
  dplyr::mutate(
    question = stringr::str_squish(question),
    question = glue::glue("{question_number} - {question}"),
    question = dplyr::recode(
      question,
      "Q16 - Satisfaction with type of appointment offered" =
        "Q16 - Satisfaction with appointment offered"
    ),
    answer = stringr::str_squish(answer),
    # create standardised/consistent ordinal scale for responses
    response_scale =
      dplyr::case_when(
        answer %in% c(
          "Very easy", "Very good",
          "Yes, and I accepted an appointment"
        ) ~ 1,
        answer %in% c("Fairly easy", "Fairly good") ~ 2,
        answer %in% c("Neither good nor poor") ~ 3,
        answer %in% c(
          "Not very easy", "Fairly poor",
          "No, but I still took an appointment"
        ) ~ 4,
        answer %in% c(
          "Not at all easy", "Very poor",
          "No, and I did not take an appointment"
        ) ~ 5,
        # non-response treated as NA
        answer %in% c(
          "Haven't tried",
          "I was not offered an appointment"
        ) ~ NA,
        .default = NA
      ),
    response_summary = dplyr::case_when(
      answer %in% c(
        "Very easy", "Fairly easy",
        "Very good", "Fairly good"
      ) ~ "Good",
      answer %in% c("Neither good nor poor") ~ "Neither Good Nor Poor",
      answer %in% c(
        "Not very easy", "Not at all easy",
        "Fairly poor", "Very poor"
      ) ~ "Poor",
      answer %in% c("Yes, and I accepted an appointment") ~ "Satisfied",
      answer %in% c(
        "No, but I still took an appointment",
        "No, and I did not take an appointment"
      ) ~ "Dissatisfied",
      # non-response treated as NA
      answer %in% c(
        "Haven't tried",
        "I was not offered an appointment"
      ) ~ NA,
      .default = NA
    )
  )

usethis::use_data(gppt, overwrite = TRUE)
