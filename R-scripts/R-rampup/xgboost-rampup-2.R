# xgBoost - rampup 2
# http://tjo-en.hatenablog.com/entry/2015/06/05/190000


require(xgboost)
require(Matrix)
require(data.table)

train <- fread("C:/Ahmed/ML/dataset local copy/xgboost-mnist-data/prac_train.csv", 
               header = T, data.table = F)

test <- fread("C:/Ahmed/ML/dataset local copy/xgboost-mnist-data/prac_test.csv", 
              header = T, data.table = F)

str(train)
dim(train)
dim(test)

table(train$label)
table(test$label)

# data is already in matrix format, we can directly use it as.matrix()
# but sinceits huge itsbetter to use sparse model matrix/dMatrix
train.mx <- sparse.model.matrix(label ~. -1, data = train)
dtrain <- xgb.DMatrix(data = train.mx, label = train$label)

# test data
test.mx <- sparse.model.matrix(label ~. -1, data = test)
dtest <- xgb.DMatrix(data = test.mx, label = test$label)

# #quick cv
# param <- list(max.depth=2,eta=1,silent=1,
#               nthread = 2, num_class = 10,
#               objective='multi:softmax',
#               eval_metric="mlogloss")
# nround <- 5
# xgb.cv(param, dtrain, nround, nfold=5)


# Using xgb.train
set.seed(9988)
params=list(objective="multi:softmax", 
            booster="gbtree",
            num_class=10, 
            eval_metric="mlogloss", 
            early.stop.round =10,
            eta=0.05, 
            max_depth=5)
train.gdbt<-xgb.train(data=dtrain, 
                      nrounds=5000, 
                      #params=list(objective="multi:softmax", num_class=10, eval_metric="mlogloss"),
                      params = params, verbose = 1,
                      watchlist=list(eval=dtest, train=dtrain))


# prediction
pred<-predict(train.gdbt,newdata=dtest, ntreelimit=2000)

# get accuracy 
# 1.
mean(pred==test$label)

#0.9686

#nrounds 1000 gives .9735
#nourds 5000 givs .9739
# # 2.
# # OR : how does this work??? 
# # btw: both  1&2 give same results...
# sum(diag(table(test$label,pred)))/nrow(test)




