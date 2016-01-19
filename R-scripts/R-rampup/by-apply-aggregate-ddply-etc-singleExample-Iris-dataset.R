# say-it-in-r-with-by-apply-and-friends
#http://www.magesblog.com/2012/01/say-it-in-r-with-by-apply-and-friends.html

require(data.table)
require(dplyr)
require(sqldf)

data(iris)
head(iris)

irisDT <- data.table(iris)
irisDT

irisDT[, lapply(.SD, mean), by=Species]

#raw type - result contains NA under Species column
aggregate(iris, list(iris$Species), mean)

#do it this way: 
iris.x <- subset(iris, select=-Species)
iris.s <- subset(iris, select=Species)

aggregate(iris.x, iris.s, mean)

# OR with formulate iterface
aggregate( . ~ Species, iris, mean)


#raw type, result is NA - not working
by(iris, list(iris$Species), mean, na.rm=T)  

#without do.call result will be a by object
t <- do.call("rbind", as.list(
by(iris, list(iris$Species), function(x) {
    y <- subset(x, select=-Species)
    apply(y, 2, mean)
  })))
class(t)

#without do.call rbind
by(iris, list(iris$Species), function(x) {
  y <- subset(x, select=-Species)
  apply(y, 2, mean)
})


# sqldf
sqldf("select Species, avg(Sepal.Length), avg(Sepal.Width), 
    avg(Petal.Length), avg(Petal.Width) from iris 
    group by Species")

