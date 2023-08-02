library(tidyverse)

source("init.R")

# 2021

tenure_2021 <-
  read_csv("data/TS054-2021-4-filtered-2023-08-02T12_46_30Z.csv") %>%
  filter(`Output Areas Code` %in% area) %>%
  mutate(area = area_name, year=2021) %>%
  mutate(tenure = `Tenure of household (9 categories)`) %>%
  group_by(area, year, tenure) %>%
  summarise(households = sum(Observation)) %>%
  ungroup()


# 2011

tenure_2011 <-
  read_csv("data/tenure_2011.csv") %>%
  filter(`geography code` %in% area) %>%
  mutate(area = area_name, year=2011) %>%
  group_by(area, year) %>%
  summarize_if(is.numeric, sum, na.rm=TRUE) %>%
  ungroup() %>%
  select(
    -date,
    -`Tenure: All households; measures: Value`,
    -`Tenure: Owned; measures: Value`,
    -`Tenure: Private rented; measures: Value`,
    -`Tenure: Social rented; measures: Value`,
  ) %>%
  rename(
    `Lives rent free`=`Tenure: Living rent free; measures: Value`,
    `Owned: Owns outright`=`Tenure: Owned: Owned outright; measures: Value`,
    `Owned: Owns with a mortgage or loan`=`Tenure: Owned: Owned with a mortgage or loan; measures: Value`,
    `Private rented: Other private rented`=`Tenure: Private rented: Other; measures: Value`,
    `Private rented: Private landlord or letting agency`=`Tenure: Private rented: Private landlord or letting agency; measures: Value`,
    `Shared ownership: Shared ownership`=`Tenure: Shared ownership (part owned and part rented); measures: Value`,
    `Social rented: Other social rented`=`Tenure: Social rented: Other; measures: Value`,
    `Social rented: Rents from council or Local Authority`=`Tenure: Social rented: Rented from council (Local Authority); measures: Value`,
  ) %>%
  pivot_longer(!c(area, year), names_to = "tenure", values_to = "households")


tenure <- bind_rows(tenure_2011, tenure_2021)

write_csv(tenure, paste("data", "results", tolower(area_name), "tenure.csv", sep = "/"))

