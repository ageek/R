#Air pollution Study
# EDA - chap 2-3

require(ggplot2)


# when you want to provide colClasses, to make read.csv faster
#check type
#initial <- read.table("C:/Ahmed/ML/dataset local copy/avgpm25.csv", nrows = 10, fill=T)
#classes <- sapply(initial[1,], class)

poll <- read.csv("C:/Ahmed/ML/dataset local copy/avgpm25.csv", 
                      colClasses = c("numeric", "character", "factor",
                                     "numeric", "numeric"))


> summary(poll$pm25)
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
3.383   8.549  10.050   9.836  11.360  18.440 
> hist(poll$pm25)
> hist(poll$pm25, breaks = 100)
> boxplot(poll$pm25)
> boxplot(poll$pm25, col="blue")
> hist(poll$pm25, col="green")
> hist(poll$pm25, col="green", breaks = 100)
> hist(poll$pm25, col="green", breaks = 100)
> rug(poll$pm25)


# using ggplot
poll %>%
  ggplot(mapping = aes(x=pm25)) + 
  geom_histogram(color='green', binwidth=.2) +
  geom_rug()



boxplot(poll$pm25, col='blue')
> abline(h=12)
> abline(h=12, col='red')
> abline(h=12, col='red', lwd=2)

# Tricky, boxplot for one variable only, 
# x needs to be set to some value (say 0 or 1)
poll %>%
  ggplot(aes(x=0, y=pm25)) +
  geom_boxplot(color='blue')


hist(poll$pm25, col='green')
abline(v=12, lwd=2)
abline(v=median(poll$pm25), col='magenta', lwd=3)
rug(poll$pm25)


barplot(table(poll$region), col='wheat', main="Number of counties in each region")

poll %>%
  ggplot(mapping = aes(x=factor(region))) +
  geom_bar(color='wheat')


# chap 2-4

boxplot(poll$pm25 ~poll$region, col='red')

poll %>%
  ggplot(mapping = aes(x=factor(region), y=pm25)) +
  geom_boxplot(stat='boxplot', 
               position = 'identity', 
               notch=F, outlier.color='green', outlier.size=4)


# mtcars example -from help page
p <- ggplot(mtcars, aes(factor(cyl), mpg))

p + geom_boxplot()
qplot(factor(cyl), mpg, data = mtcars, geom = "boxplot")

p + geom_boxplot() + geom_jitter()
p + geom_boxplot() + coord_flip()
qplot(factor(cyl), mpg, data = mtcars, geom = "boxplot") +
  coord_flip()

p + geom_boxplot(notch = TRUE)
p + geom_boxplot(notch = TRUE, notchwidth = .3)

p + geom_boxplot(outlier.colour = "green", outlier.size = 3)


# back to chap2-4 
par(mfrow=c(2, 1), mar=c(4,4,2,1))
hist(subset(poll, region=="east")$pm25, col='green')
hist(subset(poll, region=='west')$pm25, col='green')


#reset par mfrow
par(mfrow=c(1,1))
with(poll, plot(poll$latitude, poll$pm25))
abline(h=12, lwd=2, lty=2, col='red')
 
with(poll, plot(poll$latitude, poll$pm25, col=region))
abline(h=12, lwd=2, lty=2, col='red')


par(mfrow=c(1, 2), mar=c(5,4,2,1))
with(subset(poll, region=="west"), plot(latitude, pm25, main='West', col='red'))
with(subset(poll, region=="east"), plot(latitude, pm25, main='East', col='green'))



#chap 2-5 : Base plotting system
require(lattice)
state <- data.frame(state.x77, region=state.region)
str(state)
xyplot(Life.Exp ~ Income |region, data=state, layout=c(4, 1))

# in ggplot
state %>%
  ggplot(mapping = aes(x=Income, y=Life.Exp)) +
  geom_point(pch=15) +
  facet_grid(~region)

# chap 2-6: Base plotting system 2
par(mfrow=c(1,1))
require(datasets)
with(airquality, plot(Wind, Ozone))
title(main="Ozone in NY city")

with(airquality, plot(Wind, Ozone, main="NY city Ozone and Wind", type="n"))
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month!=5), points(Wind, Ozone, col="red"))
legend("topright", pch=1, col=c("blue", "red"), 
       legend=c("May", "Other months"))

#par(mfrow=c(1,1))
with(airquality, plot(Wind, Ozone, main="NY city wind and ozone", 
                      pch=20))
model <- lm(Ozone ~ Wind, data=airquality)
abline(model, lwd=2)


# using ggplot
airquality %>%
  ggplot(mapping = aes(x=Wind, y=Ozone)) +
  geom_point(pch=20, size=3) +
  geom_smooth(method="lm", se=T, lwd=1) +
  #theme_bw() +
  ggtitle("NY city Wind and OZone")
  
  #+coord_flip()  # swap x and y co-ords


par(mfrow=c(1,3), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(airquality, {
  plot(Wind, Ozone, main="NY city Wind and Ozone", col='red') 
  plot(Solar.R, Ozone, main="NY city Radiation and Ozone", col='blue')
  plot(Temp, Ozone, main="Temperature and OZone", col='magenta')
  mtext("Ozone and weather  in NY City", outer=T)
})

# saving plots to a pdf file
> pdf(file="myfile.pdf")
> with(airquality, plot(Wind, Ozone, main="NY cit wind and ozone", col='red'))
> dev.off()


pdf(file="nycity-wind-ozone.pdf")
airquality %>%
  ggplot(mapping = aes(x=Wind, y=Ozone)) +
  geom_point(pch=20, size=3) +
  geom_smooth(method="lm", se=T, lwd=1) +
  #theme_bw() +
  ggtitle("NY city Wind and OZone")
dev.off()

#copy plot from screen device to file

par(mfrow=c(1,1))
with(airquality, plot(Wind, Ozone, main="NY city wind and ozone", col='red'))
dev.copy(png, file="ny city weather.png")
dev.off()

#chap 3-1: Lattice
require(lattice)
require(datasets)

xyplot(Ozone ~ Wind , data=airquality)

airq <- transform(airquality, Month=factor(Month))
str(airq)
xyplot(Ozone ~Wind|Month, data=airq, layout=c(5,1))

set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each=50)
y <- x+f -f *x + rnorm(100, sd=0.5)
f <- factor(f, labels=c("Group1", "Group2"))
xyplot(y ~x|f, layout=c(2, 1))

xyplot(y ~x |f, panel=function(x, y, ...) {
    panel.xyplot(x, y, ...)
    panel.lmline(x, y, col=2)
  })


#using ggplot
# create a df with all 3, else ggplot wont work 
# and throw error : 
#   At least one layer must contain all variables used for facetting
t <- data.frame(x, y, f)
dim(t)
ggplot(t, mapping = aes(x=x, y=y)) +
  geom_point(pch=19, color='blue') +
  geom_smooth(method="lm", lwd=1, color='red') +
  facet_grid(.~f)


