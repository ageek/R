#tidy r rampup
# http://blog.rstudio.org/2014/07/22/introducing-tidyr/
# gather() takes multiple columns, and gathers them into key-value pairs:
# it makes "wide" data longer. Other names for gather include 
# melt (reshape2), pivot (spreadsheets) and fold (databases)

require(tidyr)
require(dplyr)

messy <- data.frame(
  name = c("Wilbur", "Petunia", "Gregory"),
  a = c(67, 80, 64),
  b = c(56, 90, 50),
  c = c(33, 44, 55)
)
messy

#by explicity merging columns a to b
messy %>%
  gather(drug, heartrate, a:b)

# merge a to c
messy %>%
  gather(drug, heartrate, a:c)

messy %>%
  gather(drug, heartrate, b:c)

#without explicitly mentioning the columns,will keep "name", 
# and merge all remaining columns to "heartrate"
gather(messy, name, heartrate)


#time spent on phone @home and @work
set.seed(10)
messy <- data.frame(
  id = 1:4,
  trt = sample(rep(c('control', 'treatment'), each = 2)),
  work.T1 = runif(4),
  home.T1 = runif(4),
  work.T2 = runif(4),
  home.T2 = runif(4)
)
messy
#merge all times
gather(messy, locationID, timespent, -id, -trt)

#with wrong column names
messy %>%
  gather(id, trt, work.T1:home.T2)

#with correct column names as provided
long_messy <- messy %>%
  gather(key,timespent, -id, -trt)

#separate locationID
messy %>%
  gather(key, timespent, -id, -trt) %>%
  separate(key, into=c("location", "timeslot"), sep="\\.")

#long to wide format using spread


##########################
#https://rpubs.com/m_dev/tidyr-intro-and-demos

#dadmom <- foreign::read.dta("C:/Ahmed/ML/dataset local copy/dadmomw.dta")
dadmom <- foreign::read.dta("http://www.ats.ucla.edu/stat/stata/modules/dadmomw.dta")
dadmom

dadmom %>%
  gather(key, value, named:incm) %>%
  #try ohter values 2, 4, -3 etc and see the behavior to understand
  separate(key, into=c("variable", "type"), -2)  %>%
  #convert the values to int
  spread(variable, value, convert = T)

#Reshape wide format, to multi-column long format

# http://stackoverflow.com/questions/15668870/

grades <- tbl_df(read.table(header = TRUE, text = "
   ID   Test Year   Fall Spring Winter
    1   1   2008    15      16      19
    1   1   2009    12      13      27
    1   2   2008    22      22      24
    1   2   2009    10      14      20
    2   1   2008    12      13      25
    2   1   2009    16      14      21
    2   2   2008    13      11      29
    2   2   2009    23      20      26
    3   1   2008    11      12      22
    3   1   2009    13      11      27
    3   2   2008    17      12      23
    3   2   2009    14      9       31
"))
grades
grades %>%
  gather(Sem, Score, Fall:Winter) %>%
  mutate(Test = paste0("Test", Test)) %>%
  spread(Test, Score) %>%
  arrange(ID, -Year, Sem)

#Reshape data from long to a short format by a variable, 
#and rename columns
# http://stackoverflow.com/questions/16032858

results <- data.frame(
  Ind = paste0("Ind", 1:10),
  Treatment = rep(c("Treat", "Cont"), each = 10),
  value = 1:20
)
head(results)

results %>%
  spread(Treatment, value)


##Rearranging Data frame in R
# http://stackoverflow.com/questions/17481212

race <- read.table(header = TRUE, check.names = FALSE, text = "
                   Name    50  100  150  200  250  300  350
                   Carla  1.2  1.8  2.2  2.3  3.0  2.5  1.8
                   Mace   1.5  1.1  1.9  2.0  3.6  3.0  2.5
                   Lea    1.7  1.6  2.3  2.7  2.6  2.2  2.6
                   Karen  1.3  1.7  1.9  2.2  3.2  1.5  1.9
                   ")
race

race  %>%
  gather(Time, Score, -Name, convert = T) %>%
  arrange(Time, Score)

#OR - not working as col names are int
gather(Time, Score, -Name, convert = T)

cols <- colnames(race)


#wide to long multiple measures each time
# http://stackoverflow.com/questions/9684671

set.seed(10)
activities <- data.frame(
  id = sprintf("x1.%02d", 1:10),
  trt = sample(c('cnt', 'tr'), 10, T),
  work.T1 = runif(10),
  play.T1 = runif(10),
  talk.T1 = runif(10),
  work.T2 = runif(10),
  play.T2 = runif(10),
  talk.T2 = runif(10)
)
activities

activities %>%
  gather(Activity, TimeSpent, -id, -trt) %>%
  separate(Activity, into=c("ActivityType", "TimeSlot"), sep="\\.") %>%
  spread(ActivityType, TimeSpent)
