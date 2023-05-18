library(tidyverse)

# Output areas that we are interested in
llangattock_area <- c("W00002467", "W00002466", "W00002465")

# Number of households

households_2021 <-
  read_csv("data/TS041-2021-3-filtered-2023-05-17T12_02_59Z.csv") %>%
  filter(`Output Areas Code` %in% llangattock_area) %>%
  mutate(area = "Llangattock", year=2021) %>%
  group_by(area, year) %>%
  summarise(households = sum(Observation)) %>%
  ungroup()

households_2011 <-
  read_csv("data/household_spaces_2011.csv") %>%
  filter(`geography code` %in% llangattock_area) %>%
  mutate(area = "Llangattock", year=2011) %>%
  group_by(area, year) %>%
  summarise(households = sum(`Household Spaces: Household spaces with at least one usual resident; measures: Value`)) %>%
  ungroup()

households <- bind_rows(households_2011, households_2021)

write_csv(households, "data/results/households.csv")
