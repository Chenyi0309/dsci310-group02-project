
# Computing correlation matrix for numeric variables
numeric_vars <- select(housing_data, where(is.numeric))
corr_matrix <- cor(numeric_vars, use = "complete.obs")

# Visualize the correlation matrix
corrplot(corr_matrix, method = "color", type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45, 
         col = colorRampPalette(c("#6D9EC1", "white", "#E46726"))(200))

# Box plot for the relationship between the number of living rooms and total price
ggplot(housing_data, aes(x = as.factor(livingRoom), y = totalPrice)) +
  geom_boxplot() +
  labs(title = "Total Price by Number of Living Rooms",
       x = "Number of Living Rooms",
       y = "Total Price") +
  theme_minimal()

# Box plot for the relationship between the number of drawing rooms and total price
ggplot(housing_data, aes(x = as.factor(drawingRoom), y = totalPrice)) +
  geom_boxplot() +
  labs(title = "Total Price by Number of Drawing Rooms",
       x = "Number of Drawing Rooms",
       y = "Total Price") +
  theme_minimal()

# Box plot for the relationship between the number of bathrooms and total price
ggplot(housing_data, aes(x = as.factor(bathRoom), y = totalPrice)) +
  geom_boxplot() +
  labs(title = "Total Price by Number of Bathrooms",
       x = "Number of Bathrooms",
       y = "Total Price") +
  theme_minimal()
