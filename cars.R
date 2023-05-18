library(tidyverse)

# Cars or vans

cars_2021 <-
  read_csv("data/TS045-2021-4-filtered-2023-05-14T17_05_31Z.csv") %>%
  filter(`Output Areas Code` %in% llangattock_area) %>%
  mutate(area = "Llangattock", year=2021) %>%
  mutate(
    cars = if_else(
      `Car or van availability (5 categories) Code` < 0,
      0,
      `Car or van availability (5 categories) Code` * Observation
    ),
    households_with_no_car = if_else(
      `Car or van availability (5 categories) Code` == 0,
      Observation,
      0
    )
  ) %>%
  group_by(area, year) %>%
  summarise(
    cars = sum(cars),
    households_with_no_car = sum(households_with_no_car)
  ) %>%
  ungroup()


cars_2011 <-
  read_csv("data/cars_2011.csv") %>%
  filter(`geography code` %in% llangattock_area) %>%
  mutate(area = "Llangattock", year=2011) %>%
  group_by(area, year) %>%
  summarise(
    cars = sum(`Cars: sum of all cars or vans in the area; measures: Value`),
    households_with_no_car = sum(`Cars: No cars or vans in household; measures: Value`)
  ) %>%
  ungroup()

cars <- bind_rows(cars_2011, cars_2021)

write_csv(cars, "data/results/cars.csv")

