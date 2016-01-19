# Kag - Flavor of Physics
require(caret)
require(ggplot2)
require(data.table)
require(psych)
require(glmnet)

ff <- fread("C:/Ahmed/ML/Kag2015/Flavours-of-physics/training.csv")
head(ff)

table(ff$signal)

# Attempt1 - LogisticRegression using glmnet

#remove columns not in test data
toIgnore <- c('id', 'min_ANNmuon', 'production', 'mass')
predictors <- setdiff(names(ff), toIgnore)
predictors
# Lets check coeff withou any train/test split
x <- model.matrix(log(signal)~., data=ff[, !toIgnore, with=F])
y <- ff$signal

#alpha=0 means Ridge /L2 norm
#alpha=1, Lasso / L1 norm
ff.ridge <- glmnet(x,y,alpha=0)
plot(ff.ridge, xvar="lambda", label=T)
cv.ridge <- cv.glmnet(x,y, alpha=0, family="binomial", 
                      type.measure="auc")

plot(cv.ridge)
#plot says, we need around 46 parameters and AUC is around .93
# with 46 features, log(lambda) ~ -2


# fit a lasso model
ff.lasso <- glmnet(x,y,alpha=1)
plot(ff.lasso, xvar="lambda", label=T)
cv.lasso <- cv.glmnet(x,y, alpha=1, family="binomial", 
                      type.measure="auc")
plot(cv.lasso)
# lasso says, we can use 33 features and get CV AUC ~ .93

#%age of dev explained - i.e %age varaince explained
# similar to R^2
plot(ff.lasso, xvar="dev", label=T)

coef(cv.lasso)


#select the best lasso model
train <- sample(seq(nrow(ff)), ceiling(nrow(ff) * .8), replace = F)

ff.lasso <- glmnet(x[train, ], y[train], 
                   family = 'binomial')
                   
ff.lasso
#predict on held-out 20% data
ff.predict <- predict(ff.lasso, x[-train, ])



#using cv.glmnet, select best lambda
ff.cv.glmnet <- cv.glmnet(x[train, ], y[train], 
                          family = "binomial", 
                          alpha=1, nfolds=10, 
                          type.measure="auc")

plot(ff.cv.glmnet)
#above plot says, we need around 36 features and CV AUC is ~ .93

lambda.best <- ff.cv.glmnet$lambda.1se
lambda.best

ff.predict <- predict(ff.lasso, x[-train, ], type="class", 
                      s=lambda.best)

# change type to "response" for getting AUC
roc(y[-train], ff.predict)
#AUC is around .9246

table(ff.predict)
coef(ff.cv.glmnet)

#classification accuracy - misclassification error
mean(ff.predict==y[-train])
#[1] 0.857735

#check with measure as AUC
cvfit = cv.glmnet(x[train,], y[train], nfolds = 10,
                  family = "binomial", type.measure = "auc")
plot(cvfit)

ff.predict <- predict(ff.lasso, x[-train, ], type="class", 
                      s=cvfit$lambda.1se)

#classification accuracy - misclassification error
mean(ff.predict==y[-train])
# 0.8584752
#AUC score is around .95

coef(cvfit)


#Predict prob and check AUC
ff.predict <- predict(ff.lasso, x[-train, ], type="response", 
                      s=cvfit$lambda.1se)

#measuing AUC
require(pROC)
roc(as.numeric(y[-train]), ff.predict, plot=T)
#AUC = .9219
# accuracy calculated as: count True and False
table((ff.predict >0.5) == y[-train])
# accu = T/ (T+F)



# Kaggle starter kit talks about using python and hep_ml etc packages

# 2nd attemp using randomForest
train <- fread("C:/Ahmed/ML/Kag2015/Flavours-of-physics/training.csv")
test <- fread("C:/Ahmed/ML/Kag2015/Flavours-of-physics/test.csv")

# remove the ones which are not in test.csv
#setdiff(names(train) , names(test))
#[1] "production"  "signal"      "mass"        "min_ANNmuon"
>
  
toIgnore <- c('id', 'min_ANNmuon', 'production', 'mass')
predictors <- setdiff(names(train), toIgnore)
predictors
target <- c('signal')


