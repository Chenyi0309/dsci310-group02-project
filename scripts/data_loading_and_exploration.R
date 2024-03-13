
# Import packages
library(tidyverse)
library(lubridate) 
library(repr)
if (!requireNamespace("corrplot", quietly = TRUE)) install.packages("corrplot")
library(corrplot)

# Load the dataset
housing_data <- read_csv("data/Beijinghouse.csv", locale = locale(encoding = "UTF-8")) %>%
  mutate(floor = str_trim(str_extract(floor,"( .*)"), side = "both"))

# Explore the structure and summary statistics of the dataset
head(housing_data)
tail(housing_data)
summary(housing_data)
