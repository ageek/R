# chap 3-3, 4, 5, 6, 7 - ggplot2
require(ggplot2)
str(mpg)

qplot(displ, hwy, data=mpg)

qplot(displ, hwy, data=mpg, color=drv)

qplot(displ, hwy, data=mpg, color=drv, geom=c("point", "smooth"))

qplot(displ, hwy, data=mpg, geom=c("point", "smooth"))

qplot(hwy, data=mpg)

qplot(hwy, data=mpg, fill=drv)


# facets=row ~ column
# when left is present like a~. --> row wise (horizontal plots)
# when right is present like ~.b --> column wise (vertical plots)
# when both are present like a~b --> rows for each "a" and columsn for each "b"


qplot(displ, hwy, data=mpg, facets=.~drv)

qplot(displ, hwy, data=mpg, facets=drv~.)

qplot(hwy, data=mpg, facets=drv~., binwidth=2)

# number of rows = length(drv)
# number of columns = length(cyl)
# total = drv x cyl = 3 x 4 matrix of scatter plots
qplot(displ, hwy, data=mpg, facets=drv~cyl, binwidth=2)



#load MAACS dataset
load("C:/Ahmed/ML//dataset local copy/maacs.Rda")
str(maacs)

qplot(log(eno), data=maacs)

qplot(log(eno), data=maacs, fill=mopos)

qplot(log(eno), data=maacs, geom=c("density"))

qplot(log(eno), data=maacs, geom=c("density"), color=mopos)

qplot(log(pm25), log(eno), data=maacs)

qplot(log(pm25), log(eno), data=maacs, shape=mopos)


qplot(log(pm25), log(eno), data=maacs, color=mopos)

qplot(log(pm25), log(eno), data=maacs, color=mopos, 
      geom=c("point", "smooth"), method="lm")

#using ggplot and dplyr
require(dplyr)
maacs %>%
  ggplot(mapping = aes(x=log(pm25), y=log(eno), color=mopos)) +
  geom_point() +
  geom_smooth(method="lm", se=T)


#one plot for each mopos type
qplot(log(pm25), log(eno), data=maacs, color=mopos, 
      geom=c("point", "smooth"), method="lm", 
      facets=.~mopos)

#using ggplot
maacs %>%
  ggplot(mapping = aes(x=log(pm25), y=log(eno), color=mopos)) +
  geom_point()+
  geom_smooth(method="lm", se=T) +
  facet_grid(~mopos)

# chap 3-5 examples
maacs %>%
  ggplot(mapping = aes(x=log(pm25), y=log(eno))) +
  geom_point(aes(color=mopos), size=4, alpha=1/2)+
  geom_smooth(method="lm", se=T) +
  facet_grid(~mopos)

maacs %>%
  ggplot(mapping = aes(x=log(pm25), y=log(eno), color=mopos)) +
  geom_point(aes(color=mopos), size=4, alpha=1/2) +
  geom_smooth(method='lm', se=T) +
  labs(title="MAAC Cohort") +
  labs(x=expression("log " * PM[2.5]), y="eNO2")

maacs %>%
  ggplot(mapping = aes(x=log(pm25), y=log(eno), color=mopos)) +
  geom_point(aes(color=mopos), size=4, alpha=1/2) +
  geom_smooth(method='lm', se=T, linetype=3, size=4) +
  theme_bw(base_family = 'Times')
  

# chap 3-7
testdata <- data.frame(x=1:100, y=rnorm(100))
testdata[50,2] <- 100
plot(testdata$x, testdata$y, type="l", ylim=c(-3,3))

g <- ggplot(testdata, aes(x=x, y=y))
g+geom_line()

g+geom_line() + ylim(-3,3)

g+geom_line() + coord_cartesian(ylim = c(-3,3))

