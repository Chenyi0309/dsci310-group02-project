library(testthat)
library(dplyr)

source("R/data_loading_and_cleaning.R")

context("Test data loading and initial cleaning")

test_that("clean_and_wrangle_housing_data function works correctly", {
  test_data_path <- "data/Beijinghouse.csv"
  cleaned_data <- clean_and_wrangle_housing_data(test_data_path, "UTF-8")
  
  expect_false(any(colnames(cleaned_data) %in% c("DOM", "url", "id", "Cid")))
  expect_equal(sum(is.na(cleaned_data)), 0)
  
  expected_building_types <- c("Tower", "Bungalow", "Plate/Tower", "Plate")
  
  expect_equal(levels(cleaned_data$buildingType), expected_building_types)
})

### Still want to add some test here!!!!