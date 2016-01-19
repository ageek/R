# dplyr-intro-data-manipulation-with-r

library(dplyr)
library(ggplot2)

head(diamonds)

#--------
# FILTER
#--------

df.diamonds_ideal <- filter(diamonds, cut=="Ideal")

> boxplot(price~cut, data=diamonds)
> boxplot(carat~cut, data=diamonds)
> boxplot(depth~cut, data=diamonds)
> coplot(price~carat|cut, data = diamonds)
> tapply(diamonds$price, diamonds$cut, summary)

> tapply(diamonds$price, diamonds$cut, median)
Fair      Good Very Good   Premium     Ideal 
3282.0    3050.5    2648.0    3185.0    1810.0 
> tapply(diamonds$price, diamonds$cut, mean)
Fair      Good Very Good   Premium     Ideal 
4358.758  3928.864  3981.760  4584.258  3457.542 
> tapply(diamonds$price, diamonds$cut, length)
Fair      Good Very Good   Premium     Ideal 
1610      4906     12082     13791     21551 
> 
  
  
  #-----------------------------------------
# SELECT 
# - select specific columns from your data
#-----------------------------------------

# Examine the data first
head(df.diamonds_ideal)
#  carat    cut     color clarity depth table price    x      y    z
#  0.23     Ideal     E     SI2   61.5    55   326    3.95  3.98  2.43
#  0.23     Ideal     J     VS1   62.8    56   340    3.93  3.90  2.46
#  0.31     Ideal     J     SI2   62.2    54   344    4.35  4.37  2.71
#  0.30     Ideal     I     SI2   62.0    54   348    4.31  4.34  2.68
#  0.33     Ideal     I     SI2   61.8    55   403    4.49  4.51  2.78
#  0.33     Ideal     I     SI2   61.2    56   403    4.49  4.50  2.75

df.diamonds_ideal <- select(df.diamonds_ideal, carat, cut, color, price, clarity)

head(df.diamonds_ideal)
# carat   cut     color price clarity
# 0.23    Ideal     E   326     SI2
# 0.23    Ideal     J   340     VS1
# 0.31    Ideal     J   344     SI2
# 0.30    Ideal     I   348     SI2
# 0.33    Ideal     I   403     SI2
# 0.33    Ideal     I   403     SI2

#--------------------------------------
# MUTATE: 
# - Add variables to your dataset
#--------------------------------------
df.diamonds_ideal <- mutate(df.diamonds_ideal, price_per_carat = price/carat)

head(df.diamonds_ideal)
# carat   cut     color price clarity   price_per_carat
# 0.23    Ideal     E   326     SI2        1417.391
# 0.23    Ideal     J   340     VS1        1478.261
# 0.31    Ideal     J   344     SI2        1109.677
# 0.30    Ideal     I   348     SI2        1160.000
# 0.33    Ideal     I   403     SI2        1221.212
# 0.33    Ideal     I   403     SI2        1221.212

#------------------------
# ARRANGE: sort your data
#------------------------

# create simple data frame
#  containing disordered numeric variable
df.disordered_data <- data.frame(num_var = c(2,3,5,1,4))

head(df.disordered_data)

# these are out of order

# 2
# 3
# 5
# 1
# 4


# now we'll order them with arrange()
arrange(df.disordered_data, num_var)

# 1
# 2
# 3
# 4
# 5


# we can also put them in descending order
arrange(df.disordered_data, desc(num_var))

# 5
# 4
# 3
# 2
# 1

#-------------------------------
# SUMMARIZE: 
#  aggregate your data
#-------------------------------

summarize(df.diamonds_ideal, avg_price = mean(price, na.rm = TRUE) )

#   avg_price
#   3457.542

# Subset the diamonds dataset to 'Ideal' cut diamonds
# THEN, keep (select) the variables: carat, cut, color, price, clarity
# THEN, add new variable called price_per_carat (mutate)

df.diamonds_ideal_chained <- diamonds %>%
  filter(cut=="Ideal") %>%
  select(carat, cut, color, price, clarity) %>%
  mutate(price_per_carat = price/carat)

head(df.diamonds_ideal_chained)
# carat   cut     color price clarity   price_per_carat
# 0.23    Ideal     E   326     SI2        1417.391
# 0.23    Ideal     J   340     VS1        1478.261
# 0.31    Ideal     J   344     SI2        1109.677
# 0.30    Ideal     I   348     SI2        1160.000
# 0.33    Ideal     I   403     SI2        1221.212
# 0.33    Ideal     I   403     SI2        1221.212

# dplyr + ggplot
# PRICE DISTRIBUTION, Ideal-cut diamonds
diamonds %>%                                        # Start with the 'diamonds' dataset
  filter(cut == "Ideal") %>%                        # Then, filter down to rows where cut == Ideal
  ggplot(aes(x=color,y=price)) +                     # Then, plot using ggplot
  geom_boxplot()  

diamonds %>%                                        # Start with the 'diamonds' dataset
  filter(cut == "Ideal") %>%                        # Then, filter down to rows where cut == Ideal
  ggplot(aes(x=clarity,y=price)) +                     # Then, plot using ggplot
  geom_boxplot()

# dplyr + ggplot
# HISTOGRAM of price, ideal cut diamonds
diamonds %>%                                        # Start with the 'diamonds' dataset
  filter(cut == "Ideal") %>%                        # Then, filter down to rows where cut == Ideal
  ggplot(aes(x=price)) +                            # Then, plot using ggplot
  geom_histogram() +                              # and plot histograms
  facet_wrap(~ color)                             # in a 'small multiple' plot, broken out by 'color'

# dplyr + ggplot
# HISTOGRAM of price, ideal cut diamonds
diamonds %>%                                        # Start with the 'diamonds' dataset
  filter(cut == "Ideal") %>%                        # Then, filter down to rows where cut == Ideal
  ggplot(aes(x=price, fill=clarity)) +                # Then, plot using ggplot, divide each bar by clarity
  geom_histogram() +                              # and plot histograms
  facet_wrap(~color)                              # in a 'small multiple' plot, broken out by 'color'

#line chart 
diamonds %>%
  filter(cut=='Ideal') %>%
  ggplot(aes(x=price, y=carat)) +
  geom_line() +
  
  
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
