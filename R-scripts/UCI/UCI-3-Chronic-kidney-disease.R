# UCI 3 - chronic kidney disease analysis
# 400 samples, 26 predictors
# 2 class (ckd, notckd) classification task

# Original file contains \t in some places which screws up the read.csv
# need to remove them, or use some other trick to ignore them
# ckd <- read.csv("C:/Ahmed/ML/UCI TODO/Chronic_Kidney_Disease - 2015/Chronic_Kidney_Disease/chronic_kidney_disease.arff",
#                 header = F, comment.char="@", na.strings=c("?", ""), 
#                  )

require(dplyr)
require(ggplot2)
require(RWeka)
require(Amelia)


# RWeka handles all the above issues and is very 
# easy to directly read ARFF files

ckd <- read.arff("C:/Ahmed/ML/UCI TODO/Chronic_Kidney_Disease - 2015/Chronic_Kidney_Disease/chronic_kidney_disease_full.arff")

str(ckd)

# A lot of data is missing (see the below Amelia missing plot)
summary(ckd$rbc)


missmap(ckd)

#Phase 1 : Analyze missing data rbc
ckd %>% 
  group_by(class, rbc) %>% 
  summarise(tot=n())

# for pc
ckd %>%
  group_by(class, pc) %>%
  summarize(count=n())  %>%
  ggplot(aes(x=class, y=count, fill=pc)) +
  geom_bar(stat="identity", position="dodge", 
                 color="dark green")+
  geom_text(aes(label=count))  #text value is not showing properly- TODO

# can we conclude: in ckd, there are both normal and abnormal values
# but all normal in notckd, so the missing ones in notckd are normal
# for sure.. in ckd, we have to see, some would be normal and some
# abnormal

dim(ckd[ckd$class=="notckd" & is.na(ckd$pc), ])   # 9 entries only

ckd[ckd$class=="notckd" & is.na(ckd$pc), ]$pc <- "normal"

#now lets do group by of "ckd" type only for NAs
ckd %>%
  filter(class=="ckd") %>%
  group_by(pc) %>%
  summarize(count=n())  %>%
  ggplot(aes(x=pc, y=count, fill=pc)) +
  geom_bar(stat="identity", position="dodge", 
           color="dark green")+
  geom_text(aes(label=count))  #text value is not showing properly- TODO

#how to handle these NAs in "ckd" only category???



# for rbc
ckd %>%
  group_by(class, rbc) %>%
  summarize(count=n())  %>%
  ggplot(aes(x=class, y=count, fill=rbc)) +
  geom_bar(stat="identity", position="dodge", 
           color="dark green")+
  geom_text(aes(label=count))  #text value is not showing properly- TODO

#similar conclusion, all missing in notckd, are normal
# 143 are missing in ckd, some of which will be norm and some abnorm
dim(ckd[ckd$class=="notckd" & is.na(ckd$rbc), ]) # 9 only
ckd[ckd$class=="notckd" & is.na(ckd$rbc), ]$rbc <- "normal"

# for pcc
ckd %>%
  group_by(class, pcc) %>%
  summarize(count=n())  %>%
  ggplot(aes(x=class, y=count, fill=pcc)) +
  geom_bar(stat="identity", position="dodge", 
           color="dark green")+
  geom_text(aes(label=count)) 

# can we conclude: all missing in notckd are notpresent? 
# none aremissing in ckd
ckd[is.na(ckd$pcc),]$pcc <- "notpresent"


missmap(ckd)
# From the missing plot, its clear, that the missing values are mostly
# concentrated count: 150 onwards, i.e. majority of the data missing 
# is for notckd type....

#lets check more , plot missmap for ckd type
missmap(ckd[ckd$class=="ckd",])

#and for notckd type
missmap(ckd[ckd$class=="notckd",])


aggregate(class ~ rbc, data=ckd, length)





