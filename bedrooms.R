library(tidyverse)

source("init.R")

# 2021

bedrooms_2021 <-
  read_csv("data/TS050-2021-4-filtered-2023-08-02T11_38_38Z.csv") %>%
  filter(`Output Areas Code` %in% area) %>%
  mutate(area = area_name, year=2021) %>%
  mutate(bedrooms = `Number of Bedrooms (5 categories) Code`)  %>%
  filter(bedrooms >= 0) %>%
  group_by(area, year, bedrooms) %>%
  summarise(households = sum(Observation)) %>%
  ungroup()

# 2011

# No breakdown by number of bedrooms, just averages

bedrooms <- bedrooms_2021

write_csv(bedrooms, paste("data", "results", tolower(area_name), "bedrooms.csv", sep = "/"))
