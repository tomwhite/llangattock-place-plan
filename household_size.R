library(tidyverse)

# 2021

llangattock_area <- c("W00002467", "W00002466", "W00002465")

household_size_2021 <-
  read_csv("data/TS017-2021-3-filtered-2023-05-17T13_13_52Z.csv")

llangattock_household_size_2021 <- household_size_2021 %>%
  filter(`Output Areas Code` %in% llangattock_area)
