# Rpugs 6 - Linear models on German credit Data
require(caret)
require(pROC)

# These data have two classes for the credit worthiness: good or bad
data(GermanCredit)

set.seed(3344)
inTrain <- createDataPartition(GermanCredit$Class, p = .75, list=F)
training <- GermanCredit[inTrain, ]
test <- GermanCredit[-inTrain, ]
dim(training)
dim(test)

table(training$Class)
table(test$Class)


#are there any co-related predictors 
nearZeroVar(GermanCredit)
# 9 15 16 24 25 27 28 30 34 45 47 54 59

# The above predictors should be removed from data(not done below !!!)


# GLM model
glm.model <- glm(Class ~., data=training, family = binomial)
glm.model
summary(glm.model)

pred.glm.model <- predict(glm.model, newdata=test, 
                          type="response")

auc.glm.model <- auc(test$Class, pred.glm.model)


#Next, try various models using caret
fitContorl <- trainControl(method="repeatedcv", 
                           number = 5, 
                           repeats = 10, 
                           classProbs = T, 
                           summaryFunction = twoClassSummary)

set.seed(007)
glm.boost <- train(Class ~., data=training, 
                   method = "glmboost", 
                   trControl  = fitContorl, 
                   tuneLength = 5, 
                   metric = "ROC", 
                   family=Binomial(link=c("logit"))) # missing family (default ) will throw errors

#summary(glm.boost)
pred.glm.boost <- predict(glm.boost, newdata = test, 
                          type="prob")

# get auc
auc.glm.boost <- auc(test$Class, pred.glm.boost[,c("Good")])


# Try CART, conditional inference tree, elastic net, 
# multivariate adaptive regression splines, boosted trees, 
# and random forest.

# cart
cart.model <- train(Class ~., data=training, 
                   method = "rpart", metric="ROC", 
                   trControl = fitContorl, tuneLength=5)

summary(cart.model)

pred.cart.model <- predict(cart.model, newdata = test, 
                           type="prob")

auc.cart.model <- auc(test$Class, pred.cart.model[,c("Good")])


#gbm
gbm.model <- train(Class ~ ., data=training, 
                  method = "gbm", metric="ROC", 
                  trControl = fitContorl, 
                  verbose=T, tuneLength=5)

summary(gbm.model)

pred.gbm.model <- predict(gbm.model, newdata = test, 
                          type="prob")

auc.gbm.model <- auc(test$Class, pred.gbm.model[,c("Good")])



# rf
rf.model <- train(Class ~ ., data=training, 
                   method = "rf", metric="ROC", 
                   trControl = fitContorl, 
                   verbose=T, tuneLength=5)

summary(rf.model)

pred.rf.model <- predict(rf.model, newdata = test, 
                          type="prob")

auc.rf.model <- auc(test$Class, pred.rf.model[,c("Good")])


#xgboost
xgb.model <- train(Class ~ ., data=training, 
                  method = "xgbTree", metric="ROC", 
                  trControl = fitContorl, 
                  verbose=T, tuneLength=5)

summary(xgb.model)

pred.xgb.model <- predict(xgb.model, newdata = test, 
                         type="prob")

auc.xgb.model <- auc(test$Class, pred.xgb.model[,c("Good")])


# plotting auc for all the models

test.auc <- data.frame(model=c("glm","glmboost",
                               "gbm","cart",
                               "rForest", "xgbTree"),
                       auc=c(auc.glm.model, auc.glm.boost, 
                             auc.gbm.model, auc.cart.model, 
                             auc.rf.model, auc.xgb.model))

test.auc <- test.auc[order(test.auc$auc, decreasing=TRUE),]

test.auc$model <- factor(test.auc$model, levels=test.auc$model)

library(ggplot2)
theme_set(theme_gray(base_size = 18))
ggplot(test.auc, aes(x=model, y=auc)) +
  geom_bar(stat="identity", position = "dodge", 
           fill = "light blue", color="red")   # change border to "RED"

# OR using qplot
qplot(x=model, y=auc, data=test.auc, 
      geom="bar", stat="identity", position = "dodge")+
  

#NOTE: The just walks through how to plot AUC for various models, without
# much fine tuning. Note that, for each model, hyperparameters can be
# tuned in various ways and that can change/increase the AUC values
# for these model and order can change drastically, unlike shown above. 
# Hence, before making predictions make sure hyper-parameters are tuned
# properly.
  
  

