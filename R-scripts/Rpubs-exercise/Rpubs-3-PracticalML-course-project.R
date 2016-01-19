#Rpubs 3 
# Practical Machine Learning course project 
# https://rpubs.com/eddowh/110893


require(caret)

#consider blank, NA and #DIV/0! as NA in the dataframe
train <- read.csv("C:/Ahmed/ML/dataset local copy/pml-training.csv", 
                  header=T, na.strings=c("", "NA", "#DIV/0!"))

test <- read.csv("C:/Ahmed/ML/dataset local copy/pml-testing.csv", 
                 header=T, na.strings=c("", "NA", "#DIV/0!"))

dim(train)
dim(test)

#100 columns have NAs
table(is.na(train[1,]))

table(sapply(train[1,], function(x) (NA %in% x)))

# this drops rows containing at elast one NA, thus drops all rows
# we just want to drop the columns containing NA, keep the rows
tt <- na.omit(train)
dim(tt)

# this also does the same thing in a different way i.e. drops all rows 
# with NA vlaues
tt <- train[complete.cases(train),]
dim(tt)

#this is how its done, keep non-NA columns and corresponding rows: 
#counts how many NAs in given row
rowSums(is.na(train[121,]))

#this counts how many non-NAs inthe given row
rowSums(!is.na(train[121,]))

#OR
rowSums(is.na(train[121,]))==0

tx <- train[rowSums(is.na(train[,]))==0, ]


#non-missing columns are :
non_missing <- !is.na(train[1,])

#pick the non_missing
# here we are assuming the non_missing columns are consistent across
# rows, else this trickery wont work


tr <- train[, non_missing]
tt <- test[, non_missing]

#cross check
rowSums(is.na(tr[1,]))

rowSums(is.na(tt[1,]))

dim(tr)
dim(tt)

#Note: first column is just blank, rownum. can be dropped

names(tr)
tr <- tr[, 2:60]
tt <- tt[, 2:60]

str(tr)
summary(tr)

# eliminate first 6 columns
tr <- tr[, -(1:6)]
tt <- tt[, -(1:6)]

#data partition

trainIndex <- createDataPartition(train$classe, p=.7, list = F)
                                  
trainData <- tr[trainIndex, ]
validation <- tr[-trainIndex, ]

# print out dimensions of each data sets
rbind(trainData = dim(trainData), validation = dim(validation), test = dim(tt))


#Enable parallel processing 
# process in parallel
library(doParallel)
registerDoSEQ()
cl <- makeCluster(detectCores(), type='PSOCK')
registerDoParallel(cl)

require(randomForest)
system.time(rf.model <- randomForest(classe~., data=trainData, 
                         method="rf")
    )
rf.model

plot(rf.model)
varImpPlot(rf.model)

require(gbm)
system.time(gbm.model <- train(classe~., data=trainData, 
                               method="gbm")
    )

gbm.model
#variable Importance plot
summary(gbm.model)

#predict using RF model
rf.predict <- predict(rf.model, newdata = validation)

#predict using gbm model
gbm.predict <- predict(gbm.model, newdata = validation)
gbm.predict
head(gbm.predict,20)

dim(gbm.predict)

#stack both models
pred.all <- data.frame(rf.predict, gbm.predict, 
                       classe=validation$classe)

#predict using rf for validation data

rf.stacked <- train(classe ~., data=pred.all, 
                    method="rf")

rf.stacked

rf.stacked.predict <- predict(rf.stacked, 
                              newdata = validation)

cmRF <- confusionMatrix(rf.predict, validation$classe)
cmGBM <- confusionMatrix(gbm.predict, validation$classe)
cmStacked <- confusionMatrix(rf.stacked.predict, validation$classe)

cmRF
cmGBM
cmStacked


rf.stacked
rf.model
gbm.model


# create results/analysis table
analysis_table <- data.frame("Model" = c("Random Forest",
                                         "Generalized Boosted Trees",
                                         "Random Forest + GBM Stacked"),
                             "Accuracy" = 100 * c(cmRF$overall[[1]],
                                                  cmGBM$overall[[1]],
                                                  cmStacked$overall[[1]]))

ggplot(data = analysis_table, aes(x=Model, y=Accuracy))+
  geom_bar(stat="identity", 
           aes(fill= Accuracy== max(Accuracy)), 
           position = position_dodge()) +
  scale_fill_discrete(guide='none') +
  labs(x="Model", 
       y="Rate %", 
       title="Model Accuracy") +
  coord_flip()
    

# using XGBTRee
# caret needs to be updated to dev version to support xgbtree
#xgb.model <- train(classe ~. data=trainData, method="xgbTree") 
    
require(xgboost)
dtrain <- xgb.DMatrix(trainData, label=trainData$classe)
x <- model.matrix(classe ~., data = trainData)
y <- trainData$classe

history <- xgb.cv(data = x, nround=3, nthread = 2, 
                  nfold = 5, 
                  metrics=list("rmse","auc"),
                  max.depth =3, eta = 1, 
                  objective = "binary:logistic")
print(history)