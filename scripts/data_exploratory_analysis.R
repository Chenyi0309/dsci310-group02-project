library(tidyverse)
library(corrplot)
library(ggplot2)
library(cowplot)
library(lubridate)
library(ggmap)
library(mapproj)
library(viridis)
source("R/create_and_save_boxplot.R")

# Graph 1: Distribution of Total Price
#Assuming the preprocessed data is stored in 'results/beijing_house_price_cleaned.csv'
beijing_house_price <- read_csv("results/beijing_house_price_cleaned.csv")
# First,let's explore the total price distribution of the houses
options(repr.plot.width=10, repr.plot.height=6)
mean_price <- mean(beijing_house_price$totalPrice, na.rm = TRUE)
Price_distribution_plot <- ggplot(beijing_house_price, aes(x = totalPrice)) + 
  geom_histogram(fill = "steelblue", color = "white", bins = 80) + 
  geom_vline(xintercept = mean(beijing_house_price$totalPrice, na.rm = TRUE), 
             col = "red", size = 1) +
  labs(title = "Plot 1: Distribution of Total Price", 
       x = "Total housing price(in 10,000 CNY)") +
  coord_cartesian(xlim = c(0, 1500))  # Set the x-axis view limits
ggsave("results/figure/plot_1_totalprice_distribution_plot.png", plot = Price_distribution_plot, device = "png")



# Graph 2: correlation matrix of the numerical variables
# calculate the correlation matrix  of the numerical variables
options(repr.plot.width=10, repr.plot.height=6)
cor_numVar <- cor(select_if(beijing_house_price, is.numeric), 
                  use = "complete.obs", method = "spearman")
# plot the correlation matrix
png("results/figure/plot_2_correlation_plot.png", width = 10, height = 10, units = "in", res = 300)
corrplot.mixed(cor_numVar, 
               tl.col = "black", 
               tl.pos = "lt", 
               tl.cex = 0.7, 
               cl.cex = 0.7, 
               number.cex = 0.7,
               title = "Plot 2: Correlation Matrix of the Numerical Variables",
               mar = c(0,0,2,0))
dev.off()

# Graph 3: Total housing price of whether having subway
create_boxplot(beijing_house_price, "subway", "totalPrice", "subway",
               "Plot 3: Total housing price of whether having subway", "Total housing price",
               "results/figure/plot_3_price_distribution_subway.png", 10, 5)

# Graph 4: Total housing price of whether having elevator
create_boxplot(beijing_house_price, "elevator", "totalPrice", "elevator",
               "Plot 4: Total housing price of whether having elevator", "Total housing price",
               "results/figure/plot_4_price_distribution_elevator.png", 10, 6)

# Graph 5: Prices In Function Of The Renovation Condition
options(repr.plot.width=10, repr.plot.height=6)
renovation_condition_plot <- ggplot(beijing_house_price, aes(x = renovationCondition, y = price, color = renovationCondition)) +
   geom_boxplot(alpha=0.5) + 
   labs(title = "Plot5: Prices In Function Of The Renovation Condition", 
        y = "Price Per Sqft") 
ggsave("results/figure/plot_5_renovation_condition.png", plot = renovation_condition_plot, device = "png")


# Assuming the beijing_house_price dataset has been loaded
# Convert 'tradeTime' to Date format, assuming it's already in the proper format
beijing_house_price <- beijing_house_price %>%
  mutate(
    tradeTime = as.Date(tradeTime), # Assures 'tradeTime' is in Date format
    year = year(tradeTime), # Extracts year from 'tradeTime'
    month = month(tradeTime), # Extracts numeric month from 'tradeTime'
    # Generates the first day of each month for time series analysis
    monthlyTradeTS = as.Date(paste(year, month, "01", sep="-"))
  )

# Aggregate the data to get a count of trades and the mean price for each month after 2009
monthly_price_overview <- beijing_house_price %>%
  filter(year(tradeTime) > 2009) %>% # Filters out the data before 2010
  group_by(monthlyTradeTS) %>%
  summarise(
    count = n(), # Counts the number of trades per month
    mean_price = mean(price, na.rm = TRUE) # Calculates the mean price, excluding NA values
  )

