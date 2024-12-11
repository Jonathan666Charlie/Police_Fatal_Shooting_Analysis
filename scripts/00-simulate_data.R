#### Preamble ####
# Purpose: Simulates the cleaned police shootings data
# Author: Jingchuan Xu
# Date: 2 December 2024
# Contact: jingchuan.xu@mail.toronto.ca
# License: MIT
# Pre-requisites: R packages`tidyverse` is loaded

#### Workspace setup ####
library(tidyverse)

#### Simulating data ####
set.seed(123) # For reproducibility

# Number of rows in the simulated dataset
n <- 1000

# Simulating age
age <- sample(16:90, n, replace = TRUE)
# Simulating gender
gender <- sample(c("Male", "Female"), n, replace = TRUE, prob = c(0.8, 0.2))
# Simulating race with probabilities
race <- sample(c("White", "Black", "Hispanic", "Other"), n, replace = TRUE, prob = c(0.6, 0.2, 0.15, 0.05))
# Simulating whether armed, based on race (for example, minorities more likely to be categorized as armed)
armed <- ifelse(race %in% c("Black", "Hispanic") & runif(n) < 0.6, "Yes",
  ifelse(race == "White" & runif(n) < 0.3, "Yes", "No")
)
# Simulating whether shot, depending on armed status and race
shot <- ifelse(armed == "Yes" & runif(n) < 0.7, "Yes",
  ifelse(armed == "No" & runif(n) < 0.3, "Yes", "No")
)
# Combining into a data frame
simulated_data <- data.frame(
  age = age,
  gender = gender,
  race = race,
  armed = armed,
  shot = shot
)

# View first few rows
head(simulated_data)

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
