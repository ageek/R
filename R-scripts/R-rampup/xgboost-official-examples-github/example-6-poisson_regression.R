#example-6-poisson_regression.R
data(mtcars)
head(mtcars)
names(mtcars)

bst = xgboost(data=as.matrix(mtcars[,-11]),label=mtcars[,11],
              objective='count:poisson',nrounds=5)
#predict carb using all other predictors
pred = predict(bst,as.matrix(mtcars[,-11]))
sqrt(mean((pred-mtcars[,11])^2))


pred
head(data.frame(predicted=pred, actual_carb=mtcars[,11]))

#ceiling(pred) and mtcars[,11] error
sqrt(mean((ceiling(pred) - mtcars[,11])^2))

