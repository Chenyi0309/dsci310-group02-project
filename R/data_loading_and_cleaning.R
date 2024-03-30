#' Load, clean, and wrangle housing data
#'
#' This function reads a housing data CSV, cleans and wrangles the data by removing unwanted columns, handling missing values, and
#' transforming categorical variables into factors with proper labels according to variable descriptions.
#'
#' @param file_path The path to the input CSV file.
#' @param encoding The character encoding of the input file.
#' @return A tibble of the cleaned and wrangled housing data.
#' @export
#'
#' @examples
#' data <- clean_and_wrangle_housing_data("data/Beijinghouse.csv", "UTF-8")
library(readr)
library(dplyr)
library(tidyr)
library(stringr)

clean_and_wrangle_housing_data <- function(file_path, encoding = "UTF-8") {
  housing_data <- suppressWarnings(
    read_csv(file_path, locale = locale(encoding = encoding))) %>%
    select(-c(DOM, url, id, Cid)) %>%
    drop_na() %>%
    mutate(buildingType = factor(case_when(
      buildingType == 1 ~ "Tower",
      buildingType == 2 ~ "Bungalow",
      buildingType == 3 ~ "Plate/Tower",
      buildingType == 4 ~ "Plate",
      TRUE ~ NA_character_
    ), levels = c("Tower", "Bungalow", "Plate/Tower", "Plate"))) 

  return(housing_data)
}

