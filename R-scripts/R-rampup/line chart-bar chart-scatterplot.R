#line chart, bar chart, scatterplot

# sample line chart
# Create dummy dataset
df.dummy_data <- data.frame(
  dummy_metric <- cumsum(1:20),
  date = seq.Date(as.Date("1980-01-01"), by="1 year", length.out=20)
)

# Plot the data using ggplot2 package
ggplot(data=df.dummy_data, aes(x=date,y=dummy_metric)) +
  geom_line() +
  geom_point()



# Load ggplot2 graphics package
library(ggplot2)

# Create dummy dataset
df.dummy_data <- data.frame(category_var = c("A","B","C","D","E"),
                            numeric_var = c(5,2,9,4,5)
)

# Plot dataset with ggplot2
ggplot(data=df.dummy_data, aes(x=category_var, y=numeric_var)) +
  geom_bar(stat="identity")

#same thing usin base barplot
barplot(df.dummy_data$numeric_var, data = df.dummy_data)


# scatterplot
# Load ggplot2 package for graphics/plotting
library(ggplot2)

# Create dummy dataset
df.test_data <- data.frame(x_var = 1:50 + rnorm(50,sd=15),
                           y_var = 1:50 + rnorm(50,sd=2)                          
)

# Plot data using ggplot2
ggplot(data=df.test_data, aes(x=x_var, y=y_var)) +
  geom_point()


# scatterplot - bubble chart

library(ggplot2)    # load ggplot2 plotting package

# set 'seed' for random number generation 
set.seed(53)        

# CREATE DATA FRAME
#  1. create 'x_var' as 15 random, normally distributed numbers (using rnorm)
#  2. create 'y_var' as 15 random, normally distributed numbers (using rnorm)
#  3. create 'size_var' as a random number between 1 and 10
#  4. combine these variables into a single data frame using the data.frame() function
x_var <- rnorm( n = 15, mean = 5, sd = 2)
y_var <- x_var + rnorm(n = 15, mean = 5, sd =4)
size_var <- runif(15, 1,10)

df.test_data <- data.frame(x_var, y_var, size_var)

# PLOT THE DATA USING GGPLOT2
ggplot(data=df.test_data, aes(x=x_var, y=y_var)) +
  geom_point(aes(size=size_var)) +
  scale_size_continuous(range = c(2,15)) 

  theme(legend.position = "none")

