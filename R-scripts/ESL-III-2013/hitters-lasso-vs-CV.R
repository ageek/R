require(glmnet)
require(ISLR)
data(Hitters)
hitters <- na.omit(Hitters)
dim(hitters)
[1] 263  20

split <- sample(1:nrow(hitters), .7 * nrow(hitters))
length(split)
[1] 184
x = model.matrix(Salary~.-1, data = hitters)
y = hitters$Salary
dim(x)
[1] 263  20
> head(x)

lasso1 <- glmnet(x,y, alpha = 1)
plot(lasso1)
plot(lasso1, xlab='lambda', label = )
plot(lasso1, xvar='lambda', label = )
plot(lasso1)
plot(lasso1, xvar='lambda', label = T)
cv.lasso1 <- cv.glmnet(x,y,alpha=1)
plot(cv.lasso1)
cv.lasso1$lambda.min
[1] 2.674375
> cv.lasso1$lambda.1se
[1] 69.40069
> log(cv.lasso1$lambda.1se)
[1] 4.239897
> log(cv.lasso1$lambda.min)
[1] 0.9837159

> lasso2 <- glmnet(x[train,], y[train], alpha=1)
> plot(lasso2, xvar='lambda', label=T)
> cv.lasso2 = cv.glmnet(x[train,], y[train], alpha=1)
> plot(cv.lasso2)
> cv.lasso2$lambda.min
[1] 12.31897
> log(cv.lasso2$lambda.min)
[1] 2.511141
> log(cv.lasso2$lambda.1se)
[1] 4.371815
> coef(cv.lasso2)

> preds <- predict(cv.lasso2, x[-train,])
> dim(preds)
[1] 83  1
> dim(pred)
[1] 83 73
> rmse <- sqrt(mean(y[-train]-preds)^2)
> rmse
[1] 32.50169
> head(cbind(y[-train], preds))
1
-Alan Ashby      475 501.5528
-Andre Dawson    500 751.1338
-Al Newman        70 208.4009
-Argenis Salazar 100 251.4021
-Bill Almon      240 381.6422
-Bruce Bochy     135 222.5918
> lasso.trs <- glmnet(x[train,], y[train], alpha=1)


> dim(lasso.trs)
NULL
> length(lasso.trs)
[1] 12
> preds.trs <- predict(lasso.trs, x[-train,])
> dim(preds.trs)
[1] 83 73
> rmse <- sqrt(apply((y[-train] - preds.trs)^2, 2, mean))
> plot(log(lasso.trs$lambda), rmse, xlab='log(lambda)', ylab='rmse', type='b')
> lambda.best = lasso.trs$lambda[order(rmse)[1]]
> lambda.best
[1] 1.916433
> order(rmse)[1]
[1] 53
> log(lambda.best)
[1] 0.6504657
> head(rmse)
s0       s1       s2       s3       s4       s5 
480.7073 469.9350 458.3244 447.4555 438.3533 430.7726 
> head(lasso.trs$lambda)
[1] 241.8264 220.3432 200.7686 182.9328 166.6816 151.8740
> tail(lasso.trs$lambda)
[1] 0.4747151 0.4325427 0.3941168 0.3591046 0.3272027 0.2981349
> tail(rmse)
s67      s68      s69      s70      s71      s72 
385.0736 385.0441 385.1671 385.1973 385.6959 385.7221 
> which.min(rmse)
s52 
53 
> lasso.trs$lambda[53]
[1] 1.916433
> lasso.trs$lambda[which.min(rmse)]
[1] 1.916433




