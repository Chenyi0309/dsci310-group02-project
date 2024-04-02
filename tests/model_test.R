library(testthat)
library(tidyverse)

# Assuming the dataset and model script are already loaded
# source("path/to/your/model_script.R") # Make sure the path points to your model building script

# Test if the model training is successful
test_that("Model training is successful", {
  model <- lm(totalPrice ~ . - constructionTime - buildingType, data = beijing_house_price)
  expect_s3_class(model, "lm")
})

# Test if the model can make predictions and the predictions are numeric
test_that("Model can make predictions and predictions are numeric", {
  predicted_prices <- predict(model, newdata = beijing_house_price)
  expect_true(is.numeric(predicted_prices))
})

# Test the performance of the model's predictions on the training dataset
test_that("Model predictions are reasonably close to actual values", {
  predicted_prices <- predict(model, newdata = beijing_house_price)
  actual_prices <- beijing_house_price$totalPrice
  
  # You can choose a threshold for accuracy that makes sense for your model
  expect_that(mean(abs(predicted_prices - actual_prices)), is_less_than(10000))
})

# Test the model's ability to predict on new data
test_that("Model can predict on new data", {
  new_data <- beijing_house_price[1:10, ] # Select a subset of data as new data
  # Remove the actual prices to simulate a new data scenario
  new_data$totalPrice <- NA
  
  # The model should not throw an error when predicting new data
  expect_error(free <- predict(model, newdata = new_data), NA)
})

# Run all the tests
# test_dir("tests/") # Assuming your test scripts are located in the "tests/" directory


