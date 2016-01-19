# Rpubs -1 
#https://rpubs.com/flyingdisc/practical-machine-learning-xgboost
# data
#train.url ="https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
#test.url = "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

train.org <- read.csv("C:/Ahmed/ML/dataset local copy/pml-training.csv")
test.org <- read.csv("C:/Ahmed/ML/dataset local copy/pml-testing.csv")

dim(train.org)
dim(test.org)
str(train.org)

target <- "classe"
table(train.org[,c("classe")])

#The assignment rubric asks to use data from accelerometers on the belt,
# forearm, arm, and dumbell, so the features are extracted based on these keywords.

filter <- grepl("belt|arm|dumbell", names(train.org))
train.org[, filter]

train <- train.org[, filter]
test <- test.org[, filter]

dim(train)

# # remove columns with NA, use test data as referal for NA
colSums(is.na(test))==0

cols.without.na <- colSums(is.na(test))==0
train.x <- train[, cols.without.na]
test.x <- test[, cols.without.na]
#only 39 column remains, without NA values, out of 140
dim(train.x)
dim(test.x)
colSums(is.na(test.x))==0

require(caret)
## check for zero variance
nearZeroVar(train.x, saveMetrics = T)

#none with zero varinace, we are good to go ahead

featurePlot(train.x, target)

#Plot a correlation matrix between features.
#A good set of features is when they are highly uncorrelated 
#(orthogonal) each others. The plot below shows average of 
#correlation is not too high, so I choose to not perform further
#PCA preprocessing.
require(corrplot)
corrplot.mixed(cor(train.x))

corrplot.mixed(cor(train.x), tl.pos="lt")

corrplot.mixed(cor(train.x), tl.pos="lt", lower="circle", 
               upper="color", diag="n", order="AOE")

corrplot.mixed(cor(train.x), lower="circle", upper="color", 
               tl.pos="lt", diag="n", order="hclust", 
               hclust.method="complete")

## t-Distributed Stochastic Neighbor Embedding
require(Rtsne)
tsne = Rtsne(as.matrix(train.x), check_duplicates=FALSE, pca=TRUE, 
             perplexity=30, theta=0.5, dims=2)

#plot tsne using ggplot
require(ggplot2)
embedding = as.data.frame(tsne$Y)
embedding$Class = train.org[, c("classe")]
ggplot(embedding, aes(x=V1, y=V2, color=Class)) +
  geom_point(size=1.25)  +
  #revert back change size of dots on class legend, was set to 1.25
  guides(colour=guide_legend(override.aes=list(size=6))) 


#Build machine learning model
#Now build a machine learning model to predict activity quality 
#(classe outcome) from the activity monitors (the features or 
#predictors) by using XGBoost extreme gradient boosting algorithm.
require(xgboost)

#Convert the outcome to numeric, because XGBoost gradient booster 
#only recognizes numeric data.
# convert character levels to numeric
outcome <- train.org[,c("classe")]
num.class = length(levels(outcome))
levels(outcome) = 1:num.class
head(outcome)


#XGBoost supports only numeric matrix data. Converting all training, testing and outcome data to matrix.
# convert data to matrix
train.matrix = as.matrix(train.x)
mode(train.matrix) = "numeric"
test.matrix = as.matrix(test.x)
mode(test.matrix) = "numeric"
# convert outcome from factor to numeric matrix 
#   xgboost takes multi-labels in [0, numOfClass)
y = as.matrix(as.integer(outcome)-1)

#check
table(y)
table(train.org[,c("classe")])

# xgboost parameters
param <- list("objective" = "multi:softprob",    # multiclass classification 
              "num_class" = num.class,    # number of classes 
              "eval_metric" = "merror",    # evaluation metric 
              "nthread" = 8,   # number of threads to be used 
              "max_depth" = 16,    # maximum depth of tree 
              "eta" = 0.3,    # step size shrinkage 
              "gamma" = 0,    # minimum loss reduction 
              "subsample" = 1,    # part of data instances to grow tree 
              "colsample_bytree" = 1,  # subsample ratio of columns when constructing each tree 
              "min_child_weight" = 12  # minimum sum of instance weight needed in a child 
              )

# set random seed, for reproducibility 
set.seed(1234)
# k-fold cross validation, with timing
nround.cv = 200
system.time( bst.cv <- xgb.cv(param=param, data=train.matrix, label=y, 
                              nfold=4, nrounds=nround.cv, prediction=TRUE, verbose=FALSE) )

tail(bst.cv$dt) 

# index of minimum merror
min.merror.idx = which.min(bst.cv$dt[, test.merror.mean]) 
min.merror.idx


# minimum merror
bst.cv$dt[min.merror.idx,]

nrow(bst.cv$dt)
#[1] 200
#plot error curve: test.merror.mean
plot(bst.cv$dt[, test.merror.mean])
#plot all
matplot(bst.cv$dt)

# get CV's prediction decoding
pred.cv = matrix(bst.cv$pred, nrow=length(bst.cv$pred)/num.class,
                 ncol=num.class)
pred.cv = max.col(pred.cv, "last")
# confusion matrix for cv
confusionMatrix(factor(y+1), factor(pred.cv))

#Model training
#Fit the XGBoost gradient boosting model on all of the training data.

# real model fit training, with full data
system.time( bst <- xgboost(param=param, data=train.matrix, label=y, 
                            nrounds=min.merror.idx, verbose=0) )

#Predicting the testing data

# xgboost predict test data using the trained model
pred <- predict(bst, test.matrix)  
head(pred, 10)  

#Post-processing

#Output of prediction is the predicted probability of the 5 levels (columns) of outcome.
#Decode the quantitative 5 levels of outcomes to qualitative letters (A, B, C, D, E).

# decode prediction
pred = matrix(pred, nrow=num.class, ncol=length(pred)/num.class)
pred = t(pred)
pred = max.col(pred, "last")
pred.char = toupper(letters[pred])

#Feature importance

# get the trained model
model = xgb.dump(bst, with.stats=TRUE)
# get the feature real names
names = dimnames(train.matrix)[[2]]
# compute feature importance matrix
importance_matrix = xgb.importance(names, model=bst)

# plot
gp = xgb.plot.importance(importance_matrix)
print(gp) 
