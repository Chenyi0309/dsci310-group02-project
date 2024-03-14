
# Linear regression model: totalPrice ~ .
model <- lm(totalPrice ~ ., data = housing_data)

# Summary of the regression model
summary(model)

# Predicting totalPrice using the model
housing_data$predictedPrice <- predict(model, housing_data)

# Visualization of Actual vs. Predicted Prices
ggplot(housing_data, aes(x = totalPrice, y = predictedPrice)) +
  geom_point(alpha = 0.5) +
  geom_abline(color = "red") +
  labs(title = "Actual vs. Predicted Total Price",
       x = "Actual Total Price",
       y = "Predicted Total Price") +
  theme_minimal()

