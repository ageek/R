#R in action - scatterplot and box plot combined in a graph

par(fig=c(0,.8,0,.8))
plot(mtcars$wt, mtcars$mpg, xlab="miles per gallon", ylab='car weight')
par(fig=c(0,.8, .45, 1), new=T)
boxplot(mtcars$wt, horizontal = T, axes=F)

par(fig=c(0.65, 1, 0, .8), new=T)
boxplot(mtcars$mpg, axes=F)

