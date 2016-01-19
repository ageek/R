#ESR-chap6-glmnet
require(ISLR)
require(glmnet)

Hitters <- na.omit(Hitters)
summary(Hitters)

with(Hitters, sum(is.na(Salary)))

x=model.matrix(Salary~., data=Hitters)
y=Hitters$Salary

#alpha=0 means Ridge /L2 norm
#alpha=1, Lasso / L1 norm
fit.ridge=glmnet(x,y,alpha=0)
plot(fit.ridge, xvar="lambda", label=T)
cv.ridge=cv.glmnet(x,y, alpha=0)

plot(cv.ridge)


fit.lasso=glmnet(x,y,alpha=1)
plot(fit.lasso, xvar="lambda", label=T)
cv.lasso=cv.glmnet(x,y, alpha=1)
plot(cv.lasso)

#%age of dev explained - i.e %age varaince explained
# similar to R^2
plot(fit.lasso, xvar="dev", label=T)

coef(cv.lasso)


#select the lasso model
set.seed(1)
train <- sample(seq(263), 180, replace = F)
train

lasso.tr =glmnet(x[train, ], y[train])
lasso.tr

pred=predict(lasso.tr, x[-train, ])
dim(pred)

rmse=sqrt(apply((y[-train]-pred)^2, 2, mean))
dim(rmse)
rmse

plot(log(lasso.tr$lambda), rmse, type="b", xlab="Log(lambda)")
lam.best=lasso.tr$lambda[order(rmse)][1]
lam.best

coef(lasso.tr, s=lam.best)
