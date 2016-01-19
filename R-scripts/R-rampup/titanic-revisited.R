# load libraries
library(caret)
library(pROC)

#################################################
# data prep
#################################################

# load data
titanicDF <- read.csv('http://math.ucdenver.edu/RTutorial/titanic.txt',sep='\t')
titanicDF$Title <- ifelse(grepl('Mr ',titanicDF$Name),'Mr',ifelse(grepl('Mrs ',titanicDF$Name),'Mrs',ifelse(grepl('Miss',titanicDF$Name),'Miss','Nothing'))) 
titanicDF$Age[is.na(titanicDF$Age)] <- median(titanicDF$Age, na.rm=T)

# miso format
titanicDF <- titanicDF[c('PClass', 'Age',    'Sex',   'Title', 'Survived')]

# dummy variables for factors/characters
titanicDF$Title <- as.factor(titanicDF$Title)
titanicDummy <- dummyVars("~.",data=titanicDF, fullRank=F)
titanicDF <- as.data.frame(predict(titanicDummy,titanicDF))
print(names(titanicDF))


# what is the proportion of your outcome variable?
prop.table(table(titanicDF$Survived))

# save the outcome for the glmnet model
tempOutcome <- titanicDF$Survived  

# generalize outcome and predictor variables
outcomeName <- 'Survived'
predictorsNames <- names(titanicDF)[names(titanicDF) != outcomeName]

#################################################
# model it
#################################################
# get names of all caret supported models 
names(getModelInfo())

titanicDF$Survived <- ifelse(titanicDF$Survived==1,'yes','nope')

# pick model gbm and find out what type of model it is
getModelInfo()$gbm$type

# split data into training and testing chunks
set.seed(1234)
splitIndex <- createDataPartition(titanicDF[,outcomeName], p = .75, list = FALSE, times = 1)
trainDF <- titanicDF[ splitIndex,]
testDF  <- titanicDF[-splitIndex,]

# create caret trainControl object to control the number of cross-validations performed
objControl <- trainControl(method='cv', number=3, returnResamp='none', summaryFunction = twoClassSummary, classProbs = TRUE)


# run model
objModel <- train(trainDF[,predictorsNames], as.factor(trainDF[,outcomeName]), 
                  method='gbm', 
                  trControl=objControl,  
                  metric = "ROC",
                  preProc = c("center", "scale"))


# find out variable importance
summary(objModel)

# find out model details
objModel

#################################################
# evalutate model
#################################################
# get predictions on your testing data

# class prediction
predictions <- predict(object=objModel, testDF[,predictorsNames], type='raw')
head(predictions)
postResample(pred=predictions, obs=as.factor(testDF[,outcomeName]))

# probabilities 
predictions <- predict(object=objModel, testDF[,predictorsNames], type='prob')
head(predictions)
postResample(pred=predictions[[2]], obs=ifelse(testDF[,outcomeName]=='yes',1,0))
auc <- roc(ifelse(testDF[,outcomeName]=="yes",1,0), predictions[[2]])
print(auc$auc)


################################################
# glmnet model
################################################

# pick model gbm and find out what type of model it is
getModelInfo()$glmnet$type

# save the outcome for the glmnet model
titanicDF$Survived  <- tempOutcome

# split data into training and testing chunks
set.seed(1234)
splitIndex <- createDataPartition(titanicDF[,outcomeName], p = .75, list = FALSE, times = 1)
trainDF <- titanicDF[ splitIndex,]
testDF  <- titanicDF[-splitIndex,]

# create caret trainControl object to control the number of cross-validations performed
objControl <- trainControl(method='cv', number=3, returnResamp='none')

# run model
objModel <- train(trainDF[,predictorsNames], trainDF[,outcomeName], method='glmnet',  metric = "RMSE", trControl=objControl))

# get predictions on your testing data
predictions <- predict(object=objModel, testDF[,predictorsNames])