# Plotting the time series of the average monthly traded house prices
# The size of the points reflects the number of houses traded each month
time_series_plot <- ggplot(monthly_price_overview, aes(x = monthlyTradeTS, y = mean_price)) + 
  geom_line(size = 2, alpha = .25, color = 'steelblue') +
  geom_point(aes(size = count), alpha = .75, color = 'steelblue') +
  theme_minimal(base_size = 14) +
  labs(
    title = 'Plot 6: Monthly Average Residential Sale Prices (time series plot)',
    subtitle = 'Point size indicates monthly transaction volume',
    x = "Time", 
    y = "Average Price in (CNY)" 
  ) +
  scale_size(range = c(1, 10))

# Save the time series plot with consistent styling and white background
ggsave("results/figure/plot_6_monthly_price_overview.png", time_series_plot, width = 10, height = 8, bg = "white", dpi = 300)



load(file = "data/beijing_map.RData",verbose = TRUE)
ggsave("results/figure/plot_7_beijing_map.png", plot = beijing, width = 10, height = 8, units = "in")

# Adding points to the map with price as the color and saving the plot
# Update the path to 'data3' as needed to match your actual data location.
beijing_map_plot <- beijing + 
  geom_point(data = beijing_house_price, aes(x = Lng, y = Lat, color = price), size = 1.3, alpha = 0.5) +
  scale_color_viridis(option = "C") +  # Select the viridis color scale
  theme_minimal() +  # Use a minimal theme
  theme(
    panel.background = element_rect(fill = "white", colour = "white"), # Set the panel background to white
    plot.background = element_rect(fill = "white", colour = "white") # Set the plot background to white
  ) +
  labs(title = "Beijing Map with Price Overlay", 
       color = "Price")  # Label for the color scale

# Save the map plot to a file with a white background
ggsave("results/figure/plot_8_beijing_map_with_price_overlay.png", plot = beijing_map_plot, width = 10, height = 8, bg = "white", dpi = 300)



# Assuming beijing_house_price_cleaned is your cleaned dataset
# First, group data by 'district', calculate the median price for each district,
# and reorder districts based on their median price in descending order
beijing_house_price <- beijing_house_price %>%
  group_by(district) %>%
  mutate(median_price = median(price, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(district = reorder(district, -median_price))

# Create a boxplot visualizing housing prices across districts
# with districts ordered by their median housing price
boxplot_price_district <- ggplot(beijing_house_price, aes(x = district, y = price, fill = district)) +
  geom_boxplot() +  # Add boxplot layer
  labs(
    title = "Plot9:District-wise Housing Price Distribution in Beijing", 
    subtitle = "Comparative Analysis of Prices across Different Districts",
    x = "District", 
    y = "Price Per Square Meter (CNY)") +
  theme_minimal() +  # Use a minimal theme
    theme(
    panel.background = element_rect(fill = "white", colour = "white"), # Set the panel background to white
    plot.background = element_rect(fill = "white", colour = "white") # Set the plot background to white
  ) +
  coord_flip()  # Flip coordinates for horizontal boxplot presentation

# Save the academic-looking boxplot with a white background to a file
ggsave("results/figure/plot_9_boxplot_price_district.png", plot = boxplot_price_district, width = 10, height = 8, units = "in", dpi = 300)


# Adding points to the map with district as the color and saving the plot
map_with_points <- beijing + 
  geom_point(data = beijing_house_price, aes(x = Lng, y = Lat, color = district), size = 1.2, alpha = 1) +
  theme_minimal() +  # Use a minimal theme as a base for cleanliness
  theme(
    plot.background = element_rect(fill = "white", colour = NA),  # Set plot background to white
    panel.background = element_rect(fill = "white", colour = NA)
  ) +
  labs(
    title = "Plot10: Beijing Map with District Overlay",  # Correct placement for title to appear
    color = "District"  # Label for the color scale
  )

# Save the map plot with district overlay to a file with a white background
ggsave("results/figure/plot_10_beijing_map_with_district_overlay.png", plot = map_with_points, width = 10, height = 8, bg = "white", dpi = 300)
