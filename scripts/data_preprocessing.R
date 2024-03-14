
# Preprocess the dataset
housing_data <- select(housing_data, -url, -id, -Cid) %>%
  mutate(tradeTime = as.Date(tradeTime),
         livingRoom = as.integer(livingRoom),
         drawingRoom = as.integer(drawingRoom),
         bathroom = as.integer(bathRoom),
         constructionTime = as.integer(constructionTime)) %>%
  select(-floor) %>% # Remove variables with Chinese characters
  filter(bathRoom <= 7) # Correct error in bathRoom column

# Check for missing values
summary(housing_data)

# Create a 'results' directory if it doesn't exist
if (!dir.exists("results")) {
  dir.create("results")
}

# Generate a table of the clean data to be used in the report
write.csv(housing_data, "results/clean_data_table.csv", row.names = FALSE)
