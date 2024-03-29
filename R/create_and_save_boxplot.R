# Prabhjot Singh (2024)
library(ggplot2)

#Creating a function for creating and saving the boxplots

# data -> A dataframe containing the data to plot.
# x_var -> The name of the column in `data` to use for the x-axis (categorical).
# y_var -> The name of the column in `data` to use for the y-axis (numeric).
# fill_var (Optional) -> the name of the column in `data` to use for fill color. Defaults to NULL.
# plot_title -> The title of the plot.
# y_label -> The label for the y-axis.
# file_path -> The path, including filename, where the plot should be saved.
# plot_width -> Width of the saved plot, in inches. Defaults to 10.
# plot_height -> Height of the saved plot, in inches. Defaults to 6.
# theme -> The ggplot2 theme to use for the plot. Defaults to theme_classic().

create_boxplot <- function(data, x_var, y_var, fill_var = NULL, plot_title, y_label,
                           file_path, plot_width = 10, plot_height = 6, theme = theme_classic()) {
  
  plot <- ggplot(data, aes_string(x = x_var, y = y_var, fill = fill_var)) + 
    geom_boxplot(alpha = 0.5) +
    labs(title = plot_title, y = y_label) +
    theme
  
  ggsave(file_path, plot = plot, device = "png", width = plot_width, height = plot_height)
}