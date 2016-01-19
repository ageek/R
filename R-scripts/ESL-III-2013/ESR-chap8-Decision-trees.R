# Decision trees - ESR-chap8-lab1

require(ISLR)
require(tree)
attach(Carseats)

hist(Sales, breaks = 100)

High <- ifelse(Sales<=8, "No", "Yes")
Carseats <- data.frame(Carseats, High)
str(Carseats)

#Exclude Sales, as High is created from Sales 
tree.carseats <- tree(High~.-Sales, data=Carseats)
summary(tree.carseats)
names(Carseats)
 
plot(tree.carseats)
text(tree.carseats, pretty = 0)

#print the full tree
tree.carseats

set.seed(1011)
train <- sample(1:nrow(Carseats), 250)
tree.carseats <- tree(High~.-Sales, data=Carseats, 
                       subset=train)

plot(tree.carseats)
text(tree.carseats, pretty=0)

tree.carseats

tree.predict <- predict(tree.carseats, Carseats[-train,], 
                        type="class")

table(tree.predict)
with(Carseats[-train,], table(tree.predict, High))

#accuracy
(73+37)/(73+37+23+17)

#OR - shortuct , this way-->
#mean adds up the diagonal and divides by total
with(Carseats[-train,], mean(tree.predict==High))


#Tree pruning using CV
cv.carseats <- cv.tree(tree.carseats, FUN=prune.misclass)
cv.carseats
plot(cv.carseats)


#now prune the tree, using "best" selected from last cv
prune.carseats <- prune.misclass(tree.carseats, best=13)

plot(prune.carseats)
text(prune.carseats, pretty=0)

#evaluate on test dataset
tree.pred <- predict(prune.carseats, Carseats[-train,], 
                     type="class")
with(Carseats[-train, ], table(tree.pred, High))
(72+32)/150

with(Carseats[-train,], mean(tree.pred==High))


# Lab 2 - RandomForest

require(randomForest)
require(MASS)

set.seed(101)
dim(Boston)

train <- sample(1:nrow(Boston), 300)
?Boston

rf.boston <- randomForest(medv~., data=Boston, subset = train)

rf.boston

oob.err <- double(13)
test.err <- double(13)

for(m in 1:13) {
  fit <- randomForest(medv~., data=Boston, subset=train, mtry=m, ntree = 400)
  oob.err[m] <- fit$mse[400]
  pred <- predict(fit, Boston[-train, ])
  test.err[m] <-with(Boston[-train, ], mean((medv-pred)^2))
  cat(m, " ")
}

matplot(1:13, cbind(test.err, oob.err), pch=19, col=c("red","blue"),
        type="b", ylab="Mean Sq Error")
legend("topright", legend=c("OOB", "Test"), pch=19, col=c("red", "blue"))


# Boosting
require(gbm)
#gausian -> linear model
#interaction depth = no of splits per tree
boost.boston <- gbm(medv~., data=Boston[train,] ,
                    n.trees=10000, distribution="gaussian", 
                    shrinkage=.01, interaction.depth=4)

boost.boston
summary(boost.boston)

plot(boost.boston, i="lstat")
plot(boost.boston, i="rm")


#tuning gbm
ntrees <- seq(from=100, to=10000, by=100)
predmat <- predict(boost.boston, newdata=Boston[-train,], 
                   n.trees=ntrees)
dim(predmat)

berr <- with(Boston[-train,], apply((predmat-medv)^2, 2, mean))

plot(ntrees, berr, pch=19, ylab="Mean Sq Error", 
     xlab="No of Trees", main="Boosting test error")

#check with the min of RForest error
abline(h=min(test.err), col="red")
