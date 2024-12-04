#### Preamble ####
# Purpose: Cleans the raw police shootings data
# Author: Jingchuan Xu
# Date: 2 December 2024
# Contact: jingchuan.xu@mail.toronto.ca
# License: MIT
# Pre-requisites: Download and save the raw data, R packages`tidyverse` and `arrow` are loaded

#### Workspace setup ####
library(tidyverse)
library(arrow)

# Load raw data
raw_data <- read_csv("data/01-raw_data/police_killings.csv")

# Clean data
clean_data <- raw_data %>%
  filter(age != "Unknown") %>%
  mutate(
    armed = ifelse(armed %in% c("Disputed", "Firearm", "Knife", "Non-lethal firearm", "Other", "Vehicle"), "Yes", "No"),
    race = case_when(
      raceethnicity == "White" ~ "White",
      raceethnicity == "Black" ~ "Black",
      raceethnicity == "Hispanic/Latino" ~ "Hispanic",
      TRUE ~ "Other"
    ),
    shot = ifelse(cause == "Gunshot", "Yes", "No"),
    age = as.numeric(age)
  ) %>%
  select(age, gender, race, armed, shot) %>%
  na.omit() %>%
  as.data.frame()

write_parquet(clean_data, "data/02-analysis_data/analysis_data.parquet")
