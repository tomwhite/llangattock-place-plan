library(tidyverse)

source("init.R")

# 2021

accommodation_type_2021 <-
  read_csv("data/TS044-2021-4-filtered-2023-08-02T13_44_49Z.csv") %>%
  filter(`Output Areas Code` %in% area) %>%
  mutate(area = area_name, year=2021) %>%
  mutate(accommodation_type = `Accommodation type (8 categories)`) %>%
  group_by(area, year, accommodation_type) %>%
  summarise(households = sum(Observation)) %>%
  ungroup()

# 2011

# Different categories in 2011

accommodation_type <- accommodation_type_2021

write_csv(accommodation_type, paste("data", "results", tolower(area_name), "accommodation_type.csv", sep = "/"))
