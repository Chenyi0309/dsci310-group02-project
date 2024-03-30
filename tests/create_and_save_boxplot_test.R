#Creating the stup for our tests

source("R/create_and_save_boxplot.R")
library(testthat)

# Making a mock dataframe of the beijing_house_price dataset for testing
beijing_house_price <- data.frame(
  subway = factor(c("Yes", "No", "Yes", "No")),
  elevator = factor(c("Yes", "No", "No", "Yes")),
  totalPrice = c(500, 600, 550, 620)
)

test_that("Successful execution with valid input", {
  temp_file <- tempfile(fileext = ".png")
  expect_silent(create_boxplot(beijing_house_price, "subway", "totalPrice", NULL,
                               "Valid Input Test", "Total Housing Price", temp_file))
  expect_true(file.exists(temp_file))
  unlink(temp_file)  # we need to clean this temporary file after test has passed
})

test_that("Handling of non-existent columns", {
  temp_file <- tempfile(fileext = ".png")
  expect_error(create_boxplot(beijing_house_price, "nonExistentColumn", "totalPrice", NULL,
                              "Non-existent Column Test", "Total Housing Price", temp_file))
}) # no new file has been created in this test, hence, we don't have to use "unlink"

test_that("Verification of plot dimensions", {
  temp_file <- tempfile(fileext = ".png")
  expect_silent(create_boxplot(beijing_house_price, "elevator", "totalPrice", NULL,
                               "Dimension Test", "Total Housing Price", temp_file, 10, 6))
  expect_true(file.exists(temp_file))
  unlink(temp_file)  #again, we need to clean this temporary file after test has passed
})