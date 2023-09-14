library(tidyverse)
library(writexl)

# Export as Excel spreadsheets

write_xlsx(
  list(
    "ages" = ages,
    "households" = households,
    "household sizes" = household_sizes,
    "residents" = residents
  ),
  "data/results/categories/population.xls"
)

write_xlsx(
  list(
    "accommodation type" = accommodation_type,
    "bedrooms" = bedrooms,
    "tenure" = tenure,
    "house prices" = house_prices,
    "housing waiting list" = housing_waiting_list
  ),
  "data/results/categories/housing.xls"
)

write_xlsx(
  list(
    "cars" = cars
  ),
  "data/results/categories/travel.xls"
)

write_xlsx(
  list(
    "economic activity" = economic_activity
  ),
  "data/results/categories/work.xls"
)
