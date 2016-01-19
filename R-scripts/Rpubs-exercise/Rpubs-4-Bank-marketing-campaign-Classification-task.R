#Rpubs 4 - direct marketing campaigns of a Portuguese banking institution.
# https://rpubs.com/vaidehi/114947  - reference only
# https://inclass.kaggle.com/c/data-driven-decision-making-spring-2015
# dataset used: http://mlr.cs.umass.edu/ml/datasets/Bank+Marketing
# The marketing campaigns were based on phone calls. 
# Often, more than one contact to the same client was required, 
# in order to access if the product (bank term deposit) would be
# ('yes') or not ('no') subscribed.

require(ggplot2)
require(data.table)
require(pROC)
require(caret)
require(gbm)
#require(dplyr)

fulldata <- fread("C:/Ahmed/ML/dataset local copy/bank/bank.csv", 
                  header = T, stringsAsFactors = T)

head(fulldata)

#dim 
dim(fulldata)
names(fulldata)
#lot of the names have * at the end, lets clean them
gsub("\\*", "", "out*")

#throws warning, saying R copies the whole table, use setnames instead
names(fulldata) <- sapply(as.list(names(fulldata)), 
                          function(x) gsub("\\*", "", x))

#use setnames(fulldata) <- sapply(as.list(names(fulldata)), 
#                             function(x) gsub("\\*", "", x))
table(fulldata$y)


#check for zero variance predictors
nearZeroVar(fulldata)

# remove nearzero variance predictors : default & pdays
bankdata <- fulldata[, -c(5, 14), with=F]

# plot(density(fulldata$balance))
# plot(density(fulldata$pdays))

#require(car)
#scatterplotMatrix(fulldata)

require(psych)
pairs.panels(bankdata)   # takes couple of mins to plot

# housing, contact, duration, previous and poutcome
# has good corelation with y (either + or -)  but >= 0.10
# lets see what the model says about varImp

#only ~11% sbscribed for a term loan, rest 88% just ignored/not-interested
prop.table(table(fulldata$y))

#no split, lets use RF and analyze data
#when we load the full dataset:45211 rows, we'll do train/test/cv etc

gbm.model1 <- train(as.factor(y)~., data=bankdata, 
                   method="gbm")

#get varImp from the above model
summary(gbm.model1)
# duration                     duration 47.41412712
# poutcomesuccess       poutcomesuccess 14.34720456
# age                               age  7.29028850
# day                               day  4.61011897
# monthoct                     monthoct  3.88694931
# balance                       balance  3.22577661
# monthmar                     monthmar  3.03379853
# contactunknown         contactunknown  2.84239365
# previous                     previous  2.37768983
# campaign                     campaign  1.85491230
# maritalmarried         maritalmarried  1.10317062

gbm.model1
#Accuracy is .89

#Warning: the following grid took almos 4hrs to complete 
# with 3 X 3 X 3 = 27 parameters to tune
tGrid <- expand.grid(interaction.depth=seq(2:4), 
                           n.trees = 3000, 
                           shrinkage = seq(0.1,0.3,0.1), 
                           n.minobsinnode = seq(10,12,1))

gbm.model1 <- train(as.factor(y)~., data=bankdata, 
                    method="gbm", metric="AUC", 
                    tuneGrid = tGrid
                    )

