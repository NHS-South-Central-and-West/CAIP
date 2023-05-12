## code to prepare `fft` dataset goes here

fft_raw <- readxl::read_excel(
  "O://T&C//BI Consultancy//A - Projects//UoM - SCW - PC CAP//Raw Data//GP FFT Data.xlsx")


fft <- fft_raw

usethis::use_data(fft, overwrite = TRUE)
