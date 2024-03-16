# Import necessary libraries
library(tidyverse)

# Load the preprocessed data
na_count <- housing_data %>%
  summarise(across(everything(), ~sum(is.na(.)))) %>%
  pivot_longer(everything(), names_to = "Variable", values_to = "NA_count")

# Generate the plot with NA value
na_plot <- ggplot(na_count, aes(x = reorder(Variable, NA_count), y = NA_count)) +
  geom_bar(stat = "identity") +
  coord_flip() +  # Flip the axes to make the bars horizontal
  labs(x = "Variable", y = "Number of Missing Values", 
       title = "Number of Missing Values per Variable") +
  theme_minimal(base_size = 12) + # Use a minimal theme with base font size set
  theme(
    plot.background = element_rect(fill = "white", colour = "white"), # Set the plot background color to white
    panel.background = element_rect(fill = "white", colour = "white"), # Set the panel background color to white
    text = element_text(size = 12), # Adjust the text size
    axis.title = element_text(size = 14), # Adjust the size of axis titles
    axis.text = element_text(size = 12), # Adjust the size of axis text
    plot.title = element_text(size = 16, hjust = 0.5) # Center the plot title and set its size
  )
# Save the plot to a file with a white background
ggsave("results/figure/data_clean_na_count_plot.png", plot = na_plot, width = 10, height = 8, bg = "white", dpi = 300)

# we decided drop DOM columns (Beccause DOM's data have more than 90% are missing), and drop other missing values (The other misses are few that we just drop them).
beijing_house_price <- housing_data %>% 
                                select(-DOM,-url, -id, -Cid)%>% 
                                drop_na()
# Perform the final check for missing values
na_check_results <- sapply(beijing_house_price, function(x) sum(is.na(x)))
# Print the results to the console
print(na_check_results)
# Save the results to a text file
write.table(na_check_results, file = "results/final_na_value_check_processingpart.txt", col.names = NA)

# Transforming categorical variables into readable factors with proper labels according to variable discription
beijing_house_price <- beijing_house_price %>%
  mutate(
    # Change 'buildingType' numerical codes into descriptive categories
    buildingType = case_when(
      buildingType == 1 ~ "Tower",
      buildingType == 2 ~ "Bungalow",
      buildingType == 3 ~ "Plate/Tower",
      buildingType == 4 ~ "Plate"
    ),

    # Change 'renovationCondition' numerical codes into descriptive categories
    renovationCondition = case_when(
      renovationCondition == 1 ~ "Other",
      renovationCondition == 2 ~ "Rough",
      renovationCondition == 3 ~ "Simplicity",
      renovationCondition == 4 ~ "Hardcover"
    ),

    # Change 'buildingStructure' numerical codes into descriptive categories
    buildingStructure = case_when(
      buildingStructure == 1 ~ "Unavailable",
      buildingStructure == 2 ~ "Mixed",
      buildingStructure == 3 ~ "Brick/Wood",
      buildingStructure == 4 ~ "Brick/Concrete",
      buildingStructure == 5 ~ "Steel",
      buildingStructure == 6 ~ "Steel/Concrete"
    ),

    # Encode 'elevator' presence as a categorical variable
    elevator = case_when(
      elevator == 1 ~ "Has_Elevator",
      elevator != 1 ~ "No_elevator"
    ),

    # Encode 'subway' proximity as a categorical variable
    subway = case_when(
      subway == 1 ~ "Has_Subway",
      subway != 1 ~ "No_Subway"
    ),

    # Encode 'fiveYearsProperty' as a categorical variable indicating ownership duration
    fiveYearsProperty = case_when(
      fiveYearsProperty == 1 ~ "Ownership < 5years",
      fiveYearsProperty != 1 ~ "Ownership > 5years"
    ),

    # Change 'district' numerical codes into descriptive categories
    district = case_when(
      district == 1 ~ "DongCheng",
      district == 2 ~ "FengTai",
      district == 3 ~ "DaXing",
      district == 4 ~ "FaXing",
      district == 5 ~ "FangShang",
      district == 6 ~ "ChangPing",
      district == 7 ~ "ChaoYang",
      district == 8 ~ "HaiDian",
      district == 9 ~ "ShiJingShan",
      district == 10 ~ "XiCheng",
      district == 11 ~ "TongZhou",
      district == 12 ~ "ShunYi",
      district == 13 ~ "MenTouGou"
    )
  ) %>%
  # Convert the new descriptive categories into factor variables
  mutate(
    renovationCondition = as.factor(renovationCondition),
    buildingStructure = as.factor(buildingStructure),
    elevator = as.factor(elevator),
    subway = as.factor(subway),
    fiveYearsProperty = as.factor(fiveYearsProperty),
    district = as.factor(district)
  )

# Save the transformed data to a new CSV file
write.csv(beijing_house_price, "results/beijing_house_price_cleaned.csv", row.names = FALSE)
