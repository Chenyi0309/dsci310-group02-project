#' Train a linear regression model
#'
#' This function trains a linear regression model using the specified formula and dataset.
#'
#' @param formula The formula for the model.
#' @param data The dataset to train the model on.
#' @return The trained model object.
#' @export
#'
#' @examples
#' model <- train_model(totalPrice ~ . - constructionTime - buildingType, beijing_house_price)
train_model <- function(formula, data) {
  model <- lm(formula, data = data)
  return(model)
}

#' Make predictions using a linear regression model
#'
#' This function makes predictions on new data using the provided model.
#'
#' @param model The linear regression model to use for predictions.
#' @param newdata The new data to predict on.
#' @return Numeric vector of predictions.
#' @export
#'
#' @examples
#' predictions <- predict_model(model, new_data)
predict_model <- function(model, newdata) {
  predicted_prices <- predict(model, newdata = newdata)
  return(predicted_prices)
}
