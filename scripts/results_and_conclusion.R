# Linear regression model: totalPrice ~ .
model <- lm(totalPrice ~ . - constructionTime - buildingType, data = beijing_house_price)
# Summary of the regression model
model_summary <- summary(model)
# Capturing the summary output and writing it into a text file
capture.output(model_summary, file = "results/model_summary.txt")
# Predicting totalPrice using the model
beijing_house_price$predictedPrice <- predict(model, newdata = beijing_house_price)
# Visualization of Actual vs. Predicted Prices
p <- ggplot(beijing_house_price, aes(x = totalPrice, y = predictedPrice)) +
  geom_point(alpha = 0.5) +
  geom_abline(color = "red") +
  labs(title = "Actual vs. Predicted Total Price",
       x = "Actual Total Price",
       y = "Predicted Total Price") +
  theme_minimal()
# Save the plot
ggsave("results/price_prediction_plot.png", plot = p, width = 10, height = 8, bg = "white")
