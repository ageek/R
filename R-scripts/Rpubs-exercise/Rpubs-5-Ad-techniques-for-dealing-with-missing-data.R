# Rpubs 5- Advanced techniques for dealing with missing data
# chap 15 - R in action
# misc - Dealing with missing data
# 
require(VIM)
require(mice)

# Part 1: 
# Multiple Imputation using MICE
data(sleep, package="VIM")
str(sleep)


is.na(sleep)

# Missing data: ~6%
prop.table(table(is.na(sleep)))


# 42 rows - complete
# 20 rows - with missing data
dim(sleep[complete.cases(sleep),])

#tabulate missing data
md.pattern(sleep)


# visualize 
# The statement aggr(sleep, prop=TRUE, numbers=TRUE) 
# produces the same plot,
# but proportions are displayed instead of counts
aggr(sleep, prop=FALSE, numbers=TRUE)

# matrixplot
matrixplot(sleep)

# shadow matrix 
# You can replace the data
# in a dataset with indicator variables, coded 1 for missing 
# and 0 for present. The resulting
# matrix is sometimes called a shadow matrix

x <- as.data.frame(abs(is.na(sleep)))
head(sleep, n=5)
head(x, n=5)

# extract the variables that have some (but not all) missing values
y <- x[which(apply(x, MARGIN = 2, sum) > 0)]

# check the cor-relation between missing variables
cor(y)

# From the above result:
# NonD and Dream seem to be missing together


# look at the relationship between missing values in a variable and
# the observed values on other variables:
cor(sleep, y, use="pairwise.complete.obs")


#MICE (Multiple Imputation using Chained Eqn)
require(mice)
data(sleep, package="VIM")
imp <- mice(sleep, seed=1234)

fit <- with(imp, lm(Dream ~ Span + Gest))

pooled <- pool(fit)
summary(pooled)

# model with complete cases and compare summary results
sleep.cc <- sleep[complete.cases(sleep), ]
fit.cc <- with (sleep.cc, lm(Dream ~ Span + Gest))
summary(fit.cc)


# imp
imp

# impute values
imp$imp$Dream


# You can view each of the m imputed datasets via the complete() 
# function. The format is

complete(imp, action=3)

# Part 2:
# Multiple Imputation using Amelia
# http://r.iq.harvard.edu/docs/amelia/amelia.pdf

require(Amelia)
data(freetrade)
summary(freetrade)

str(freetrade)

# complete cases: 96 x 10 - Remaining171-96 = 75 are missing
dim(freetrade[(complete.cases(freetrade)), ])

#colm wise count - which colns have max missing
apply(abs(is.na(freetrade)), MARGIN = 2, sum)



# In the presence of missing data, most statistical packages
# use listwise deletion, which removes any row that contains
# a missing value from the analysis

summary(lm(tariff ~ polity +pop +gdp.pc + year + country, 
           data= freetrade))

a.out <- amelia(freetrade, m=5, ts="year", cs="country")

a.out 

# Each of the imputed datasets is now in the list a.out$imputations.
# Thus, we could plot a histogram of the tariff variable from the 3rd 
# imputation,
hist(a.out$imputations[[3]]$tariff, col="grey", border="white")

#plot density for predictors to notice any abnormalities
# plot all
plot(a.out)

#or selectively 
plot(a.out, which.vars = 3:6)


# Overimputing is a technique we have developed to judge the 
# fit of the imputation model

overimpute(a.out, var="tariff")

# We can graph the estimates of each observation against the true 
# values of the observation. On this graph, a y = x line 
# indicates the line of perfect agreement


#Missing map
missmap(a.out)

#get the imputations (all m datasets)
a.out$imputations


# AmeliaView GUI - all the above steps can be done using GUI
AmeliaView()