#RandomForest in R is very slow vis-a-vis RF in Python
require(randomForest)
ff.train <- sample(seq(nrow(train)), ceiling(nrow(train) * .8), replace = F)
model <- randomForest(factor(signal)~., 
                      data=train[ff.train, predictors, with=F], 
                      importance = T, 
                      ntree=500)

print(model)
varImpPlot(model)
plot(model)

predis <- predict(model, train[-ff.train, predictors, with=F], 
                  type="prob")

#OOB Accuracy is 12.8 with ntree=100 and reduces to 12.41 with ntree=500
#roc(train[-ff.train, "signal", with=F], predis[,2])  #todo
#3rd attempt using GBM
require(gbm)

gbm.model <- gbm(signal~., data=train, 
                 n.trees=1000, 
                 shrinkage = 0.01, 
                 interaction.depth=3, 
                 train.fraction=0.7, 
                 verbose=F, cv.folds=3, n.cores=4)

gbm.model

#filter particular column set for predictors and target
#df[, names(df) != "a"] 
#Or, BTW, you can use within() 
#aq <- within(airquality, rm(Day)) 


#use gbm.fit and find the optimal no of trees
gbm.model.fit <- gbm.fit(x=train[,predictors, with=F],
                         y=train[,"signal", with=F], 
                         n.trees=10000, 
                         shrinkage = 0.005, 
                         interaction.depth=10, 
                         train.fraction=0.7, verbose=T)

#plot cv and train error 
gbm.perf(gbm.model.fit, method="test")
#optimal no of trees =6540, though any value after 2000 looks reasonable 

#plot predic prob vs variable, say for variable no: 7
plot(gbm.model.fit, 7, ntrees=6540, type="response")

#varimp plot using summary()
summary(gbm.model.fit)

summary(gbm.model)
#check AUC for gbm - TODO ???


# 4th attempt using xgboost

require(xgboost)
x=model.matrix(factor(signal)~., data=ff[,predictors, with=F])
y=ff$signal

xg.model <- xgboost(data=x,label=y,max.depth=12, nround=1000,
                    nthread=4, eta=1, print.every.n=25,
                    objective="binary:logistic")

summary(xg.model)

# using xgb.cv
train <- sample(seq(nrow(ff)), ceiling(nrow(ff) * .8), replace = F)

toIgnore <- c('id', 'min_ANNmuon', 'production', 'mass')
predictors <- setdiff(names(ff), toIgnore)
predictors
x=model.matrix(factor(signal)~., data=ff[,predictors, with=F])
y=ff$signal


# xgboost parameters
# https://xgboost.readthedocs.org/en/latest/parameter.html
param <- list("objective" = "binary:logistic",    # multiclass classification 
              "eval_metric" = "error",    # evaluation metric 
              "nthread" = 8,   # number of threads to be used 
              "max_depth" = 6,    # maximum depth of tree 
              "eta" = 0.3,    # step size shrinkage 
              "gamma" = .001,    # minimum loss reduction 
              "subsample" = .7,    # part of data instances to grow tree 
              "colsample_bytree" = .7,  # subsample ratio of columns when constructing each tree 
              "min_child_weight" = 12 , # minimum sum of instance weight needed in a child 
              "lambda"=0.5 ,  # L2 reg / Ridge
              "alpha"=0.5 # L1 reg / Lasso
              )


bst.cv <- xgb.cv(param=param, data=x, label=y, 
                 nfold=5, nrounds=1000, prediction=TRUE,
                 print.every.n=25, verbose=T)


tail(bst.cv$dt) 

# index of minimum error
min.error.idx = which.min(bst.cv$dt[, test.error.mean]) 
min.error.idx


# minimum merror
bst.cv$dt[min.error.idx,]

nrow(bst.cv$dt)
#[1] 1000
#plot error curve: test.merror.mean
plot(bst.cv$dt[, test.error.mean])
#plot all , black - train, green-test error, blue -?
matplot(bst.cv$dt)


# confusion matrix for cv
require(caret)
confusionMatrix(y, as.numeric(bst.cv$pred > 0.5))
# Accuracy is .8858%

roc(y, bst.cv$pred, plot=T)
# AUC is .9509

#predict on test data

preds <- predict(bst.cv, test[,predictors, with=F], 
                 type="prob")
#try cv using caret tunegrid


#use full training data in Xgb and predict on test data, 
# submit to kaggle, for getting final AUC score

# how to calclate weighted AUC score, used by Kaggle?

