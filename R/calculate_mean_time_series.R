#' Create Time Series Plot for Monthly Traded House Prices
#'
#' This function generates a time series plot, showing the average monthly traded house prices.
#' The size of the points in the plot reflects the number of houses traded each month.
#'
#' @param monthly_price_overview A data frame that contains columns monthlyTradeTS (time series),
#' mean_price (average price), and count (number of transactions).
#' @return A ggplot object representing the time series plot.
#' @examples
#' time_series_plot(monthly_price_overview)
#' @export
create_time_series_plot <- function(monthly_price_overview) {
  if ("monthlyTradeTS" %in% names(monthly_price_overview) & 
      "mean_price" %in% names(monthly_price_overview) &
      "count" %in% names(monthly_price_overview)) {
    time_series_plot <- ggplot(monthly_price_overview, aes(x = monthlyTradeTS, y = mean_price)) + 
      geom_line(size = 2, alpha = .25, color = 'steelblue') +
      geom_point(aes(size = count), alpha = .75, color = 'steelblue') +
      theme_minimal(base_size = 14) +
      labs(
        title = 'Monthly Average Residential Sale Prices (time series plot)',
        subtitle = 'Point size indicates monthly transaction volume',
        x = "Time", 
        y = "Average Price in (CNY)" 
      ) +
      scale_size(range = c(1, 10))
    
    return(time_series_plot)
  } else {
    stop("Input data frame is missing one or more required columns: 'monthlyTradeTS', 'mean_price', 'count'.")
  }
}

