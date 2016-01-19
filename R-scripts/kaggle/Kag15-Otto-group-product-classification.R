#Otto product challenge

require(xgboost)
require(methods)
require(data.table)
require(dplyr)

train <- fread("C:/Ahmed/ML/dataset local copy/Kaggle2015/Otto group/train.csv", 
               header=T, stringsAsFactors=F)

test <- fread("C:/Ahmed/ML/dataset local copy/Kaggle2015//Otto group/test.csv", 
              header=T, stringsAsFactors=F)
dim(train)
dim(test)

head(test)

train[1:6,1:5, with=F]

#delete the id column
train[, id:=NULL]
test[, id:=NULL]

dim(train)
dim(test)

# Save the name of the last column
nameLastCol <- names(train)[ncol(train)]

#check target class in training
train[1:6, ncol(train), with=F]

table(train$target)
prop.table(table(train$target))

#convert last target column from string to numeric, as XGBoost doesnot
# support string targets
#option 1: 
a <- "Class_4"
as.numeric(strsplit(a, "_")[[1]][2])
#OR
as.numeric(substr(a, 7,7))
#OR
as.numeric(gsub('Class_', '',a))  #here globalsub(gsub) or just sub will do the same

#option 1.1 : using dplyr
train %>%
  select(target) %>%
  #check, why its not working
  #mutate(Class=as.numeric(strsplit(target, "_")[[1]][2]))
  mutate(target=as.numeric(substr(target,7,7)) -1)


#using any of the above techniques directly inside DT e.g.
# option 1.3 using data.table way
train[, class:=as.numeric(gsub('Class_','', target)) -1]

#OR option 1.2
# instead of class, use target:= to do direct replacement of column
train[, class:=as.numeric(strsplit(target, '_')[[1]][2]) -1]


#option 2(from the link/web page, ): 
#last column 
train[, nameLastCol, with=F]

#select just the target value
train[, nameLastCol, with=F][[1]]

#extract the class number
require(dplyr)
y <- train[, nameLastCol, with=F][[1]] %>% 
  gsub('Class_','',.) %>%
  {as.integer(.) -1} # subtract 1, so class starts from 0, for XGB

head(y)

#remove target
train[, target:=NULL, ]

#drop "class" column we added while experimenting, as its 
# captured by label in "y" vector
train[, class:=NULL,]
#cross check rownames
names(train)

#data.table is an awesome implementation of data.frame, 
#unfortunately it is not a format supported natively by XGBoost. 
#We need to convert both datasets (training and test) in numeric 
# Matrix format.

trainMatrix <- train[,lapply(.SD,as.numeric)] %>% as.matrix
testMatrix <- test[,lapply(.SD,as.numeric)] %>% as.matrix

# try this? throws this error in xgb.cv():
#Error in xgb.DMatrix(data, label = label) : 
#   REAL() can only be applied to a 'numeric', not a 'integer'
#trainMatrix <- as.matrix(train)
#testMatrix <- as.matrix(test)

#Before the learning we will use the cross validation 
#to evaluate the our error rate.

numberOfClasses <- max(y) + 1

param <- list("objective" = "multi:softprob",
              "eval_metric" = "mlogloss",  #as mentiond in competition page
              "num_class" = numberOfClasses)

cv.nround <- 500  #(min is arond 156)
cv.nfold <- 5


bst.cv <- xgb.cv(param = param, 
                 data= trainMatrix, 
                 label = y, 
                 nfold = cv.nfold, prediction=T,
                 nrounds = cv.nround)


tail(bst.cv$dt) 

# index of minimum merror
min.merror.idx = which.min(bst.cv$dt[, test.mlogloss.mean]) 
min.merror.idx


# minimum merror
bst.cv$dt[min.merror.idx,]

nrow(bst.cv$dt)
#[1] 200
#plot error curve: test.mlogloss.mean
plot(bst.cv$dt[, test.mlogloss.mean])

#plot all
matplot(bst.cv$dt)

# get CV's prediction decoding
#reshare the bst.cv$pred list to nrow X ncol matrix format
pred.cv = matrix(bst.cv$pred, 
                 nrow=length(bst.cv$pred)/numberOfClasses,
                 ncol=numberOfClasses)
pred.cv = max.col(pred.cv, "last")
# confusion matrix for cv
require(caret)
confusionMatrix(factor(y+1), factor(pred.cv))


#=============================Model 
#Finally, we are ready to train the real model!!!
nround <- 200
bst <- xgboost(param=param, data = trainMatrix, 
               label = y, 
               nrounds=nround)

#Let's see what the model looks like.

model <- xgb.dump(bst, with.stats = T)
model[1:10]


# Get the feature real names
names <- dimnames(trainMatrix)[[2]]

# Compute feature importance matrix
importance_matrix <- xgb.importance(names, model = bst)

# Nice graph
xgb.plot.importance(importance_matrix[1:10,])

#plot tree
xgb.plot.tree(feature_names = names,
              model = bst, 
              n_first_tree = 1) #how many trees to display




