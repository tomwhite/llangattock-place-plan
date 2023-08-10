library(tidyverse)
library("readxl")

source("init.R")

path <- "data/ons/house_sales/HPSSA Dataset 36 - Number of residential property sales by ward.xls"
excel_sheets(path)
contents <- read_excel(path, sheet="Contents")
house_sales <- read_excel(path, sheet="1a", skip=4) %>%  # all house types
  filter(`Ward code` %in% ward)  %>%
  mutate_at(vars(!c(`Local authority code`, `Local authority name`, `Ward code`, `Ward name`)), as.numeric) %>%
  pivot_longer(!c(`Local authority code`, `Local authority name`, `Ward code`, `Ward name`), names_to = "date", values_to = "sales")

path <- "data/ons/house_sales/HPSSA Dataset 37 - Median price paid by ward.xls"
contents <- read_excel(path, sheet="Contents")
house_prices_median <- read_excel(path, sheet="1a", skip=4) %>%  # all house types
  filter(`Ward code` %in% ward) %>%
  mutate_at(vars(!c(`Local authority code`, `Local authority name`, `Ward code`, `Ward name`)), as.numeric) %>%
  pivot_longer(!c(`Local authority code`, `Local authority name`, `Ward code`, `Ward name`), names_to = "date", values_to = "median_price")


path <- "data/ons/house_sales/HPSSA Dataset 40 - Tenth percentile price paid by ward.xls"
contents <- read_excel(path, sheet="Contents")
house_prices_tenth_percentile <- read_excel(path, sheet="1a", skip=4) %>%  # all house types
  filter(`Ward code` %in% ward) %>%
  mutate_at(vars(!c(`Local authority code`, `Local authority name`, `Ward code`, `Ward name`)), as.numeric) %>%
  pivot_longer(!c(`Local authority code`, `Local authority name`, `Ward code`, `Ward name`), names_to = "date", values_to = "tenth_percentile_price")

house_prices <- house_sales %>%
  inner_join(house_prices_median) %>%
  inner_join(house_prices_tenth_percentile)

write_csv(house_prices, paste("data", "results", tolower(area_name), "house_prices.csv", sep = "/"))
