# XGBoost - Official examples 
# https://github.com/dmlc/xgboost/blob/master/R-package/demo/basic_walkthrough.R
# check 2nd half, for 2 addition examples

require(xgboost)
require(methods)
require(data.table)
require(Matrix)

# we load in the agaricus dataset
# In this example, we are aiming to predict whether a mushroom can be eaten
data(agaricus.train, package='xgboost')
data(agaricus.test, package='xgboost')
train <- agaricus.train
test <- agaricus.test

# the loaded data is stored in sparseMatrix, and label is a numeric vector in {0,1}
class(train$label)
class(train$data)


#-------------Basic Training using XGBoost-----------------
# this is the basic usage of xgboost you can put matrix in data field
# note: we are putting in sparse matrix here, xgboost naturally handles sparse input

# Option 1
# use sparse matrix when your feature is sparse(e.g. when you are using one-hot encoding vector)
print("training xgboost with sparseMatrix")

bst <- xgboost(data= train$data, label=train$label, 
               max.depth=2, eta=1, nround=5, 
               nthread=5, 
               objective="binary:logistic")

summary(bst)

# Option 2:
# alternatively, you can put in dense matrix, i.e. basic R-matrix
print("training xgboost with Matrix")
bst <- xgboost(data = as.matrix(train$data), label=train$label, 
               max.depth=2, eta=1, nround=5, 
               nthread=5, 
               objective="binary:logistic")

# Option 3: Reccommended by xgboost
# you can also put in xgb.DMatrix object, which stores label, data and other meta datas needed for advanced features
print("training xgboost with xgb.DMatrix")
dtrain <- xgb.DMatrix(data=train$data, label=train$label)
bst <- xgboost(data=dtrain, 
               max.depth=2, eta=1, nround=5, 
               nthread=5, 
               objective="binary:logistic")



# Verbose = 0,1,2
print ('train xgboost with verbose 0, no message')
bst <- xgboost(data = dtrain, max.depth = 2, eta = 1, nround = 2,
               nthread = 2, objective = "binary:logistic", verbose = 0)


print ('train xgboost with verbose 1, print evaluation metric')
bst <- xgboost(data = dtrain, max.depth = 2, eta = 1, nround = 2,
               nthread = 2, objective = "binary:logistic", verbose = 1)


print ('train xgboost with verbose 2, also print information about tree')
bst <- xgboost(data = dtrain, max.depth = 2, eta = 1, nround = 2,
               nthread = 2, objective = "binary:logistic", verbose = 2)


# you can also specify data as file path to a LibSVM format input
# since we do not have this file with us, the following line is just for illustration
# bst <- xgboost(data = 'agaricus.train.svm', max.depth = 2, eta = 1, nround = 2,objective = "binary:logistic")



#----------------Advanced features --------------
# to use advanced features, we need to put data in xgb.DMatrix
dtrain <- xgb.DMatrix(data = train$data, label=train$label)
dtest <- xgb.DMatrix(data = test$data, label=test$label)
#---------------Using watchlist----------------
# watchlist is a list of xgb.DMatrix, each of them is tagged with name
watchlist <- list(train=dtrain, test=dtest)
# to train with watchlist, use xgb.train, which contains more advanced features
# watchlist allows us to monitor the evaluation result on all data in the list 
print ('train xgboost using xgb.train with watchlist')
bst <- xgb.train(data=dtrain, max.depth=2, eta=1, nround=2,
                 watchlist=watchlist,
                 nthread = 2, objective = "binary:logistic")


# we can change evaluation metrics, or use multiple evaluation metrics
print ('train xgboost using xgb.train with watchlist, watch logloss and error')
bst <- xgb.train(data=dtrain, max.depth=2, eta=1, nround=2, 
                 watchlist=watchlist,
                 eval.metric = "error", eval.metric = "logloss",
                 nthread = 2, objective = "binary:logistic")


# You can dump the tree you learned using xgb.dump into a text file
xgb.dump(bst, "dump.raw.txt", with.stats = T)

# Finally, you can check which features are the most important.
print("Most important features (look at column Gain):")
print(xgb.importance(feature_names = train$data@Dimnames[[2]], 
                     filename_dump = "dump.raw.txt"))


#More examples
# Example 1--------------
# stop using read.csv....always use fread and set data.table=F, 
# when you need data.frame....use as de.facto

