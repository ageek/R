# R in Action examples
#sqldf 
#Page 103
require(sqldf)
newdf <- sqldf("select * from mtcars where carb=1 order by mpg", 
               row.names=T)
newdf
head(mtcars)
order(mtcars[mtcars$carb==1, ])

dim(newdf)


sqldf("select avg(mpg) as avg_mpg, avg(disp) as avg_disp,
      gear from mtcars where cyl in (4,6) group by gear")

#using dplyr
require(dplyr)
mtcars %>%
  filter(cyl==4 | cyl==6) %>%
  group_by(gear) %>%
  summarize(avg_mpg=mean(mpg), avg_disp=mean(disp))



# useful examples

student <- c("John Davis", "Angela Williams", "Bullwinkle Moose",
              "David Jones", "Janice Markhammer", "Cheryl Cushing",
              "Reuven Ytzrhak", "Greg Knox", "Joel England",
              "Mary Rayburn")
student
[1] "John Davis"        "Angela Williams"   "Bullwinkle Moose" 
[4] "David Jones"       "Janice Markhammer" "Cheryl Cushing"   
[7] "Reuven Ytzrhak"    "Greg Knox"         "Joel England"     
[10] "Mary Rayburn"     

strsplit(student, " ")

names <- strsplit(student, " ")

firstname <- sapply(names, "[", 1)
lastname <- sapply(names, "[", 2)


# from R in action - page 103 example

options(digits=2)
Student <- c("John Davis", "Angela Williams", "Bullwinkle Moose",
               "David Jones", "Janice Markhammer", "Cheryl Cushing",
               "Reuven Ytzrhak", "Greg Knox", "Joel England",
               "Mary Rayburn")
Math <- c(502, 600, 412, 358, 495, 512, 410, 625, 573, 522)
Science <- c(95, 99, 80, 82, 75, 85, 80, 95, 89, 86)
English <- c(25, 22, 18, 15, 20, 28, 15, 30, 27, 18)
roster <- data.frame(Student, Math, Science, English,
                       stringsAsFactors=FALSE)
z <- scale(roster[,2:4])
score <- apply(z, 1, mean)
roster <- cbind(roster, score)

y <- quantile(score, c(.8,.6,.4,.2))
roster$grade[score >= y[1]] <- "A"
roster$grade[score < y[1] & score >= y[2]] <- "B"
roster$grade[score < y[2] & score >= y[3]] <- "C"
roster$grade[score < y[3] & score >= y[4]] <- "D"
roster$grade[score < y[4]] <- "F"
name <- strsplit((roster$Student), " ")
lastname <- sapply(name, "[", 2)
firstname <- sapply(name, "[", 1)
roster <- cbind(firstname,lastname, roster[,-1])
roster <- roster[order(lastname,firstname),]
roster


# page  149
require(vcd)
head(Arthritis)

> mean(Arthritis[Arthritis$Sex=='Male', ]$Age)
[1] 53
> mean(Arthritis[Arthritis$Sex=='Female', ]$Age)
[1] 53.50847

#using dplyr
require(dplyr)
Arthritis %>%
  select(Sex, Age) %>%
  group_by(Sex) %>%
  summarize(mean_age=mean(Age))

#using sqldf
require(sqldf)
sqldf("Select avg(Age) as mean_age from Arthritis
                group by Sex")


#page 150
table(Arthritis$Sex, Arthritis$Improved)
with(Arthritis, table(Sex, Improved))

with(Arthritis, table(Improved))
with(Arthritis, table(Sex, Improved))
prop.table(with(Arthritis, table(Sex, Improved)))

mytable <- with(Arthritis, table(Sex, Improved))
prop.table(mytable)

#in 100% values
prop.table(mytable) *100

prop.table(with(Arthritis, table(Improved)))

with(Arthritis, xtabs(~Sex+Improved))
with(Arthritis, table(Sex, Improved))

#collapse variable no 2 i.e Sex
margin.table(mytable, 2)
#collapse variable no 1, i.e. Improved
margin.table(mytable, 1)

addmargins(mytable, 1)

addmargins(mytable, 2)

require(gmodels)
with(Arthritis, CrossTable(Sex, Improved))

with(Arthritis, CrossTable(Sex, Treatment))

with(Arthritis, ftable(Sex, Treatment, Improved))

prop.table(with(Arthritis, ftable(Treatment, Sex, Improved))) * 100

addmargins(prop.table(with(Arthritis, ftable(Treatment, Sex, Improved))) * 100)

#using basic ftable
mytable <- with(Arthritis, ftable(Treatment, Improved, Sex))
mytable

margin.table(mytable, 1)

#using xtabs
mytab <- xtabs(~Treatment+Sex+Improved, data=Arthritis)
mytab

ftable(mytab)

margin.table(mytab, 1)
margin.table(mytab, 2)
margin.table(mytab, 3)
class(mytab)
class(mytable)

margin.table(mytab, c(1,3))
#same using ftble, 
with(Arthritis, ftable(Treatment, Improved))

#for further processing ftable object wont work, you need
# basic xtabs and table object only

prop.table(mytab, c(1,2))

#1--this gives %age for each row, i.e. sum of row%age=100
ftable(prop.table(mytab, c(1,2)))
#or direclty - not working ???
ftable(with(Arthritis, prop.table(table(Treatment, Sex, Improved)))) * 100

#2--this gives %age of total data, sum of all%ages=100
prop.table(ftable(mytab, c(1,2)))

#or directly
prop.table(with(Arthritis, ftable(Treatment, Sex, Improved))) * 100

ftable(mytab, c(1,2))


#page 156
xt <- xtabs(~Treatment+Sex, data=Arthritis)
chisq.test(xt)

xt <- xtabs(~Treatment+Improved, data=Arthritis)
chisq.test(xt)

#wotn work for 3 at a time
xt <- xtabs(~Treatment+Improved+Sex, data=Arthritis)
chisq.test(xt)


#Function to convert Contigency table/Xtabs data to dataframe
# page 159
table2flat <- function(mytable) {
  df <- as.data.frame(mytable)
  rows <- dim(df)[1]
  cols <- dim(df)[2]
  x <- NULL
  for (i in 1:rows){
    for (j in 1:df$Freq[i]){
      row <- df[i,c(1:(cols-1))]
      x <- rbind(x,row)
    }
  }
  row.names(x)<-c(1:dim(x)[1])
  return(x)
}
##############
table2flat(mytab)

state <- state.x77[,1:6]
cov(state)

require(psych)
pairs.panels(state)

cor(state)
require(car)

scatterplotMatrix(state)

corr.test(state, use='complete')


# page 180
dataset(woman)

states <- as.data.frame(state.x77[,c("Murder", "Population", "Illiteracy", 
                       "Income", "Frost")])
require(car)
dim(states)
cor(states)
scatterplotMatrix(states)

fit <- lm(Murder ~ Population +Illiteracy+Income+Frost, data=states)
summary(fit)

fit <- lm(mpg ~ hp+wt+hp:wt, data=mtcars)
summary(fit)

confint(fit)

confint(fit2)

par(mfrow=c(2,2))
fit <- lm(weight~height,data=women)
plot(fit)

crPlots(fit)
ncvTest(fit)
spreadLevelPlot(fit)

#global validation of linear model - single go/no-go check for 
# linear models
require(gvlma)
gvmodel <- gvlma(fit)
summary(gvmodel)

fit3 <- lm(Murder ~ Population +Illiteracy+Income+Frost, data=states)
summary(fit3)
vif(fit3)
sqrt(vif(fit3)) > 2

outlierTest(fit3)

influencePlot(fit3, id.method="identify")

fit3 <- lm(Murder ~ Population +Illiteracy+Income+Frost, data=states)
fit2 <- lm(Murder ~ Population +Illiteracy, data=states)
AIC(fit2, fit3)

#stepwise regression, forward or backward direction
require(MASS)
fit1 <- lm(Murder ~ Population +Illiteracy+Income+Frost, data=states)
stepAIC(fit1, direction = 'backward')

require(leaps)

leaps <- regsubsets(Murder ~ Population +Illiteracy+
                        Income+Frost, data=states, nbest=4)

plot(leaps, scale="adjr2")

