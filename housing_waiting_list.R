library(tidyverse)

source("init.R")

housing_waiting_list <-
  read_csv("data/pcc/housing_waiting_list.csv") %>%
  group_by(`Maximum bedrooms`) %>%
  tally(name="Number waiting")

write_csv(housing_waiting_list, paste("data", "results", tolower(area_name), "housing_waiting_list.csv", sep = "/"))
