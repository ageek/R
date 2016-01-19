#chap 4: Classification
require(ISLR)
names(Smarket)
summary(Smarket)
?Smarket


#Smarket$Direciton is the binary response 
table(Smarket$Direction)


# hence, set color= to binary response Direction
# to show the relation in a better way
# from the plot its clear that
# when value(Today) < "some value"  --> its down
# when value(Today) >= "same above value" -- > its UP
#NB: cant use value of Today for prediction 
pairs(Smarket, col=Smarket$Direction)



glm.fit <- glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, 
               data=Smarket, family=binomial)

summary(glm.fit)

glm.probs <- predict(glm.fit, type="response")
glm.probs[1:5]

glm.pred=ifelse(glm.probs>0.5,"Up", "Down")
head(glm.pred)

attach(Smarket)
table(glm.pred, Direction)

#classification performance
mean(glm.pred==Direction)

#Make predictions

train <- Year<2005
glm.fit <- glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, 
               data=Smarket, subset=train, family=binomial)

table(train)

# check on test data, ie !train
glm.probs <- predict(glm.fit, type="response", 
                     newdata=Smarket[!train,])
glm.pred <- ifelse(glm.probs >0.5, "Up", "Down")

Direction.2005=Smarket$Direction[!train]
table(glm.pred, Direction.2005)

mean(glm.pred==Direction.2005)

glm.fit <- glm(Direction~Lag1+Lag2, 
               data=Smarket, subset=train, family=binomial)

glm.probs <- predict(glm.fit, newdata = Smarket[!train,], 
                     type="response")
glm.pred <- ifelse(glm.probs >0.5, "Up", "Down")
Direction.2005 = Smarket$Direction[!train]

table(glm.pred, Direction.2005)
mean(glm.pred==Direction.2005)


glm.fit <- glm(Direction~Today, 
               data=Smarket, subset=train, family=binomial)

glm.probs <- predict(glm.fit, newdata = Smarket[!train,], 
                     type="response")
glm.pred <- ifelse(glm.probs >0.5, "Up", "Down")
Direction.2005 = Smarket$Direction[!train]

table(glm.pred, Direction.2005)

mean(glm.pred==Direction.2005)

summary(glm.fit)


# Lab session 2:

  
require(ISLR)
require(MASS)

lda.fit <- lda(Direction~Lag1+Lag2, data=Smarket, 
               subset=Year<2005)
lda.fit
plot(lda.fit)

Smarket.2005 <- subset(Smarket, Year==2005)
lda.pred <- predict(lda.fit, Smarket.2005)

lda.pred[1:5]

class(lda.pred)

#Tricky ???
data.frame(lda.pred)[1:5,]

table(lda.pred$class, Smarket.2005$Direction)

mean(lda.pred$class==Smarket.2005$Direction)


# Lab3 - KNN

#for knn
library(class)
?knn

attach(Smarket)

Xlag <-cbind(Lag1,Lag2)

train <- Year<2005

knn.pred <- knn(Xlag[train,], Xlag[!train,], 
                Direction[train], k=3)

table(knn.pred, Direction[!train])
mean(knn.pred==Direction[!train])