train <- read.csv("C:/Ahmed/ML/UCI TODO/Forest type mapping - 2015/training.csv", 
                  header=T, stringsAsFactors=T)

test <- read.csv("C:/Ahmed/ML/UCI TODO/Forest type mapping - 2015/testing.csv", 
                 header = T, stringsAsFactors=T)

#xgboost expects target to be numeric
# #not working as function...throwing weird errors
# getSvmLikeTarget <- function(mydata) {
#   #re-level to numeric
#   levels(mydata$class) <- c("0","1","2","3")
#   mydata$class <- as.numeric(mydata$class)
#   
#   #to integer
#   mydata$class <- as.integer(mydata$class - 1)
#   return mydata
# }

table(train$class)
levels(train$class) <- c("0","1","2","3")
#to numeric
train$class <- as.numeric(train$class)

#class as integer from [0,...num_class)
train$class <- as.integer(train$class -1)
table(train$class)

# stop using all these junks...read train as data.table and  do
# train[, class:=as.integer(class)-1]

#for test
table(test$class)
levels(test$class) <- c("0","1","2","3")
#to numeric
test$class <- as.numeric(test$class)

#class as integer from [0,...num_class)
test$class <- as.integer(test$class -1)
table(test$class)


# option 1 : Sparse model matrix
# -1 to ignore the target
train.mx <- sparse.model.matrix(class ~.-1, data=train)
test.mx <- sparse.model.matrix(class ~.-1, data=test)

bst <- xgboost(data=train.mx, label = train$class,
               max.depth=2, eta=1, nround=5, 
               nthread=5, num_class = 4, 
               objective="multi:softmax")


# option 3: dMatrix way
dtrain <- xgb.DMatrix(data = train.mx, label = train$class)
dtest <- xgb.DMatrix(data = test.mx, label = test$class)

watchlist <- list(train = dtrain, test = dtest)

bst <- xgb.train(data=dtrain, max.depth=2, eta=1, nround=10,
                 watchlist=watchlist,num_class = 4,
                 nthread = 2, objective = "multi:softmax")




# Example 2-----------------
# Bank marketing example
#use data.table fread to read as data.frame
train <- fread("C:/Ahmed/ML/dataset local copy/bank/bank.csv", 
                  header = T, stringsAsFactors = T, data.table=F)

# Prepare data for xgboost
#bring target to 1st pos
train <- data.frame(y=train[,c(17)], train[,c(1:16)])

# relevel y to numeric
table(train$y)
levels(train$y) <- c("0", "1")
train$y <- as.numeric(train$y)
#y as int
train$y <- as.integer(train$y - 1)
table(train$y)

# OR read train as data.table and quickly manipulate level as integer
# train <- fread("C:/Ahmed/ML/dataset local copy/bank/bank.csv", 
#                header = T, stringsAsFactors = T, data.table=T)
# table(train$y)
# train[, y:=as.integer(y)-1]
# table(train$y)

str(train)
# Option 1: sparse model.matrix
train.mx <- sparse.model.matrix(y~.-1, data=train)

bst <- xgboost(data=train.mx, label = train$y, 
               max.depth=2, eta=1, nround=5, 
               nthread=5, 
               objective="binary:logistic")

# Note: Since the fulldata(excluding target) is numeric, we might as well
# use data as.matrix(), instread of doing sparese.model.matrix etc...as
# train <- fread("C:/Ahmed/ML/dataset local copy/bank/bank.csv", 
#                header = T, stringsAsFactors = T, data.table=F)
# bst <- xgboost(data=as.matrix(train[,-c(1)]), 
#               label=as.integer(train$class)-1, 
#               nrounds=2, objective="multi:softmax", 
#               num_class=4, eta=1, max.depth=2)
# [0] train-merror:0.015152
# [1]	train-merror:0.005051


# optin 2: as matrix
bst <- xgboost(data=as.matrix(train.mx), label = train$y, 
               max.depth=2, eta=1, nround=5, 
               nthread=5, 
               objective="binary:logistic")

# option 3: as xgb.dMatrix
dtrain <- xgb.DMatrix(data=train.mx, label=train$y)
bst <- xgboost(data=dtrain, 
               max.depth=2, eta=1, nround=5, 
               nthread=5, 
               objective="binary:logistic")

