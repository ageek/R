# Helper functions to be used in conjuction with Caret package

# 1. quickly run multiple models using caret, predict on held-out
# dataset and measure AUC
# finally, plot all the AUC in ggplot


compareModels <- function(dataset, targetIndex, 
                          tunel=3, heldout=.3, 
                          verbose = T, modelList, 
                          trueOne) {
# compareModels <- function(dataset) {
#   targetIndex <- 1
#   tunel <- 3
#   heldout <- 0.3
#   verbose <- T
#   modellist <- c("gbm")
#   trueOne <- "yes"
  require(caret)
  require(pROC)
  
  set.seed(2211)
  target <- names(dataset[,targetIndex:targetIndex, drop=F])
  
  print(target)
  inTrain <- createDataPartition(dataset[,targetIndex], 
                                 p = (1 - heldout), 
                      list = F)
  
  train <- dataset[inTrain, ]
  test <- dataset[-inTrain, ]
  
  print(dim(train))
  print(dim(test))
  
  #for collecting results
  res <- rep(0, length(modelList))
  
  fitControl <- trainControl(method = "repeatedcv", 
                             number = 5, 
                             repeats = 5, 
                             classProbs = T, 
                             summaryFunction = twoClassSummary, 
                             verboseIter = verbose)
  i <- 1
  for (mod in modelList) {
    # create model
    print(mod)
     #myModel <- train(x=train[,-targetIndex], y=train[,targetIndex], 
    #myModel <- train(card~.,  data = CreditCard,
    # above/other options dont work with xgbTree
    myModel <- train(reformulate(c("."), target), data = train,
                     metric = "ROC", 
                     tuneLength = tunel, 
                     method = mod,
                     #glmnet and some other model errors out 
                     # with verbose
                     #verbose = verbose,
                     trControl = fitControl)
    
    print(myModel)
    
    # make prediction
    myPreds <- predict(myModel, newdata = test, 
                       type="prob")
    
    # get AUC value
    myAUC <- auc(test[,target], myPreds[,trueOne])
    myAUC
    roc(test[,target], myPreds[,trueOne], plot=T)
    
    #save results
    
    res[i] <- myAUC
    i <- i+1
  }
  
  allres <- data.frame(Method=modelList, AUC=res)
  print(allres)
  
  #ggplot for all results
  p <- ggplot(allres, aes(x=Method, y=AUC)) +
    geom_bar(stat="identity", fill="light blue", color="green") +
    ggtitle("AUC histogram for various methods") +
    geom_text(aes(label=AUC))
  
  #when inside a function/loop, explicit priting of ggplot is needed
  print(p)
  return(allres)
}


# Multiclass version without ROC/AUC - TODO -- just copied the above code
# need to update it properly

compareModelsMC <- function(dataset, targetIndex, 
                          tunel=3, heldout=.3, 
                          verbose = T, modelList, 
                          trueOne) {

  require(caret)
  require(pROC)
  
  set.seed(2211)
  target <- names(dataset[,targetIndex:targetIndex, drop=F])
  
  print(target)
  inTrain <- createDataPartition(dataset[,targetIndex], 
                                 p = (1 - heldout), 
                                 list = F)
  
  train <- dataset[inTrain, ]
  test <- dataset[-inTrain, ]
  
  print(dim(train))
  print(dim(test))
  
  #for collecting results
  res <- rep(0, length(modelList))
  
  fitControl <- trainControl(method = "repeatedcv", 
                             number = 5, 
                             repeats = 5, 
                             classProbs = T, 
                             summaryFunction = defaultSummary, 
                             verboseIter = verbose)
  i <- 1
  for (mod in modelList) {
    # create model
    print(mod)
    #myModel <- train(x=train[,-targetIndex], y=train[,targetIndex], 
    #myModel <- train(card~.,  data = CreditCard,
    # above/other options dont work with xgbTree
    myModel <- train(reformulate(c("."), target), data = train,
                     metric = "ROC", 
                     tuneLength = tunel, 
                     method = mod,
                     #glmnet and some other model errors out 
                     # with verbose
                     #verbose = verbose,
                     trControl = fitControl)
    
    print(myModel)
    
    # make prediction
    myPreds <- predict(myModel, newdata = test, 
                       type="prob")
    
    # get AUC value
    myAUC <- auc(test[,target], myPreds[,trueOne])
    myAUC
    roc(test[,target], myPreds[,trueOne], plot=T)
    
    #save results
    
    res[i] <- myAUC
    i <- i+1
  }
  
  allres <- data.frame(Method=modelList, AUC=res)
  print(allres)
  
  #ggplot for all results
  p <- ggplot(allres, aes(x=Method, y=AUC)) +
    geom_bar(stat="identity", fill="light blue", color="green") +
    ggtitle("AUC histogram for various methods") +
    geom_text(aes(label=AUC))
  
  #when inside a function/loop, explicit priting of ggplot is needed
  print(p)
  return(allres)
}


# check with Credticard data
#compareModels(CreditCard, 1, 3, 0.3, T, c("xgbTree","gbm", "rf"),
#              "Good")

# with GermanCredit data
t <- compareModels(GermanCredit, 10, 3, 0.3, F, 
                   # data preprocessing needed for svm, NN etc
                   c("C5.0", "gbm", "xgbTree"), 
              "Good")


ckd <- read.csv("C:/Ahmed/ML/UCI TODO/Chronic_Kidney_Disease - 2015/Chronic_Kidney_Disease/chronic_kidney_disease.arff",
                header = F, comment.char="@", na.strings=c("?", ""), 
)

compareModels(na.omit(ckd), 25, 3, 0.3, T, c("gbm", "rf", "xgbTree"), 
              "notckd")
