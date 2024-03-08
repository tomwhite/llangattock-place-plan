# Script to find number of resisents and number of households in each of the
# six councils for the bus project:
#
# - Crickhowell
# - Cymdu
# - Llanelly
# - Llangattock
# - Llangynidr
# - Vale of Grwyney

library(tidyverse)

source("init.R")


six_councils <-
  read_csv("data/Six Councils Community Transport - Sheet1.csv")

# Number of usual residents

residents_all <-
  read_csv("data/TS001-2021-3-filtered-2023-05-17T13_38_19Z.csv")

# check there are no codes that are not in the dataset
# this should return 0 rows
six_councils %>%
  anti_join(residents_all, by = c("Code" = "Output Areas Code"))

residents_six_councils <-
  residents_all %>%
  inner_join(six_councils, by = c("Output Areas Code" = "Code")) %>%
  select(`Area name`, Observation) %>%
  group_by(`Area name`) %>%
  summarise(Residents = sum(Observation)) %>%
  ungroup()

# Number of households

households_all <-
  read_csv("data/TS041-2021-3-filtered-2023-05-17T12_02_59Z.csv")

# check there are no codes that are not in the dataset
# this should return 0 rows
six_councils %>%
  anti_join(households_all, by = c("Code" = "Output Areas Code"))

households_six_councils <-
  households_all %>%
  inner_join(six_councils, by = c("Output Areas Code" = "Code")) %>%
  select(`Area name`, Observation) %>%
  group_by(`Area name`) %>%
  summarise(Households = sum(Observation)) %>%
  ungroup()

residents_households_six_councils <-
  residents_six_councils %>%
  inner_join(households_six_councils)

write_csv(residents_households_six_councils, paste("data", "results", "residents_households_six_councils.csv", sep = "/"))
