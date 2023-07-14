library(tidyverse)

source("init.R")

# Age by five-year age bands

age_2021 <-
  read_csv("data/census2021-ts007a-oa.csv") %>%
  filter(`geography code` %in% area) %>%
  mutate(area = area_name, year=2021) %>%
  select(-date, -geography, -`geography code`, -`Age: Total`) %>%
  rename(
    `0-4`=`Age: Aged 4 years and under`,
    `5-9`=`Age: Aged 5 to 9 years`,
    `10-14`=`Age: Aged 10 to 14 years`,
    `15-19`=`Age: Aged 15 to 19 years`,
    `20-24`=`Age: Aged 20 to 24 years`,
    `25-29`=`Age: Aged 25 to 29 years`,
    `30-34`=`Age: Aged 30 to 34 years`,
    `35-39`=`Age: Aged 35 to 39 years`,
    `40-44`=`Age: Aged 40 to 44 years`,
    `45-49`=`Age: Aged 45 to 49 years`,
    `50-54`=`Age: Aged 50 to 54 years`,
    `55-59`=`Age: Aged 55 to 59 years`,
    `60-64`=`Age: Aged 60 to 64 years`,
    `65-69`=`Age: Aged 65 to 69 years`,
    `70-74`=`Age: Aged 70 to 74 years`,
    `75-79`=`Age: Aged 75 to 79 years`,
    `80-84`=`Age: Aged 80 to 84 years`,
    `85+`=`Age: Aged 85 years and over`,
    ) %>%
  group_by(area, year) %>%
  summarize_if(is.numeric, sum, na.rm=TRUE) %>%
  pivot_longer(!c(area, year), names_to = "age", values_to = "residents") %>%
  mutate(start_age = as.numeric(str_extract(age, "[^-+]+"))) %>%
  mutate(end_age = lead(start_age, default=90)) %>%
  mutate(residents_normalised = ((residents * 5) / (end_age - start_age))) %>%
  mutate(residents_cumulative = cumsum(residents))

age_2011 <-
  read_csv("data/age_2011.csv") %>%
  filter(`geography code` %in% area) %>%
  mutate(area = area_name, year=2011) %>%
  select(-date, -geography, -`geography code`, -`Rural Urban`, -`Age: All usual residents; measures: Value`, -`Age: Mean Age; measures: Value`, -`Age: Median Age; measures: Value`) %>%
  rename(
    `0-4`=`Age: Age 0 to 4; measures: Value`,
    `5-7`=`Age: Age 5 to 7; measures: Value`,
    `8-9`=`Age: Age 8 to 9; measures: Value`,
    `10-14`=`Age: Age 10 to 14; measures: Value`,
    `15`=`Age: Age 15; measures: Value`,
    `16-17`=`Age: Age 16 to 17; measures: Value`,
    `18-19`=`Age: Age 18 to 19; measures: Value`,
    `20-24`=`Age: Age 20 to 24; measures: Value`,
    `25-29`=`Age: Age 25 to 29; measures: Value`,
    `30-44`=`Age: Age 30 to 44; measures: Value`,
    `45-59`=`Age: Age 45 to 59; measures: Value`,
    `60-64`=`Age: Age 60 to 64; measures: Value`,
    `65-74`=`Age: Age 65 to 74; measures: Value`,
    `75-84`=`Age: Age 75 to 84; measures: Value`,
    `85-89`=`Age: Age 85 to 89; measures: Value`,
    `90+`=`Age: Age 90 and over; measures: Value`,
  ) %>%
  group_by(area, year) %>%
  summarize_if(is.numeric, sum, na.rm=TRUE) %>%
  ungroup() %>%
  # rebin to match 2021
  # mutate(
  #   `5-9` = `5-7` + `8-9`,
  #   `15-19` = `15` + `16-17` + `18-19`,
  #   `85+` = `85-89` + `90+`
  # ) %>%
  # select(c(area, year, `0-4`, `5-9`, `10-14`, `15-19`, `20-24`, `25-29`, `30-44`, `45-59`, `60-64`, `65-74`, `75-84`, `85+`)) %>%
  pivot_longer(!c(area, year), names_to = "age", values_to = "residents") %>%
  mutate(start_age = as.numeric(str_extract(age, "[^-+]+"))) %>%
  mutate(end_age = lead(start_age, default=95)) %>%
  mutate(residents_normalised = ((residents * 5) / (end_age - start_age))) %>%
  mutate(residents_cumulative = cumsum(residents))

# calculate median for 2011  
med <- age_2011$residents_cumulative[length(age_2011$residents_cumulative)] / 2
s = age_2011$start_age[age_2011$residents_cumulative>med][1]
e = age_2011$end_age[age_2011$residents_cumulative>med][1]
c = age_2011$residents_cumulative[age_2011$residents_cumulative>med][1]
r = age_2011$residents[age_2011$residents_cumulative>med][1]
median <- s + (e - s) * (med - (c - r)) / r
age_2011 <- age_2011 %>%
  mutate(median_age = median)

# calculate median for 2021  
med <- age_2021$residents_cumulative[length(age_2021$residents_cumulative)] / 2
s = age_2021$start_age[age_2021$residents_cumulative>med][1]
e = age_2021$end_age[age_2021$residents_cumulative>med][1]
c = age_2021$residents_cumulative[age_2021$residents_cumulative>med][1]
r = age_2021$residents[age_2021$residents_cumulative>med][1]
median <- s + (e - s) * (med - (c - r)) / r
age_2021 <- age_2021 %>%
  mutate(median_age = median)

write_csv(age_2011, paste("data", "results", tolower(area_name), "ages-2011.csv", sep = "/"))
write_csv(age_2021, paste("data", "results", tolower(area_name), "ages-2021.csv", sep = "/"))

ages <- bind_rows(age_2011, age_2021)

write_csv(ages, paste("data", "results", tolower(area_name), "ages.csv", sep = "/"))

