# UCI-4-Forest type detection
# 4 class, classification task
# 

require(ggplot2)
require(dplyr)
require(data.table)
require(caret)
require(car)   #for scatterplotmatrix
require(corrgram)   #for correlation plot

train <- read.csv("C:/Ahmed/ML/UCI TODO/Forest type mapping - 2015/training.csv", 
                  header=T, stringsAsFactors=T)
str(train)

test <- read.csv("C:/Ahmed/ML/UCI TODO/Forest type mapping - 2015/testing.csv", 
                 header = T, stringsAsFactors=T)

str(test)

nearZeroVar(train)

nearZeroVar(test)
  
corrgram(train, order=T, lower.panel = panel.ellipse, 
         diag.panel = panel.density)


scatterplot.matrix(train)    #two many predictors to show any useful info

# bare bones train - no tuning, def fitControl etc

set.seed(2244)
def.model <- train(class ~. , data=train, 
                   tuneLength=5)

def.model

gbm.model <- train(class ~., data=train, 
                   method="gbm", 
                   tuneLength=5)
gbm.model

xgb.model <- train(class ~. , data=train, 
                   method="xgbTree", 
                   tuneLength=5)
xgb.model


svm.model <- train(class ~., data=train, 
                   method="svmRadial", 
                   preprocess = c("center", "scale"), 
                   tuneLength =10)

svm.model
# we need to tune the models --next step

plot(svm.model)
plot(xgb.model)
plot(def.model)
plot(gbm.model)


#multiclass ROC ???

#tune xgboost  - run default xgboost model
# Example 1--------------
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