gbm.model1
# Tuning parameter 'n.trees' was held constant at a value of 3000
# Accuracy was used to select the optimal model using  the
# largest value.
# The final values used for the model were n.trees =
#   3000, interaction.depth = 1, shrinkage = 0.1 and n.minobsinnode = 11.
# shrinkage  interaction.depth  n.minobsinnode  Accuracy   Kappa    
# 0.1        1                  10              0.8937020  0.3849347
# 0.1        1                  11              0.8947079  0.3932263
# 0.1        1                  12              0.8942775  0.3925945
# 0.1        2                  10              0.8924763  0.4125543
# 0.1        2                  11              0.8921974  0.4120872
# 0.1        2                  12              0.8920506  0.4098088
# 0.1        3                  10              0.8926566  0.4156529
# 0.1        3                  11              0.8915769  0.4094687
# 0.1        3                  12              0.8925633  0.4143501
# 0.2        1                  10              0.8915433  0.3866865
# 0.2        1                  11              0.8914389  0.3858551
# 0.2        1                  12              0.8912779  0.3836886
# 0.2        2                  10              0.8899007  0.4083132
# 0.2        2                  11              0.8905908  0.4118530
# 0.2        2                  12              0.8901555  0.4127807
# 0.2        3                  10              0.8920931  0.4154269
# 0.2        3                  11              0.8909671  0.4095696
# 0.2        3                  12              0.8908901  0.4071802
# 0.3        1                  10              0.8890006  0.3828381
# 0.3        1                  11              0.8888196  0.3792974
# 0.3        1                  12              0.8893623  0.3802631
# 0.3        2                  10              0.8879975  0.4028982
# 0.3        2                  11              0.8887602  0.4050166
# 0.3        2                  12              0.8885638  0.4071496
# 0.3        3                  10              0.8904692  0.4104008
# 0.3        3                  11              0.8909407  0.4124761
# 0.3        3                  12              0.8897295  0.4031313

summary(gbm.model1)
tGrid2 <- expand.grid(interaction.depth=1, 
                     n.trees = 5000, 
                     shrinkage = .01, 
                     n.minobsinnode = 10)

#for metric=ROC, trainControl (classProbs=T) is needed
trCtrl <- trainControl(method="repeatedcv", 
                       number = 3, 
                       classProbs = T,
                       summaryFunction = twoClassSummary,
                       allowParallel = T)
#bankdata <- fulldata[, -c(5, 14), with=F]
gbm.model2 <- train(as.factor(y)~., data=bankdata, 
                    method="gbm", metric="ROC", verbose = T,
                    tuneGrid = tGrid2,
                    trControl = trCtrl
                    )

gbm.model2
# Accuracy   Kappa      Accuracy SD  Kappa SD  
# 0.8912775  0.3750939  0.006148331  0.02756455
# 
# Tuning parameter 'n.trees' was held constant at a value of 5000
# Tuning parameter 'shrinkage' was held constant at a value of 0.1
# Tuning parameter 'n.minobsinnode' was held constant at a value of 10
plot(gbm.model2)

#plot train vs test error to pick n.trees value
#gbm.perf(gbm.model2, method = "cv")

#directly using gbm package
bankdata <- read.csv("C:/Ahmed/ML/dataset local copy/bank/bank-full.csv", 
                  header = T, stringsAsFactors = T, sep=";")
#gbm1 <- gbm(as.factor(y)~., data=bankdata,
bankdata$default <- NULL
bankdata$pdays <- NULL
bankdata$y <- as.numeric(bankdata$y)-1  #change response to 0/no 1/yes
inTrain <- createDataPartition(bankdata$y, p=.75, list = F)
bankTrain <- bankdata[inTrain, ]
bankTest <- bankdata[-inTrain, ]
set.seed(4433)
system.time(gbm1 <- gbm(y~., data=bankTrain,
                n.trees=5000, 
                # 1 gives AUC .9073, 2 gives .9122 etc
                # 3 gives .9154
                interaction.depth=3,
                n.minobsinnode = 12, 
                shrinkage = .01, 
                bag.fraction = .5,
                train.fraction = .9,
                cv.folds = 5,
                class.stratify.cv = T, 
                verbose = T,
                distribution="bernoulli")
)

gbm1
summary(gbm1)
# var      rel.inf
# duration   duration 58.991779457
# poutcome   poutcome 22.279322260
# month         month 14.504572092
# age             age  1.558312202
# contact     contact  1.153074988
# previous   previous  0.838516699


#plot train vs test error to pick n.trees value
gbm.perf(gbm1, method = "test")
#[1] 3749

