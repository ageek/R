# Rpubs 2
# Public health and economic impacts of storm events 
# https://rpubs.com/julienfbeaulieu/pa2
# NB: There is no prediction task as such, just analysis of strom data

data <- read.csv("C:/Ahmed/ML/dataset local copy/repdata-data-StormData.csv")

dim(data)
str(data)
names(data)

require(dplyr)
require(ggplot2)
require(data.table)

head(data)

#statewise distribution of data
table(data$STATE)

#The data comprise observations from the year 1950 to the year 2011.
# The following histograms shows the total number of storm events 
# recorded for each year in the dataset:
t <- "11/15/1951 0:00:00"

p <- as.Date(t, format="%m/%d/%Y %H:%M:%S")   #Note Y is in caps, else it wont work and throw NA
#extract year
as.numeric(format(p, "%Y"))

data <- mutate(data, year=as.numeric(format(as.Date(BGN_DATE, format="%m/%d/%Y %H:%M:%S"), "%Y")))

table(data$year)

#using ggplot2
data %>%
  ggplot(aes(x=year))+
  #one plot for each year, set binwidth=1
  geom_histogram(color="black", fill="white", binwidth=1) +
  xlab("Year") +
  ylab("Frequency") +
  ggtitle("Strom count for each year") 
  #+ coord_flip()    //if you want horizontal plots - try it out

#using standard hist() plot
n_years <- max(data$year) - min(data$year) + 1
hist(data$year, breaks=n_years, xlab="year", main="Number of storm events recorded for each year")



# pick data after 1995 

data95 <- filter(data, year >= 1995)
table(data95$year)

#for data.table
dt95 <- data.table(data95)
dt <- data.table(data)

#A second issue with the dataset is that the crop damage and 
#property damage are reported in different units of dollars. 
#Namely, the "B" exponent is used to express "Billons"","M" for
# "Millions", "K" for "Thousands" and "H" for "Hundreds"

#Property exp
data95$propexp <- 0
data95$propexp[toupper(data95$PROPDMGEXP) == "B"] <- 9
data95$propexp[toupper(data95$PROPDMGEXP) == "M"] <- 6
data95$propexp[toupper(data95$PROPDMGEXP) == "K"] <- 3
data95$propexp[toupper(data95$PROPDMGEXP) == "H"] <- 2

#Crop exp
data95$cropexp <- 0
data95$cropexp[toupper(data95$CROPDMGEXP) == "B"] <- 9
data95$cropexp[toupper(data95$CROPDMGEXP) == "M"] <- 6
data95$cropexp[toupper(data95$CROPDMGEXP) == "K"] <- 3
data95$cropexp[toupper(data95$CROPDMGEXP) == "H"] <- 2

data95$property <- data95$PROPDMG*10^(data95$propexp)
data95$crop <- data95$CROPDMG*10^(data95$cropexp)


#year wise proerty damage
xtabs(data95$property~data95$year)



aggregate(data95$FATALITIES, by=list(data95$EVTYPE), 
          FUN = "sum")  
#total fatality count for each type
event.fatalities <- aggregate(data$FATALITIES, by = list(data$EVTYPE), FUN = "sum")
names(event.fatalities) <- c("type","fatalities")
event.fatalities <- arrange(event.fatalities, desc(fatalities))
head(event.fatalities, n = 10)

#or using dplyr
data95 %>%
  group_by(EVTYPE) %>%
  summarize(Total=sum(FATALITIES)) %>%
  arrange(desc(Total))

#for full data
data %>%
  group_by(EVTYPE) %>%
  summarize(Total=sum(FATALITIES)) %>%
  arrange(desc(Total))


#grouping by INJURIES
event.injuries <- aggregate(data$INJURIES, by = list(data$EVTYPE), FUN = "sum")
names(event.injuries) <- c("type","injuries")
event.injuries <- arrange(event.injuries, desc(injuries))
head(event.injuries, n = 10)

#using dplyr
data95 %>%
  group_by(EVTYPE) %>%
  summarise(Total_Injuries=sum(INJURIES)) %>%
  arrange(desc(Total_Injuries)) %>%
  head(10)

#using data.table
dt95[, .(Total_Injuries=sum(INJURIES)), by=.(EVTYPE)][order(-Total_Injuries)]

#for full data
# ordr by desc(total), select top 10 only
dt[, .(Total_Injuries=sum(INJURIES)), by=.(EVTYPE)
   ][order(-Total_Injuries)
     ][1:10]


# property damage by evttype
#using aggregate (property is available in data95 only)
event.property <- aggregate(data95$property, by = list(data95$EVTYPE), FUN = "sum")
names(event.property) <- c("type","property.damage")
event.property <- arrange(event.property, desc(property.damage))
head(event.property, n = 10)


#using dplyr
data95 %>%
  group_by(EVTYPE) %>%
  summarize(Total_damage=sum(property)) %>%
  arrange(desc(Total_damage)) %>%
  head(10)

#using data.table
dt95[, .(Total_damage=sum(property)), 
     by=.(EVTYPE)][order(-Total_damage)
                   ][1:10]

#crop damage
event.crop <- aggregate(data95$crop, by = list(data95$EVTYPE), FUN = "sum")
names(event.crop) <- c("type","crop.damage")
event.crop <- arrange(event.crop, desc(crop.damage))
head(event.crop, n = 10)

#using dplyr
data95 %>%
  group_by(EVTYPE) %>%
  summarize(Crop_damage=sum(crop)) %>%
  arrange(desc(Crop_damage)) %>%
  head(10)

#usig data.table
dt95[, .(Crop_damage=sum(crop)), 
     by=.(EVTYPE)
     ][order(-Crop_damage)
       ] [1:10]

#An interesting analysis is to look both at the health and
# economic impacts of storm events.

event.publichealth <- merge(event.fatalities,event.injuries, by = "type")
event.economy <- merge(event.property,event.crop, by = "type")
event.economy <- mutate(event.economy, combined.damage = property.damage + crop.damage)
event.all <- merge(event.publichealth, event.economy, by = "type")

plot(log(event.all$fatalities+1),
     log(event.all$combined.damage+1), 
     xlab = "log(fatalities + 1)", 
     ylab = "log(crop damage + property damage + 1)", 
     main = "comparison of total damage and fatalities by event type(1995-2011)")

#using ggplot
event.all %>%
  ggplot(aes(x=log(fatalities+1), y=log(combined.damage+1))) +
  geom_point() +   
  ggtitle("Comparison of total damage and fatalities by event type(1995-2011)") +
  xlab("log(fatalities+1)") +
  ylab("log(crop.damage+property.damage+1)") 

#ggplot, point size proprtional to log(fatalities)
event.all %>%
  ggplot(aes(x=log(fatalities+1), y=log(combined.damage+1))) +
  geom_point(aes(size=log(fatalities+1))) +   # size proprtional to fatalities
  ggtitle("Comparison of total damage and fatalities by event type(1995-2011)") +
  xlab("log(fatalities+1)") +
  ylab("log(crop.damage+property.damage+1)") +
  geom_smooth(method="lm", na.rm=T)


