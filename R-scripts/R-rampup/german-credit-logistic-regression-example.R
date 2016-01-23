#German credit logistic regression example
# http://www.r-bloggers.com/evaluating-logistic-regression-models/

library(caret)
data(GermanCredit)

Train <- createDataPartition(GermanCredit$Class, p=0.6, list=FALSE)
training <- GermanCredit[ Train, ]
testing <- GermanCredit[ -Train, ]

str(training)
mod_fit <- train(Class ~ Age + ForeignWorker + 
                   Property.RealEstate + Housing.Own + 
                   CreditHistory.Critical, 
                 data=training, method="glm", family="binomial")

mod_fit$finalModel

summary(mod_fit)

predict(mod_fit, newdata=testing)

predict(mod_fit, newdata=testing, type="prob")


mod_fit_one <- glm(Class ~ Age + ForeignWorker + 
                     Property.RealEstate + Housing.Own + 
                     CreditHistory.Critical, 
                   data=training, family="binomial")
mod_fit_one


mod_fit_two <- glm(Class ~ Age + ForeignWorker, 
                   data=training, family="binomial")
mod_fit_two

anova(mod_fit_one, mod_fit_two, test ="Chisq")

library(pscl)
pR2(mod_fit_one)  # look for 'McFadden'

#varImp
varImp(mod_fit)

varImp(mod_fit_one)

varImp(mod_fit_two)


pred = predict(mod_fit, newdata=testing)
accuracy <- table(pred, testing[,"Class"])
sum(diag(accuracy))/sum(accuracy)
## [1] 0.705

pred = predict(mod_fit, newdata=testing)
confusionMatrix(data=pred, testing$Class)

library(pROC)
# Compute AUC for predicting Class with the variable CreditHistory.Critical
f1 = roc(Class ~ CreditHistory.Critical, data=training) 
plot(f1, col="red")
## 
## Call:
## roc.formula(formula = Class ~ CreditHistory.Critical, data = training)
## 
## Data: CreditHistory.Critical in 180 controls (Class Bad) < 420 cases (Class Good).
## Area under the curve: 0.5944
library(ROCR)
# Compute AUC for predicting Class with the model
prob <- predict(mod_fit_one, newdata=testing, type="response")
pred <- prediction(prob, testing$Class)
perf <- performance(pred, measure = "tpr", x.measure = "fpr")
plot(perf)
auc <- performance(pred, measure = "auc")
auc <- auc@y.values[[1]]
auc


ctrl <- trainControl(method = "repeatedcv", 
                     number = 10, savePredictions = TRUE)

mod_fit <- train(Class ~ Age + ForeignWorker + 
                   Property.RealEstate + Housing.Own + 
                   CreditHistory.Critical,  
                 data=GermanCredit, method="glm", family="binomial",
                 trControl = ctrl, tuneLength = 5)

pred = predict(mod_fit, newdata=testing)
confusionMatrix(data=pred, testing$Class)
