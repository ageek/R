#line chart, bar chart, scatterplot




# Load ggplot2 graphics package
library(ggplot2)

# Create dummy dataset
df.dummy_data <- data.frame(category_var = c("A","B","C","D","E"),
                            numeric_var = c(5,2,9,4,5)
)

# Plot dataset with ggplot2
ggplot(data=df.dummy_data, aes(x=category_var, y=numeric_var)) +
  geom_bar(stat="identity")