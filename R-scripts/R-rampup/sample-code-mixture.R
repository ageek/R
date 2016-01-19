A=select(train, Sex, Survived, Fare, Pclass, Embarked) %>%
group_by(Pclass, Sex) %>%
summarize(AvgFare=mean(Fare), ProbSurvived=mean(Survived), N=length(Sex))

ggplot(A, aes(x=Pclass, y=ProbSurvived))+
  geom_point(aes(Size=N))+
  geom_line(aes(by=Sex, color=Sex))

ggplot(A, aes(x=Pclass, y=ProbSurvived)) +
  
select(t1, Sepal.Length, Petal.Length, Species) %>%
group_by(Species) %>%
summarize(AvgSepalLengh=mean(Sepal.Length), AvgPetalLength=mean(Petal.Length))

names(getModelInfo())

grep("svm", names(getModelInfo()))

names(getModelInfo())[grep("svm", names(getModelInfo()))]


leaf <- read.csv('C:/Ahmed/aaR/leaf/leaf.csv', header = F)
target <- 'V1'
predictors <- setdiff(names(leaf), target)
split <- sample(1:nrow(leaf), .7*nrow(leaf))
leaf.rpart <- rpart(as.factor(V1)~., data = leaf, subset = split)
leaf.preds <- predict(leaf.rpart, leaf[-split,predictors], method = 'class')
colIndeices <- apply(leaf.preds, 1, which.max)
#measuring accuracy
mean(leaf[-split, target]==colIndeices)


leaf.rf <- train(as.factor(leaf$V1)~.,data = leaf, subset = split, 
                 method='Boruta', 
                 trControl = trainControl(method='boot632',
                                          number = 10),
                 metric = 'Accuracy', 
                 preProcess = c('center', 'scale'), tuneLength = 10)
leaf.preds <- predict(leaf.rf, leaf[-split,predictors], type = 'raw')
confusionMatrix(leaf[-split, target], leaf.preds)
mean(leaf[-split, target]==leaf.preds)

require(doParallel)
registerDoParallel(cores = 2)
require(caret)
#using caret's gbm 
mygrid <- expand.grid(n.trees=50*seq(1,50), 
                      interaction.depth = seq(2,10,2),
                      n.minobsinnode = c(2,10,2),
                      shrinkage=c('.1','.01','.001'))
leaf.gbm <- train(as.factor(leaf[split,]$V1)~., 
                  #data=leaf[split,predictors],
                  leaf[split, predictors], method='gbm', 
                  metric = 'Accuracy',
                  tuneGrid = mygrid,
                  trControl = trainControl(method='boot632', number = 10, repeats = 5),
                  verbose = F)

#directly using gbm 
gbm.leaf <- gbm(as.factor(leaf[split,]$V1)~., 
                n.trees=10000, 
                data = leaf[split, predictors],
                interaction.depth = 2,
                n.minobsinnode = 10,
                shrinkage=.001, 
                cv.folds=3, 
                n.cores=4)


leaf.rpart <- train(as.factor(leaf[split,]$V1)~., 
                  preProcess = c('center','scale'),
                  #data=leaf[split,predictors],
                  leaf[split, predictors], method='rpart' ,
                  tuneLength = 30,
                  #metric = 'Accuracy',
                  trControl = trainControl(method='repeatedcv', repeats = 5
                                           ,summaryFunction='twoClassSummary',
                                           classProbs=T)
                  )

plot(leaf.rpart, scales = list(x=list(log = 10)))
