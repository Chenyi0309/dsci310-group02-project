
# Computing correlation matrix for numeric variables
numeric_vars <- select(housing_data, where(is.numeric))
corr_matrix <- cor(numeric_vars, use = "complete.obs")

# Visualize the correlation matrix
corrplot(corr_matrix, method = "color", type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45, 
         col = colorRampPalette(c("#6D9EC1", "white", "#E46726"))(200))

