# ggplot2-book-chap4

#Groups in ggplot
require(ggplot2)
require(nlme)
data(Oxboys)
boys <- Oxboys
str(boys)

p <- ggplot(Oxboys, aes(age, height, group = Subject)) +
  geom_line()

#incorrect grouping, by 
# missing the group parameter OR
# set all points to just one group, i.e. group=1
p0 <- ggplot(boys, aes(x=age, y=height, group=1)) +
  geom_line()

# fitting a linear model for all subjects data, so group=1 
# setting group=Subject, will create one model for each student/subject
# not what we want
p + geom_smooth(aes(group=1), method='lm', size=2, Se=F)

# adding group=Occasion on box is option, as its already grouped on X-axis
# and its a factor variable
boysbox <- ggplot(Oxboys, aes(Occasion, height)) + 
  geom_boxplot(aes(group=Occasion))
boysbox
# geom_line should use group=Subject and
# geom_box should use group=Occasion
boysbox + geom_line(aes(group = 1), colour = "#3366FF")

# OR
ggplot(Oxboys, aes(Occasion, height)) + 
  geom_boxplot(aes(group=Occasion)) +
  #to override default group, we must set group=Subject for geom_line
  geom_line(aes(group = Subject), colour = "#3366FF")


#
require(dplyr)
diamonds %>%
  ggplot(aes(carat))+
  geom_histogram(aes(y=..density..), binwidth=.1)

#or the old school way
plot(density(diamonds$carat))

