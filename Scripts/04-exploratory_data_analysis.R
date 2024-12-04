#### Preamble ####
# Purpose: Visually explores the analysis data
# Author: Jingchuan Xu
# Date: 2 December 2024
# Contact: jingchuan.xu@mail.toronto.ca
# License: MIT
# Pre-requisites: R packages`tidyverse`, `gridExtra` and `arrow` are loaded

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(gridExtra)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Data visualization ####
# Distribution of Age
plot_age <- ggplot(analysis_data, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "blue", alpha = 0.7, color = "black") +
  labs(title = "Age Distribution", x = "Age", y = "Count")

# Gender Proportion
plot_gender <- ggplot(analysis_data, aes(x = gender, fill = gender)) +
  geom_bar(alpha = 0.7) +
  labs(title = "Gender Proportion", x = "Gender", y = "Count") +
  scale_fill_brewer(palette = "Set1")

# Race Proportion
plot_race <- ggplot(analysis_data, aes(x = race, fill = race)) +
  geom_bar(alpha = 0.7) +
  labs(title = "Race Proportion", x = "Race", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_brewer(palette = "Set2")

# Armed vs. Shot
plot_armed_shot <- ggplot(analysis_data, aes(x = armed, fill = shot)) +
  geom_bar(position = "fill", alpha = 0.8) +
  labs(title = "Proportion of Shot by Armed Status", x = "Armed Status", y = "Proportion") +
  scale_fill_brewer(palette = "Set3")

# Race vs. Armed
plot_race_armed <- ggplot(analysis_data, aes(x = race, fill = armed)) +
  geom_bar(position = "fill", alpha = 0.8) +
  labs(title = "Proportion of Armed Status by Race", x = "Race", y = "Proportion") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_brewer(palette = "Set3")

# Age vs. Shot
plot_age_shot <- ggplot(analysis_data, aes(x = age, fill = shot)) +
  geom_histogram(binwidth = 5, alpha = 0.7, position = "stack", color = "black") +
  labs(title = "Age Distribution by Shot Status", x = "Age", y = "Count") +
  scale_fill_brewer(palette = "Set1")

# Gender vs. Shot
plot_gender_shot <- ggplot(analysis_data, aes(x = gender, fill = shot)) +
  geom_bar(position = "fill", alpha = 0.7) +
  labs(title = "Proportion of Shot Status by Gender", x = "Gender", y = "Proportion") +
  scale_fill_brewer(palette = "Set2")

# Race vs. Shot
plot_race_shot <- ggplot(analysis_data, aes(x = race, fill = shot)) +
  geom_bar(position = "fill", alpha = 0.8) +
  labs(title = "Proportion of Shot Status by Race", x = "Race", y = "Proportion") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_brewer(palette = "Set3")

# Display all plots
grid.arrange(plot_age, plot_gender, plot_race,
  plot_armed_shot, plot_race_armed,
  ncol = 2
)

grid.arrange(plot_age_shot, plot_gender_shot, plot_race_shot, ncol = 1)
