# Lasso Feature selection
# For parallel processing, register ncores 
require(doParallel)
registerDoParallel(cores = 2)
require(pROC)
require(caret)


arceneTrain <- read.csv("C:/Ahmed/ML/weka-odk/arcene/arc_train.csv - Copy.csv", 
                        header = F, sep = ',')
dim(arceneTrain)
arceneTrain[1:10, 9999:10001]
x = model.matrix(as.factor(V10001)~., data = arceneTrain)
dim(x)
y = arceneTrain$V10001
arcene.lasso <- glmnet(x,y,alpha = 1)
plot(arcene.lasso, xvar='dev', label=T)

plot(arcene.lasso, xvar='lambda', label=T)

# Lasso selected aroiund 100 predictors out of 10K
# these 100 predictors are able to capture ~99.5% deviance
# lets see how it works on validation set

arceneValid <- read.csv("C:/Ahmed//ML//weka-odk//arcene//valid_csv.csv", 
                        header= F, sep=',')
dim(arceneValid)
arceneValid[1:10, 9999:10001]

# make sure you set family='binomial'
# with lasso and #featurs<100 feaures, AUC=.78
# with ridge and #features ~9k, AUC=.79
arcene.cv.lasso <- cv.glmnet(x, y, alpha=0.5, family='binomial',
                             #type.measure='mse',
                             parallel=T)
plot(arcene.cv.lasso)

x_test = model.matrix(as.factor(V10001)~., data = arceneValid)
preds <- predict(arcene.cv.lasso, x_test, type='response')


head(preds)
#for plotting confusion matrix, we need class predictions
preds2 <- predict(arcene.cv.lasso, x_test, type='class')
table(arceneValid[,10001], preds2)
confusionMatrix(arceneValid[,10001], preds)

# AUC
arcene.roc <- roc(arceneValid[,10001], preds)
plot(arcene.roc)



