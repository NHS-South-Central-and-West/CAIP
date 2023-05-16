install.packages('devtools')
devtools::install_github('NHS-South-Central-and-West/scwplot')

devtools::install_github('bbc/bbplot')

install.packages('tidyverse')
library(tidyverse)
library(bbplot)

test <- filter(gppt, practice_code == 'K84028', question_number =='Q01', source_question_number == 'q3_12')

bars <- ggplot(test, aes(x = year, y = value)) +
  geom_bar(stat="identity",
           position="identity",
           fill="#1380A1") +
  geom_hline(yintercept = 0, size = 1, colour="#333333") +
  bbc_style() +
  labs(title= test$question_number,
       subtitle = test$practice_name)
bars
