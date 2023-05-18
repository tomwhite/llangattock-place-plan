library(tidyverse)

# 2021

llangattock_area <- c("W00002467", "W00002466", "W00002465")

economic_activity_2021 <-
  read_csv("data/TS066-2021-5-filtered-2023-05-17T14_40_31Z.csv") %>%
  filter(`Output Areas Code` %in% llangattock_area) %>%
  mutate(area = "Llangattock", year=2021) %>%
  mutate(
    economically_active = if_else(
      startsWith(`Economic activity status (20 categories)`, "Economically active"),
      Observation,
      0
    ),
    economically_inactive = if_else(
      startsWith(`Economic activity status (20 categories)`, "Economically inactive"),
      Observation,
      0
    ),
    retired = if_else(
      startsWith(`Economic activity status (20 categories)`, "Economically inactive: Retired"),
      Observation,
      0
    ),
  ) %>%
  group_by(area, year) %>%
  summarise(
    economically_active = sum(economically_active),
    economically_inactive = sum(economically_inactive),
    retired = sum(retired),
  ) %>%
  ungroup()

# 2011

economic_activity_2011 <-
  read_csv("data/economic_activity_2011.csv") %>%
  filter(`geography code` %in% llangattock_area) %>%
  mutate(area = "Llangattock", year=2011) %>%
  group_by(area, year) %>%
  summarise(
    economically_active = sum(`Economic Activity: Economically active: Total; measures: Value`),
    economically_inactive = sum(`Economic Activity: Economically inactive: Total; measures: Value`),
    retired = sum(`Economic Activity: Economically inactive: Retired; measures: Value`)
  ) %>%
  ungroup()


economic_activity <- bind_rows(economic_activity_2011, economic_activity_2021)

write_csv(economic_activity, "data/results/economic_activity.csv")
