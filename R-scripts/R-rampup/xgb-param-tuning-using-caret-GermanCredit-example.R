#XGB param tuning using Caret - GermanCredit Example
#https://stats.stackexchange.com/questions/171043/how-to-tune-hyperparameters-of-xgboost-trees

library(caret)
library(xgboost)
library(readr)
library(dplyr)
library(tidyr)

setwd("C:/Ahmed/ML/Kag2011/GiveMeSomeCredit/")

# load in the training data
df_train = read_csv("./cs-training.csv") %>%
  na.omit() %>%                                                                # listwise deletion 
  select(-`NA`) %>%
  mutate(SeriousDlqin2yrs = factor(SeriousDlqin2yrs,                           # factor variable for classification
                                   labels = c("Failure", "Success")))

df_train$SeriousDlqin2yrs <- as.integer(df_train$SeriousDlqin2yrs)-1
# xgboost fitting with arbitrary parameters
xgb_params_1 = list(
  objective = "binary:logistic",                                               # binary classification
  eta = 0.01,                                                                  # learning rate
  max.depth = 3,                                                               # max tree depth
  eval_metric = "auc"                                                          # evaluation/loss metric
)

# fit the model with the arbitrary parameters specified above
xgb_1 = xgboost(data = as.matrix(df_train %>%
                                   select(-SeriousDlqin2yrs)),
                label = df_train$SeriousDlqin2yrs,
                params = xgb_params_1,
                nrounds = 100,                                                 # max number of trees to build
                verbose = TRUE,                                         
                print.every.n = 5
                #early.stop.round = 10                                          # stop if no improvement within 10 trees
)

# cross-validate xgboost to get the accurate measure of error
xgb_cv_1 = xgb.cv(params = xgb_params_1,
                  data = as.matrix(df_train %>%
                                     select(-SeriousDlqin2yrs)),
                  label = df_train$SeriousDlqin2yrs,
                  nrounds = 2500, 
                  nfold = 10,                                                   # number of folds in K-fold
                  prediction = TRUE,                                           # return the prediction using the final model 
                  showsd = TRUE,                                               # standard deviation of loss across folds
                  stratified = TRUE,                                           # sample is unbalanced; use stratified sampling
                  verbose = TRUE,
                  print.every.n = 10
                  #early.stop.round = 10
)

# plot the AUC for the training and testing samples
xgb_cv_1$dt %>%
  select(-contains("std")) %>%
  mutate(IterationNum = 1:n()) %>%
  gather(TestOrTrain, AUC, -IterationNum) %>%
  ggplot(aes(x = IterationNum, 
             y = AUC, 
             group = TestOrTrain, 
             color = TestOrTrain)) + 
  geom_line() + 
  theme_bw()

############Marking the max AUC points on ggplot###############
p <- xgb_cv_1$dt %>% select(-contains("std"))

#find the max for both train and test  and mark on the plot
ss <- p %>%
  mutate(Iteration = 1:n())

head(ss)
#subset data for max AUC in test
test_max <- ss[which(test.auc.mean==max(test.auc.mean)),][1] %>%
  select(-train.auc.mean)
#in test
train_max <- ss[which(train.auc.mean==max(train.auc.mean)),][1] %>%
  select(-test.auc.mean)

p %>%
  mutate(Iteration = 1:n()) %>%
  gather(TestTrain, AUC, -Iteration) %>%  
  ggplot(aes(x=Iteration, y=AUC,  color=TestTrain)) +
  geom_line() +
  geom_point(data = train_max, 
             aes(x=Iteration, y=train.auc.mean), 
             color ="red", size=5) +
  #geom_text(data=tt, aes(x=Iteration, y=AUC), label="Max-AUC-train") +
  geom_point(data = test_max, 
             aes(x=Iteration, y=test.auc.mean), 
             color ="green", size=5) +
  #geom_text(data = test_max, label="Max-AUC-test") +
  theme_gray()
