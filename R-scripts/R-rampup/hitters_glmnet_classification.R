# Hitters Classification task

#rm(list = ls(all=T))
library(ISLR)
library(glmnet)

Hitters=na.omit(Hitters)

# Binary proble - Logistic regression
Hitters$Salary <- ifelse(Hitters$Salary > 1000, 1, 0)
Hitters$Salary <- as.factor(Hitters$Salary)

# the class is unbalanced
# > table(Hitters$Salary)
# 0   1 
# 233  30 

# cls <- sapply(Hitters, class)
# for(j in names(cls[cls == 'integer'])) Hitters[,j] <- as.double(Hitters[,j])

x = model.matrix(~ . -1, Hitters[,names(Hitters)[!names(Hitters) %in% c('Salary')]] )

inx_train <- 1:200
inx_test <- 201:dim(Hitters)[1]

x_train <- x[inx_train, ]
x_test <- x[inx_test, ]
y_train <- Hitters[inx_train, c('Salary')]
y_test <- Hitters[inx_test, 'Salary']

fit = cv.glmnet(x=x_train, y=y_train, alpha=1, type.measure='auc', family = "binomial")
plot(fit)

#prediction probability
pred = predict(fit, s='lambda.min', newx=x_test, type='response')

head(pred)
res <- ifelse(pred > 0.5, 1,0)
table(y_test)
table(res)

#1 item mis classified
