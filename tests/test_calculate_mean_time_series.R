library(testthat)
library(ggplot2)
# Assume the monthly_price_overview data frame has been defined correctly
monthly_price_overview <- data.frame(
  monthlyTradeTS = seq(as.Date("2020-01-01"), by = "month", length.out = 6),
  mean_price = seq(100000, 600000, by = 100000),
  count = seq(100, 600, by = 100)
)

# Test that the function returns a ggplot object when given valid input
# This test verifies that the function behaves correctly under normal conditions,
# and successfully generates a time series plot.
test_that("create_time_series_plot returns a ggplot object for valid input", {
  plot <- create_time_series_plot(monthly_price_overview)
  expect_true(is.ggplot(plot), "The function should return a ggplot object when given valid input.")
})

# Test that the function throws an error when a required column is missing
# This test ensures that the function checks for the presence of all required columns
# and provides a helpful error message if any are missing. This helps prevent confusing
# results due to incomplete input data.
test_that("create_time_series_plot throws an error for missing required columns", {
  # Create a version of the data frame with the 'mean_price' column removed
  missing_columns_df <- monthly_price_overview[, -which(names(monthly_price_overview) == "mean_price")]
  # Expect an error indicating that required columns are missing
  expect_error(create_time_series_plot(missing_columns_df),
               regexp = "missing one or more required columns", 
               info = "The function should throw an error when the input data frame is missing one or more required columns.")
})

# Test that the function can handle an empty data frame without throwing an error
# This test is important for checking the robustness of the function. The function should
# be able to gracefully handle cases where the input data frame is empty, either by returning
# an empty plot or by some other means that does not result in a crash or unhelpful error.
test_that("create_time_series_plot handles empty data frame without error", {
  # Create an empty version of the data frame
  empty_df <- monthly_price_overview[FALSE, ]
  # Check that the function returns a ggplot object, indicating that it can handle empty data frames
  plot <- create_time_series_plot(empty_df)
  expect_true(is.ggplot(plot), "The function should handle an empty data frame without throwing an error and return a ggplot object.")
})
