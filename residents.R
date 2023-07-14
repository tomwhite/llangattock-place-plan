library(tidyverse)

source("init.R")

# Number of usual residents

residents_2021 <-
  read_csv("data/TS001-2021-3-filtered-2023-05-17T13_38_19Z.csv") %>%
  filter(`Output Areas Code` %in% area) %>%
  mutate(area = area_name, year=2021) %>%
  group_by(area, year, `Residence type (2 categories) Code`, `Residence type (2 categories)`) %>%
  summarise(residents = sum(Observation)) %>%
  ungroup() %>%
  filter(`Residence type (2 categories)` == "Lives in a household") %>%
  select(area, year, residents)

residents_2011 <-
  read_csv("data/residents_2011.csv") %>%
  filter(`geography code` %in% area) %>%
  mutate(area = area_name, year=2011) %>%
  group_by(area, year) %>%
  summarise(residents = sum(`Variable: Lives in a household; measures: Value`)) %>%
  ungroup()

residents <- bind_rows(residents_2011, residents_2021)

write_csv(residents, paste("data", "results", tolower(area_name), "residents.csv", sep = "/"))