#test data size = 1130
preds.gbm1 <- predict(gbm1, newdata = bankTest[-c(15)], 
                      n.trees = gbm.perf(gbm1, method = "cv"),
                      type="response")

#measure AUC
#roc(bankTest$y, preds.gbm1, auc=T)
# OR
auc(bankTest$y, preds.gbm1, plot=F)

#AUC is .9191 with method="cv"/4911 trees, lr=.01, n.trees=5000, 

# Results from Authors Paper: 
# http://repositorium.sdum.uminho.pt/bitstream/1822/14838/1/MoroCortezLaureano_DMApproach4DirectMKT.pdf
#Algorithm                         NB NB DT NB DT SVM
#Number of executions (runs)       1 20 20 20 20 20
#AUC (Area Under the ROC Curve)    0.776 0.823 0.764 0.870 0.868 0.938
#ALIFT (Area Under the LIFT Curve) 0.687 0.790 0.591 0.827 0.790 0.887
#Summary: SVM is giving .938 AUC



#use the above parameters  using caret's gbm
tGrid3 <- expand.grid(interaction.depth=1, 
                      n.trees = 5000, 
                      shrinkage = .01, 
                      n.minobsinnode = c(8,10,14)
                      )

#for metric=ROC, trainControl (classProbs=T) is needed
trCtrl3 <- trainControl(method="repeatedcv", 
                       number = 5, 
                       classProbs = T,
                       summaryFunction = twoClassSummary,
                       allowParallel = T
#                        bag.fraction = .5,
#                        train.fraction = .9,
#                        cv.folds = 5,
#                        verbose = T,
#                        distribution="bernoulli"
                        )
# caret expects output as factor
bankTrain$y[bankTrain$y == 1] <- "yes"
bankTrain$y[bankTrain$y == 0] <- "no"
system.time(gbm.model3 <- train(as.factor(y)~., data=bankTrain, 
                    method="gbm", metric="ROC", verbose = T,
                    tuneGrid = tGrid3,
                    trControl = trCtrl3
            ) )
#   user  system elapsed 
# 733.05    0.27  743.43
#Carets gbm train takes around 12 minutes vs 2-3 minutes using gbm directly
gbm.model3
#AUC is .911559

plot(gbm.model3)

gbm3.preds <- predict(gbm.model3, newdata = bankTest[,-c(15)], 
                      type="prob")

# in gbm3.preds, select the "yes" col for auc
auc(bankTest$y, gbm3.preds[,2], plot=T)

#use XGBoost and check the total run time vs AUC score
require(xgboost)
#make sure y is set to "yes"/"no" not 0/1, else it'll error out
bankTrain$y[bankTrain$y == 1] <- "yes"
bankTrain$y[bankTrain$y == 0] <- "no"

set.seed(4455)
system.time(xgboost.model1 <- train(as.factor(y)~., data=bankTrain, 
                        method="xgbTree", metric="AUC",
                        verbose=T)
            )
xgboost.model1
xgb1.preds <- predict(xgboost.model1, newdata = bankTest[,-c(15)], 
                      type="prob")
#use yes col for AUC
auc(bankTest$y, xgb1.preds[,2], plot=T)
# without any tuning, default params gives AUC .9335, easily beats 
# the .93 mentioned by authos using tune SVM

#lets tune xgboost a bit
set.seed(4466)
system.time(xgboost.model2 <- train(as.factor(y)~., data=bankTrain, 
                                    method="xgbTree", metric="AUC",
                                    tuneGrid = expand.grid (eta = c(.1,.3,.5),
                                                            max_depth = c(4,5,6) ,
                                                            nrounds = seq(4,8,1) * 50),
                                    verbose=T)
)
xgboost.model2
xgb2.preds <- predict(xgboost.model2, newdata = bankTest[,-c(15)], 
                      type="prob")
#use yes col for AUC
auc(bankTest$y, xgb2.preds[,2], plot=T)
#gives .9347