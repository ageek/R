# ESL - chap 6 : Linear Model Selection and Regularization

require(ISLR)
require(MASS)
summary(Hitters)

Hitters <- na.omit(Hitters)
summary(Hitters)

with(Hitters, sum(is.na(Salary)))

#Best subset regression

str(Hitters)
dim(Hitters)
library(leaps)

regfit.full <- regsubsets(Salary~., data=Hitters)
summary(regfit.full)

regfit.full <- regsubsets(Salary~., data=Hitters, nvmax = 20)
reg.summary <- summary(regfit.full)
        
names(summary(regfit.full))        

plot(reg.summary$cp, xlab="No of variables",ylab="cp")
which.min(reg.summary$cp)
points(10, reg.summary$cp[10], pch=20, col="red")

plot(regfit.full, scale="Cp")

coef(regfit.full, 10)


#Forward stepwise selection


regfit.fwd <- regsubsets(Salary~., data=Hitters, nvmax = 19, method="forward")
summary(regfit.fwd)

plot(regfit.fwd, scale="Cp")

plot(regfit.fwd, scale="bic")

dim(Hitters)
set.seed(1)
train <- sample(seq(263), 180, replace = F)
train

regfit.fwd <- regsubsets(Salary~., data=Hitters[train, ], 
                         nvmax=20, method="forward")

summary(regfit.fwd)

val.errors <- rep(NA,19)
x.test <- model.matrix(Salary~., data=Hitters[-train, ])

for (i in 1:19) {
  coefi = coef(regfit.fwd, id=i)
  pred = x.test[,names(coefi)]%*%coefi
  val.errors[i] =mean((Hitters$Salary[-train]-pred)^2)  
}


#Model selection using CV

set.seet(1)
folds <- sample(rep(1:10, length=nrow(Hitters)))
folds
table(folds)

cv.error=matrix(NA,10,19)
for(k in 1:10) {
  best.fit = regsubsets(Salary~., data=Hitters[folds!=k], 
                        nvmax=19, method="forward")
  for (i in 1:19) {
    
  }
}