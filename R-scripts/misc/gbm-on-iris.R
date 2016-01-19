#GBM - Iris
require(psych)
require(gbm)
require(caret)

# splitData <- function(data, target, prob, isList=F) {
#   inTrain <- createDataPartition(target, prob =p, list = isList)
#   train <- data[inTrain, ]
#   test <- data[-inTrain, ]
#   
# }
inTrain <- createDataPartition(iris$Species, p = .75, list = F)

train <- iris[inTrain, ]
test <- iris[-inTrain, ]

getAcc <- function(preds, test) {
  preds.matrix <- matrix(preds, nrow=36)
  
  #convert from class prob to class levels 
  apply(preds.matrix, MARGIN = 1, which.max)
  
  #or directly class names
  #http://stackoverflow.com/questions/23413570/r-is-there-any-way-to-extract-class-predictions-form-gbm
  preds.class <- colnames(preds)[apply(preds.matrix, MARGIN = 1, which.max)]
  
  confusionMatrix(test$Species, preds.class)
}

set.seed(444)
gbm1 <- gbm(Species ~., data=train, 
            shrinkage = .2,
            n.trees=23,  # n.trees can be determined from gbm.perf() plot
            n.minobsinnode =10,
            interaction.depth=1,
            cv.folds = 3, 
            verbose =T)

preds <- predict(gbm1, newdata = test, 
                 n.trees=5, 
                 type="response")

getAcc(preds, test)
gbm.perf(gbm1, method="cv", plot.it = T)

#using caret
set.seed(444)
tGrid2 <- expand.grid(interaction.depth=c(1,3,5,7,9,10), 
                      n.trees = c(50, 100), 
                      shrinkage = c(.01, .05, .1), 
                      n.minobsinnode = c(2,5,8,10,12)

#for metric=ROC, trainControl (classProbs=T) is needed
trCtrl <- trainControl(method="boot", 
                       number = 3, 
                       classProbs = T,
                       summaryFunction = defaultSummary,
                       allowParallel = T)

gbm2 <- train(Species ~., data=train, 
              method="gbm", metric="ROC", verbose = T,
              tuneGrid = tGrid2,
              trControl = trCtrl)
gbm2
#gbm.perf(gbm2, plot.it = T)
