# Aggregate examples - formula interface etc
# http://www.dummies.com/how-to/content/how-to-use-the-formula-interface-in-r.html
require(dplyr)
require(sqldf)
require(data.table)
require(ggplot2)

diamondsDT <- data.table(diamonds)

aggregate(price ~ clarity, data=diamonds, mean)

# OR
aggregate(diamonds$price, by=list(diamonds$clarity), mean)

#using bare-bones by: result is by object
by(diamonds$price, list(diamonds$clarity), mean)

#using do.call rbind, output is a matrix
do.call("rbind", as.list( 
  by(diamonds$price, list(diamonds$clarity), mean)
))

#using data.table
diamondsDT[, lapply(.SD, mean), by=clarity, 
           .SDcols="price"]

#using dplyr
diamonds %>%
  select(clarity, price) %>%
  group_by(clarity) %>%
  summarize(Price=mean(price))

#http://www.inside-r.org/r-doc/stats/aggregate
# aggregate(weight ~ feed, data = chickwts, mean)
aggregate(breaks ~ wool + tension, data = warpbreaks, mean)
aggregate(cbind(Ozone, Temp) ~ Month, data = airquality, mean)
aggregate(cbind(ncases, ncontrols) ~ alcgp + tobgp, data = esoph, sum)

aggregate(. ~ Species, data = iris, mean)
aggregate(len ~ ., data = ToothGrowth, mean)


## Often followed by xtabs():
ag <- aggregate(len ~ ., data = ToothGrowth, mean)
xtabs(len ~ ., data = ag)

#time series
## Compute the average annual approval ratings for American presidents.
aggregate(presidents, nfrequency = 1, FUN = mean)
## Give the summer less weight.
aggregate(presidents, nfrequency = 1,
          FUN = weighted.mean, w = c(1, 1, 0.5, 1))


