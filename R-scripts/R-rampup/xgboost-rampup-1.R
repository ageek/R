# Ramping up on XGBoost
# https://github.com/dmlc/xgboost/blob/master/R-package/vignettes/xgboostPresentation.Rmd
# and 
# http://rpackages.ianhowson.com/cran/xgboost/man/agaricus.test.html
require(xgboost)
data(agaricus.test)
test <- agaricus.test
str(test)
# test data size: 1611 x 126
dim(test$data)
length(test$label)

#train size: 1611 x 126
data(agaricus.train)
train <- agaricus.train
dim(train$data)
length(train$label)

#xgb dmatrix terminologies
dtrain <- xgb.DMatrix(train$data, label=train$label)
nrow(dtrain)
slice(dtrain, 1:3)

# CV
data(agaricus.train, package='xgboost')
dtrain <- xgb.DMatrix(agaricus.train$data, 
                      label = agaricus.train$label)
history <- xgb.cv(data = dtrain, nround=3, nthread = 2, 
                  nfold = 5, 
                  metrics=list("rmse","auc"),
                  max.depth =3, eta = 1, 
                  objective = "binary:logistic")
print(history)


# VarImportance
data(agaricus.train, package='xgboost')

# Both dataset are list with two items, a sparse matrix and labels
# (labels = outcome column which will be learned).
# Each column of the sparse Matrix is a feature in one hot encoding format.
train <- agaricus.train

bst <- xgboost(data = train$data, label = train$label, max.depth = 3,
               eta = 1, nthread = 2, nround = 5,objective = "binary:logistic")

# train$data@Dimnames[[2]] represents the column names of the sparse matrix.
xgb.importance(train$data@Dimnames[[2]], model = bst)

# Same thing with co-occurence computation this time
xgb.importance(train$data@Dimnames[[2]], model = bst, data = train$data, label = train$label)


#agaricus.test$data@Dimnames[[2]] represents the column names of the sparse matrix.
xgb.model.dt.tree(agaricus.train$data@Dimnames[[2]], model = bst)


#train$data@Dimnames[[2]] represents the column names of the sparse matrix.
importance_matrix <- xgb.importance(train$data@Dimnames[[2]], model = bst)
xgb.plot.importance(importance_matrix)

xgb.plot.tree(agaricus.train$data@Dimnames[[2]], model = bst)



#train method, with custom objective and error functions
data(agaricus.train, package='xgboost')
dtrain <- xgb.DMatrix(agaricus.train$data, label = agaricus.train$label)
dtest <- dtrain
watchlist <- list(eval = dtest, train = dtrain)
logregobj <- function(preds, dtrain) {
  labels <- getinfo(dtrain, "label")
  preds <- 1/(1 + exp(-preds))
  grad <- preds - labels
  hess <- preds * (1 - preds)
  return(list(grad = grad, hess = hess))
}
evalerror <- function(preds, dtrain) {
  labels <- getinfo(dtrain, "label")
  err <- as.numeric(sum(labels != (preds > 0)))/length(labels)
  return(list(metric = "error", value = err))
}
param <- list(max.depth = 2, eta = 1, silent = 1, objective=logregobj,eval_metric=evalerror)
bst <- xgb.train(param, dtrain, nthread = 2, nround = 2, watchlist)
