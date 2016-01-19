# ESR- chap 9 Support Vector Machines
# Lab 1
#Standford Univ room no where the code for this package was developed
require(e1071)

set.seed(10111)
x <- matrix(rnorm(40), 20, 2)
y <- rep(c(-1,1), c(10,10))

#change the mean frm 0 to 1 for, last 10 (given by y==1) rows in x
x[y==1,] <- x[y==1,]+1

#tricky, for color selection
plot(x, col=y+3, pch=19)

data <- data.frame(x, y=as.factor(y))

#for linear kernel, no gamma is required
# for no scaling of data, scale=F
svmfit <- svm(y~., data=data, kernel = "linear", 
              cost=10, scale=F)
svmfit


plot(svmfit, data)
 

#function for plotting svmfit
make.grid <- function(x, n=75) {
  grange=apply(x,2,range)
  x1=seq(from=grange[1,1], to=grange[2,1], length=n)
  x2=seq(from=grange[1,2], to=grange[2,2], length=n)
  expand.grid(X1=x1, X2=x2)
}

range(x[,1])
range(x[,2])
xgrid <- make.grid(x)

ygrid <- predict(svmfit, xgrid)

#this creats a colored mesh to show the region of classifier
plot(xgrid, col=c("red", "blue")[as.numeric(ygrid)], 
     pch=20, cex=.7)
#now plot the points
points(x, col=y+3, pch=19)

#now plot the support vectors
points(x[svmfit$index,], pch=5, cex=2)



beta <- drop(svmfit$coefs)%*%x[svmfit$index,]

beta0 <- svmfit$rho

plot(xgrid, col=c("red","blue")[as.numeric(ygrid)], 
     pch=20, cex=.2)

points(x, col=y+3, pch=19)
points(x[svmfit$index, ], pch=5, cex=2)

abline(beta0/beta[2], -beta[1]/beta[2])

#upper margin
abline((beta0-1)/beta[2], -beta[1]/beta[2], lty=2)
#lower margin
abline((beta0+1)/beta[2], -beta[1]/beta[2], lty=2)

# Lab 2
#not working
load(url("http://www-stat.stanford.edu/~tibs/ElemSatLearn/datasets/ESL.mixture.rda"))
#install the package ElemStatLearn
#require(ElemStatLearn)
load("C:/Ahmed/ML/dataset local copy/ESL.mixture.rda")
names(ESL.mixture)
rm(x,y)

attach(ESL.mixture)
ls()

plot(x, col=y+1)

data <- data.frame(y=factor(y), x)
fit <- svm(factor(y)~., data=data, kernel="radial", 
           cost=5, scale=F)
fit
xgrid <- expand.grid(X1=px1, X2=px2)
dim(xgrid)
ygrid <- predict(fit, xgrid)
plot(xgrid, col=as.numeric(ygrid), pch=20, cex=.2)
points(x, col=y+1, pch=19)


func <- predict(fit, xgrid, decision.values = T)
func <- attributes(func)$decision
xgrid <- expand.grid(X1=px1, X2=px2)
dim(xgrid)
ygrid <- predict(fit, xgrid)
plot(xgrid, col=as.numeric(ygrid), pch=20, cex=.2)
points(x, col=y+1, pch=19)

contour(px1, px2, matrix(func, 69,99), level=0, add=T)
#plot true decsion boundary; the Bayes decision boundary
contour(px1, px2, matrix(prob, 69,99), level=.5, add=T, col="blue", lwd=2)
