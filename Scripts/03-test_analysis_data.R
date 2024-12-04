#### Preamble ####
# Purpose: Tests the simulated data
# Author: Jingchuan Xu
# Date: 2 December 2024 
# Contact: jingchuan.xu@mail.toronto.ca
# License: MIT
# Pre-requisites: R packages`tidyverse`, `arrow`, and `testthat` are loaded

#### Workspace setup ####
library(testthat)
library(arrow)
library(tidyverse)

# Load the simulated data
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

# Example tests for the simulated dataset
test_that("Dataset has correct structure and variable types", {
  # Check if the dataset is a data frame
  expect_s3_class(analysis_data, "data.frame")
  
  # Check if all columns exist
  expect_true(all(c("age", "gender", "race", "armed", "shot") %in% colnames(analysis_data)))
  
  # Check column types
  expect_type(analysis_data$age, "double")
  expect_type(analysis_data$gender, "character")
  expect_type(analysis_data$race, "character")
  expect_type(analysis_data$armed, "character")
  expect_type(analysis_data$shot, "character")
})

test_that("Age values are within expected range", {
  # Check if age is between 16 and 90
  expect_true(all(analysis_data$age >= 16 & analysis_data$age <= 90))
})

test_that("Gender contains only valid categories", {
  # Check if gender only has 'Male' and 'Female'
  expect_true(all(analysis_data$gender %in% c("Male", "Female")))
})

test_that("Race contains only valid categories", {
  # Check if race only has expected values
  expect_true(all(analysis_data$race %in% c("White", "Black", "Hispanic", "Other")))
})

test_that("Shot contains only valid categories", {
  # Check if shot only has expected values
  expect_true(all(analysis_data$shot %in% c("Yes", "No")))
})

test_that("Armed contains only valid categories", {
  # Check if armed only has expected values
  expect_true(all(analysis_data$armed %in% c("Yes", "No")))
})
