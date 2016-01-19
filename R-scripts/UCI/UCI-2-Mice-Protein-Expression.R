# UCI 2- Mice Protein Expression
# https://archive.ics.uci.edu/ml/datasets/Mice+Protein+Expression
# http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4482027/
# Tasks: Classification, Clustering
require(data.table)
require(caret)
require(xgboost)
require(corrplot)

#open xls file, select all and CTRL+C, and run : not working with missing
#micedata <- read.table("clipboard", na.strings = c(" ", "NA", "NAN"))

#OR using xlsx package ---takes forever--something is wrong
#require(xlsx)   -
#read.xlsx("C:/Ahmed/ML/UCI TODO/Mice Protein Expression - 8 Class/Data_Cortex_Nuclear.xls", 
#         sheetName="Hoja1")

#save the xls file as csv and read
micedata <- read.csv("C:/Ahmed/ML/UCI TODO/Mice Protein Expression - 8 Class/Data_Cortex_Nuclear.csv", 
                     na.strings = c(" ", "NA"), 
                     header = T, 
                     stringsAsFactors =T)

dim(micedata)

#Target proportions 
prop.table(table(micedata$class))
head(micedata)

#any zero var predictors?
nearZeroVar(micedata)

#corrplot  -data must be numeric ???
#corrplot(cor(micedata))

#how many NA/missing rows? around 50%
dim(na.omit(micedata))

dim(micedata)

# Part 1: just drop NAs and compare performance

newmice <- na.omit(micedata)


dim(newmice)

prop.table(table(newmice$class))

require(gbm)

#drop miceID
newmice$MouseID <- NULL

inTrain <- createDataPartition(newmice$class, p = .75, list = F)
miceTrain <- newmice[inTrain, ]
miceTest <- newmice[-inTrain, ]
set.seed(3344)
gbm1.model <- gbm(class~., data=miceTrain, 
                  n.trees = 1000, #max is 100, 
                  interaction.depth=3,
                  n.minobsinnode = 2, 
                  shrinkage = .05, 
                  bag.fraction = .5,
                  train.fraction = .8,
                  cv.folds = 5,
                  class.stratify.cv = T, 
                  verbose = T,
                  distribution = "multinomial")


gbm1.model
summary(gbm1.model)

preds.gbm1 <- predict(gbm1.model, newdata = miceTest, 
                      n.trees = 50,
                      type="response")

# do a multiclass ROC
#require(pROC)
#auc(miceTest$class, preds.gbm1, plot =T)
# extract Max probability and convert to class number
# map class number to class name
#preds.gbm1.class.number <- apply(preds.gbm1, MARGIN = 1, which.max)

# http://stackoverflow.com/questions/15585501/usage-of-caret-with-gbm-method-for-multiclass-classification
#OR 
# direclty get class names from pred prob matrix as:
preds.gbm1.class <- colnames(preds.gbm1)[apply(preds.gbm1, MARGIN = 1, which.max)]

confusionMatrix(preds.gbm1.class, miceTest$class)
# Accuracy : 0.6963
# Reference
# Prediction c-CS-m c-CS-s c-SC-m c-SC-s t-CS-m t-CS-s t-SC-m t-SC-s
# c-CS-m      0      0      0      0      0      0      0      0
# c-CS-s      1     14      0      0      1      2      0      0
# c-SC-m      0      0     15      1      0      0      2      0
# c-SC-s      0      0      0     16      0      0      5      5
# t-CS-m      6      0      0      0     20      1      0      1
# t-CS-s      0      4      0      0      0     12      0      0
# t-SC-m      0      0      0      1      0      0      8      3
# t-SC-s      4      0      0      0      1      3      0      9
 



# Impute missing using avg for the same class
#map missing 
missmap(micedata)

dim(micedata[complete.cases(micedata), ])

dim(micedata[!complete.cases(micedata), ])

# http://rpubs.com/kaz_yos/mice-amelia
require(mice)
## Load VIM package for Visualization and Imputation of Missing Values
library(VIM)