library(pROC)
auc <- roc(testDF[,outcomeName], predictions)
print(auc$auc)

#
titanic <- read.csv("C:/Ahmed/ML/dataset local copy/titanic.csv", 
                    header=T, sep=",")
predictors <- c("pclass", "age", "embarked", "sex")
target <- 'survived'

titanic$age[is.na(titanic$age)] <- median(titanic$age, na.rm=T)
X <- titanic[,predictors]
y <- titanic[,target]


train_x <- X[1:1000,]
test_x <- X[1001:nrow(titanic),]

train_y <- y[1:1000]
test_y <- y[1001:nrow(titanic)]

rf.titanic <- train(train_x, as.factor(train_y), 
                    method="rf", importance=T)
preds <- predict(rf.titanic, test_x)
confusionMatrix(test_y, preds)
varImp(rf.titanic)


gbm.titanic <- train(train_x, as.factor(train_y), method="gbm")
gbm.preds <- predict(rf.titanic, test_x)
confusionMatrix(test_y, gbm.preds)
varImp(gbm.titanic)


for (ix in colnames(titanic)) {
  print (ix)
  print (table(titanic$ix))
}

require(tidyr)
require(dplyr)
require(ggplot2)

titanic <- read.csv("C:/Ahmed/ML/dataset local copy/titanic.csv", 
                    header=T, sep=",")

titanic %>%
  group_by(pclass,sex,survived) %>%
  ggplot(aes(x=pclass, fill=factor(survived))) +
  geom_histogram() +
  facet_wrap(~sex)

# Survival count for each pclass vs sex
# 
titanic %>%
  group_by(pclass) %>%
  mutate(Total = n()) %>%
  group_by(pclass, sex) %>%
  mutate(Ratio_Gender=n()/Total) %>%
  group_by(pclass, sex, survived) %>%
  mutate(N=n()) %>%
  select(Total, Ratio_Gender, N) %>%
  summarize(N=n())

# output
Source: local data frame [12 x 4]
Groups: pclass, sex
pclass    sex survived   N
1     1st female        0   9
2     1st female        1 134
3     1st   male        0 120
4     1st   male        1  59
5     2nd female        0  13
6     2nd female        1  94
7     2nd   male        0 148
8     2nd   male        1  25
9     3rd female        0 134
10    3rd female        1  79
11    3rd   male        0 440
12    3rd   male        1  58

# OR
# What percentage of people survived from each class & gender-wise etc
titanic %>%
  group_by(pclass, sex) %>%
  mutate(Total_Gender=n()) %>%
  select(pclass, sex, Total_Gender, survived) %>%
  group_by(pclass, sex, survived) %>%
  mutate(Gender_Survived_Ratio=n()/Total_Gender) %>%
  select(pclass, sex, Total_Gender, survived, Gender_Survived_Ratio) %>%
  ungroup() %>%
  group_by(pclass, sex, Total_Gender,survived, Gender_Survived_Ratio) %>%
  arrange(desc(Gender_Survived_Ratio)) %>%
  summarize()

#output
Source: local data frame [12 x 5]
Groups: pclass, sex, Total_Gender, survived

pclass    sex Total_Gender survived Gender_Survived_Ratio
1     1st female          143        0            0.06293706
2     1st female          143        1            0.93706294
3     1st   male          179        0            0.67039106
4     1st   male          179        1            0.32960894
5     2nd female          107        0            0.12149533
6     2nd female          107        1            0.87850467
7     2nd   male          173        0            0.85549133
8     2nd   male          173        1            0.14450867
9     3rd female          213        0            0.62910798
10    3rd female          213        1            0.37089202
11    3rd   male          498        0            0.88353414
12    3rd   male          498        1            0.11646586


titanic %>%
  select(pclass, sex, survived) %>%
  group_by(pclass) %>%
  mutate(Class_Size=n())

titanic %>%
  filter(sex=='female' & survived=='0' & pclass=='1st') %>%
  nrow()
  
