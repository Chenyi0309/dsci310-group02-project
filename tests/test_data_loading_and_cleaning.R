library(testthat)
library(dplyr)

source("R/data_loading_and_cleaning.R")

context("Test data loading and initial cleaning")

test_data_path <- "data/Beijinghouse.csv"
  cleaned_data <- clean_and_wrangle_housing_data(test_data_path, "UTF-8")

test_that("clean_and_wrangle_housing_data function works correctly", {
  expect_false(any(colnames(cleaned_data) %in% c("DOM", "url", "id", "Cid")))
  expect_equal(sum(is.na(cleaned_data)), 0)
  
  expected_building_types <- c("Tower", "Bungalow", "Plate/Tower", "Plate")
  
  expect_equal(levels(cleaned_data$buildingType), expected_building_types)
})

test_that("removed columns are absent", {
  expect_false(any(colnames(cleaned_data) %in% c("DOM", "url", "id", "Cid")))
})

test_that("all rows with NAs are removed", {
  expect_equal(sum(complete.cases(cleaned_data)), nrow(cleaned_data))
})

test_that("data types of columns are as expected", {
  expect_true(is.numeric(cleaned_data$price))
  expect_true(is.factor(cleaned_data$buildingType))
})

test_that("function handles incorrect file paths gracefully", {
  expect_error(clean_and_wrangle_housing_data("nonexistent/path.csv", "UTF-8"))
})