md.pattern(micedata)
#visualize missing values
#in numbers
aggr(micedata, prop = F, numbers = T)

## in proportions
aggr(micedata, prop = T, numbers = T)


## Matrix plot. Red for missing values, Darker values are high values.
matrixplot(micedata, interactive = F, sortby = "class")

#Scatter plot matrix with VIM package
#scattmatrixMiss(micedata, interactive = F, highlight = c("class"))

names(micedata)
factorCols <- c("MouseID", "Genotype", "Treatment", "Behavior", "class")
nonfactorcols <- setdiff(names(micedata), factorCols)

micedata.nofactor <- micedata[, nonfactorcols]

#Amelia complains about this column being collinear with other 
micedata.nofactor$pS6_N <- NULL
## Perform imputation
am.mice <- amelia(x = micedata.nofactor, parallel = "multicore", 
                              p2s = 2)


summary(am.mice)

#5 imputations done, pick 5th and check the steps
# why 5th? which one to pick out of 5, any logical reasoning?
imputed.mice.data <- am.mice$imputations$imp3

#merge back the factor columns removed earleir

full.mice.imputed.data <- cbind(imputed.mice.data, micedata[, factorCols])

full.mice.imputed.data$MouseID <- NULL
inTrain <- createDataPartition(full.mice.imputed.data$class, p = .75, list = F)
miceTrain <- full.mice.imputed.data[inTrain, ]
miceTest <- full.mice.imputed.data[-inTrain, ]
set.seed(3344)
gbm1.model.am <- gbm(class~., data=miceTrain, 
                  n.trees = 1000, #max is 100, 
                  interaction.depth=2,
                  n.minobsinnode = 2, 
                  shrinkage = .1, 
                  bag.fraction = .5,
                  train.fraction = .8,
                  #cv.folds = 3,
                  class.stratify.cv = T, 
                  verbose = T,
                  distribution = "multinomial")


gbm1.model.am
summary(gbm1.model.am)

preds.gbm1.am <- predict(gbm1.model.am, newdata = miceTest, 
                      n.trees = gbm.perf(gbm1.model.am, method="OOB"),
                      type="response")

# do a multiclass ROC
#require(pROC) - AUC for multiclass is mean ofall AUCs
#roc(miceTest$class, preds.gbm1, plot =T)
# extract Max probability and convert to class number
# map class number to class name
#preds.gbm1.class.number <- apply(preds.gbm1, MARGIN = 1, which.max)

# http://stackoverflow.com/questions/15585501/usage-of-caret-with-gbm-method-for-multiclass-classification
#OR 
# direclty get class names from pred prob matrix as:
preds.gbm1.class <- colnames(preds.gbm1.am)[apply(preds.gbm1.am, MARGIN = 1, which.max)]

confusionMatrix(preds.gbm1.class, miceTest$class)

# After imputation Accuracy improved to 80%, however t-SC-s
# has 0 sensitivity, i.e. all misclassified, 
# on un-imputed data, size ~ 552, the c-CS-m was having 0 sensitivity, why???
# Confusion Matrix and Statistics
# 
# Reference
# Prediction c-CS-m c-CS-s c-SC-m c-SC-s t-CS-m t-CS-s t-SC-m t-SC-s
# c-CS-m     37      0      0      0      0      0      0      0
# c-CS-s      0     33      0      0      0      0      0      0
# c-SC-m      0      0     37      0      0      0      0      0
# c-SC-s      0      0      0     33      0      0      0      8
# t-CS-m      0      0      0      0     33     20      0      0
# t-CS-s      0      0      0      0      0      6      0      0
# t-SC-m      0      0      0      0      0      0     33     25
# t-SC-s      0      0      0      0      0      0      0      0
# 
# Overall Statistics
# 
# Accuracy : 0.8             
# 95% CI : (0.7467, 0.8464)

#Needs further investigation
# why a particular class is being misclassfied fully? are the predictors
# no able to capture sufficient predictive powers? hwat is missing/wrong 
# here? TODO
#Need to do clustering as well (8 classes -> 8 clusters)
