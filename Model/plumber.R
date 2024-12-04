library(plumber)
library(tidyverse)

# Load the model
model <- readRDS("reduced_model.rds")

# Define the model version
version_number <- "0.0.1"

# Define the predictors for the model
variables <- list(
  race = "The race of the individual, categorical - Black, Hispanic, Other, or White.",
  armed = "The armed status of the individual, categorical - Yes or No."
)

#* @param race The race of the individual, categorical - Black, Hispanic, Other, or White.
#* @param armed The armed status of the individual, categorical - Yes or No.
#* @get /predict_shot
predict_shot <- function(race = "White", armed = "No") {
  # Convert inputs to appropriate types
  race <- as.character(race)
  armed <- as.character(armed)
  
  # Prepare the payload as a data frame
  payload <- data.frame(
    race = race,
    armed = armed
  )
  
  # Use the logistic regression model to predict probabilities
  predicted_probability <- predict(model, newdata = payload, type = "response")
  
  # Classify based on probability threshold of 0.5
  predicted_class <- ifelse(predicted_probability > 0.5, "Yes", "No")
  
  # Return results as a list
  result <- list(
    "Predicted shot or not" = predicted_class
  )
  
  return(result)
}
