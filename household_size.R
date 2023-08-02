library(tidyverse)

source("init.R")

# 2021

household_size_2021 <-
  read_csv("data/TS017-2021-3-filtered-2023-05-17T13_13_52Z.csv") %>%
  filter(`Output Areas Code` %in% area) %>%
  mutate(area = area_name, year=2021) %>%
  mutate(size = `Household size (9 categories) Code`)  %>%
  group_by(area, year, size) %>%
  summarise(households = sum(Observation)) %>%
  ungroup()
  

# 2011

household_size_2011 <-
  read_csv("data/household_composition_2011.csv") %>%
  filter(`geography code` %in% area) %>%
  mutate(area = area_name, year=2011) %>%
  group_by(area, year) %>%
  summarise(households = sum(`Household Composition: One person household; measures: Value`)) %>%
  ungroup() %>%
  mutate(size=1)


household_sizes <- bind_rows(household_size_2011, household_size_2021)

write_csv(household_sizes, paste("data", "results", tolower(area_name), "household_sizes.csv", sep = "/"))
