library(dplyr)
library(ggplot2)

# Load data
police_data <- read.csv("police_killings.csv", encoding = "ISO-8859-1")
data <- read.csv("police_killings.csv", encoding = "ISO-8859-1")


# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load data
police_data <- read.csv("police_killings.csv", encoding = "ISO-8859-1")
data <- read.csv("police_killings.csv", encoding = "ISO-8859-1")

# Save as RDS
saveRDS(police_data, "police_data.rds")
saveRDS(data, "data.rds")

# To verify, you can reload and inspect the RDS file
reloaded_data <- readRDS("police_data.rds")
head(reloaded_data)
