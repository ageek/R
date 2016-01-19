# dplyr- hflights dataset

require(hflights)

# average ArrDelay vs Month plot
# whats the best time to fly, with little ArrDelay
# 11/Nov is best and 5/May is worst time
#lets break meanArrDelay by day of week and see the behavior
hflights %>%
  select(Month,DayOfWeek,ArrDelay) %>%
  group_by(Month, DayOfWeek) %>%
  #summarize(meanArrDelay=mean(ArrDelay, na.rm = T)) %>%
  mutate(meanArrDelay=mean(ArrDelay, na.rm=T)) %>%
  ggplot(aes(x=factor(Month), y=meanArrDelay)) + 
  geom_histogram(stat='identity') +
  facet_wrap(~DayOfWeek)

# from the above plot, 
# 1. it looks like, the best Month to fly is 
# 2nd day of week during 10/Oct Month

# 2. on an average 2nd, 6th day has less ArrDelay


#lets see the behavior for each flight
#TailNum is unique ID for each flight
length(unique(hflights$TailNum))

hflights %>% 
  group_by(TailNum) %>%
  summarize(Count=n(), meanArrDelay=mean(ArrDelay, na.rm=T), 
            meanDist = mean(Distance, na.rm = T)) %>%
  arrange(desc(meanArrDelay))

# avg delay vs avg distance for each flight
# the plot says, there is no good relation between delay & distance
hflights %>%
  group_by(TailNum) %>%
  mutate(AvgDist=mean(Distance, na.rm = T), count = n(),
         AvgArrDelay=mean(ArrDelay, na.rm = T)) %>%
  ggplot(aes(x=AvgDist, y=AvgArrDelay))+
  geom_point(aes(size=count)) +
  geom_smooth()


hflights %>%
  group_by(TailNum) %>%
  mutate(AvgDist=mean(Distance, na.rm = T), count = n(),
         AvgArrDelay=mean(ArrDelay, na.rm = T)) %>%
  select(AvgDist, AvgArrDelay) 
  #cor(AvgDist, AvgArrDelay)


#no of planes and number of flights for each destination
# unloadNamespace(plyr), to remove screwed plyr::group_by
# plyr blocks n() as well, dont load both plyr and dplyr
hflights %>%
  group_by(Dest) %>%
  summarize(Planes=length(unique(TailNum)), Flights=n()) %>%
  arrange(desc(Flights))

# DALLAS has highest no of flights 9820 and max no of planes
# 806 to its airport

>  
Source: local data frame [116 x 3]

Dest Planes Flights
1   DAL    806    9820
2   ATL    983    7886
3   MSY    947    6823
4   DFW    825    6653
5   LAX    736    6064
6   DEN   1133    5920
7   ORD    569    5748
8   PHX    914    5096
9   AUS   1015    5022
10  SAT    950    4893

  
# When you group by multiple variables, each summary peels off 
# one level of the grouping. That makes it easy to progressively
# roll-up a dataset:
daily <- group_by(hflights, Year, Month, DayofMonth)

per_day <- daily %>% summarize(Flights.D=n())

# OR
hflights %>%
  group_by(Year, Month, DayofMonth) %>%
  summarize(Flights_per_day = n())

per_month <- per_day %>% summarize(Flights.M=sum(Flights.D))
 
# OR
hflights %>%
   group_by(Year, Month) %>%
   summarize(Flights_for_month=n())

per_year <- per_month %>% summarize(Fliths=sum(Flights.M))

# OR
> hflights %>%
  + group_by(Year) %>%
  + summarize(Flights_for_year=n())
Source: local data frame [1 x 2]

Year Flights_for_year
1 2011           227496


# Day vs Flight count hisogram, stacked for each Month
hflights %>%
  group_by(DayofMonth, Month) %>%
  summarise(Flights.M=n()) %>%
  ggplot(aes(x=DayofMonth, y=Flights.M, fill=factor(Month))) +
  geom_histogram(stat='identity')

#

