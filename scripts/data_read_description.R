# Import packages
library(tidyverse)
# Load the dataset
housing_data <- read_csv("data/Beijinghouse.csv", locale = locale(encoding = "UTF-8")) %>%
  mutate(floor = str_trim(str_extract(floor,"( .*)"), side = "both"))
# # Explore the structure and summary statistics of the dataset
print(head(housing_data))
# Save the summary of the dataset to a text file
summary(housing_data) %>% 
  capture.output() %>% 
  write_lines("results/summary_of_original_housing_data.txt")