#### Preamble ####
# Purpose: Build and compare models on the analysis data
# Author: Jingchuan Xu
# Date: 2 December 2024 
# Contact: jingchuan.xu@mail.toronto.ca
# License: MIT
# Pre-requisites: R packages`tidyverse` and `arrow` are loaded


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Model building ####
# Convert 'shot' to a factor for logistic regression
analysis_data <- analysis_data %>%
  mutate(shot = as.factor(shot))

# Manual train-test split (70% train, 30% test)
set.seed(123)  # For reproducibility
n <- nrow(analysis_data)
train_indices <- sample(1:n, size = floor(0.7 * n))
train_data <- analysis_data[train_indices, ]
test_data <- analysis_data[-train_indices, ]

# Full model with all predictors
full_model <- glm(shot ~ age + gender + race + armed, data = train_data, family = binomial)

# Reduced model (e.g., using only 'armed' and 'race')
reduced_model <- glm(shot ~ race + armed, data = train_data, family = binomial)

# Summary of models
summary(full_model)
summary(reduced_model)

# Predict on the test set
test_data$pred_full <- predict(full_model, newdata = test_data, type = "response")
test_data$pred_reduced <- predict(reduced_model, newdata = test_data, type = "response")

# Convert predictions to binary (Yes/No) using a threshold of 0.5
test_data$pred_full_binary <- ifelse(test_data$pred_full > 0.5, "Yes", "No")
test_data$pred_reduced_binary <- ifelse(test_data$pred_reduced > 0.5, "Yes", "No")

# Create confusion matrices manually
confusion_matrix <- function(true_labels, predicted_labels) {
  table(True = true_labels, Predicted = predicted_labels)
}

# Full model confusion matrix
confusion_full <- confusion_matrix(test_data$shot, test_data$pred_full_binary)
confusion_reduced <- confusion_matrix(test_data$shot, test_data$pred_reduced_binary)

# Calculate accuracy manually
calculate_accuracy <- function(confusion_matrix) {
  sum(diag(confusion_matrix)) / sum(confusion_matrix)
}

accuracy_full <- calculate_accuracy(confusion_full)
accuracy_reduced <- calculate_accuracy(confusion_reduced)

# Print results
print("Full Model Confusion Matrix:")
print(confusion_full)
print(paste("Full Model Accuracy:", round(accuracy_full, 3)))

print("Reduced Model Confusion Matrix:")
print(confusion_reduced)
print(paste("Reduced Model Accuracy:", round(accuracy_reduced, 3)))

# Decide which model is better
if (accuracy_full > accuracy_reduced) {
  print("The full model performs better based on accuracy.")
} else if (accuracy_full < accuracy_reduced) {
  print("The reduced model performs better based on accuracy.")
} else {
  print("Both models perform equally well based on accuracy.")
}

# Save the models
saveRDS(
  full_model,
  file = "model/full_model.rds"
)

saveRDS(
  reduced_model,
  file = "model/reduced_model.rds"
)

