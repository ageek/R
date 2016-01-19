#Boston Crime data Analysis

#boston <-read.csv("/192.168.1.1/usb1_3/Boston Datasets/Crime_Incident_Reports.csv", header = F, sep=',')
boston <- read.csv("C:/Ahmed/ML/dataset local copy/Crime_Incident_Reports.csv", 
                   header=T, sep=',', stringsAsFactors=F)

str(boston)
head(boston)

#crime chart based on days, which day has high crime rate
table(boston$DAY_WEEK)
hist(table(boston$DAY_WEEK), breaks = 7)
ggplot(boston, aes(x=DAY_WEEK))+geom_histogram()
ggplot(boston, aes(x=DAY_WEEK, fill=f))+geom_histogram()
par(mfrow=c(1,1))

A <- select(boston, Shooting, DAY_WEEK) %>%
      group_by(DAY_WEEK, Shooting) %>%
      summarize(N=n())

#shooting=yes, group_by week_day
table(boston$DAY_WEEK[boston$Shootin=='Yes'])

prop.table(table(boston$DAY_WEEK[boston$Shootin=='Yes']))

#which day had highet shooting another way to represent
ggplot(boston[boston$Shooting=='Yes',], 
       aes(x=Shooting, fill=DAY_WEEK)) +
        geom_histogram() +
        facet_grid(DAY_WEEK~.)

# see which district has hight shooting (=Yes), gruoped_by DAY_WEEK
ggplot(boston[boston$Shooting=='Yes',], aes(x=Shooting, fill=DAY_WEEK)) +
        geom_histogram() +
        facet_grid(REPTDISTRICT~.)

#same using  table
table(boston[boston$Shooting=='Yes',]$REPTDISTRICT)

A1 A15  A7  B2  B3 C11  C6 D14  D4 E13 E18  E5 HTU 
0  18   6  19 224 135 158  14   4  47  42  27   7   0 

plot(table(boston[boston$Shooting=='Yes',]$REPTDISTRICT))

#> colnames(boston)
[1] "COMPNOS"                   "NatureCode"               
[3] "INCIDENT_TYPE_DESCRIPTION" "MAIN_CRIMECODE"           
[5] "REPTDISTRICT"              "REPORTINGAREA"            
[7] "FROMDATE"                  "WEAPONTYPE"               
[9] "Shooting"                  "DOMESTIC"                 
[11] "SHIFT"                     "Year"                     
[13] "Month"                     "DAY_WEEK"                 
[15] "UCRPART"                   "X"                        
[17] "Y"                         "STREETNAME"               
[19] "XSTREETNAME"               "Location"                 
> 
  

#shooting ~ day_week, and show breaks for shooting-yes/no
ggplot(boston, aes(x=DAY_WEEK, fill=Shooting))+geom_histogram()

#shooting ~day_week,  break each histo for day_week stacked
ggplot(boston, aes(x=Shooting, fill=DAY_WEEK))+geom_histogram()

#lets zoom-in to all Shootig==yes cases and breakdown by day_week
boston %>% filter(Shooting=='Yes') %>%
  + ggplot(aes(x=Shooting, fill=DAY_WEEK)) + geom_histogram()
# for each district ~ count,fill=day_week, 
ggplot(boston, aes(x=REPTDISTRICT, fill=DAY_WEEK))+geom_histogram()

# district ~ count, fill=Shooting
ggplot(boston, aes(x=REPTDISTRICT, fill=Shooting))+geom_histogram()

#district ~ count, fill=shooting, Facet_grid: show for each day_week
# Facet_grid
ggplot(boston, aes(x=REPTDISTRICT, fill=Shooting))+
    geom_histogram()+facet_grid(DAY_WEEK~.)
# same thing using Facet_wrap(), note the difference in both the plots
ggplot(boston, aes(x=REPTDISTRICT, fill=Shooting))+
    geom_histogram()+facet_wrap(~DAY_WEEK)


#district ~ count, fill=WeaponType, Facet_grid: day_week
ggplot(boston, aes(x=REPTDISTRICT, fill=WEAPONTYPE))+
    geom_histogram()+facet_grid(DAY_WEEK~.)
#same using facet_wrap()
ggplot(boston, aes(x=REPTDISTRICT, fill=WEAPONTYPE))+
  geom_histogram()+facet_wrap(~DAY_WEEK)

#Year 2012 and 2015 have partial data(5 of 12 months ony), lets drop the years
boston_new <- boston[boston$Year==2013 | boston$Year==2014,]

# district ~ count, fill=weapontype
ggplot(boston_new, aes(x=REPTDISTRICT, fill=WEAPONTYPE))+geom_histogram()

#district ~ count, fill=Weapontpe, facet_grid=SHIFT
ggplot(boston, aes(x=REPTDISTRICT, fill=WEAPONTYPE)) +
    geom_histogram()+facet_grid(SHIFT~.)

# day_week ~ count, fill=shift
ggplot(boston, aes(x=DAY_WEEK, fill=SHIFT))+geom_histogram()

#convert month to factor and then :>
boston$Month <- as.factor(boston$Month)
# A lot of crimes happened during 5th Month/summer and it was even higher
# during Thursday, Friday
ggplot(b, aes(x=DAY_WEEK, fill=Month))+geom_histogram()

# facet above by weapon_type
# this indicates Most of the crimes happened without Arms 
# and next highest by "other" arm types
# day_week ~ count, fill:Month, facet_grid:weapon_type
ggplot(b, aes(x=DAY_WEEK, fill=Month))+geom_histogram() +
    facet_grid(WEAPONTYPE~.)


#plotting crime incidence on google map
# https://stablemarkets.wordpress.com/2014/09/01/spatial-data-visualization-with-r/

boston[which(boston$Shooting=='Yes' & boston$Year=='2014'),]


#crime data facet_grid: Year, fill:day_week
ggplot(boston, aes(x=factor(Month), fill=DAY_WEEK))+
  geom_histogram()+facet_grid(Year~.) +
  ggtitle("Month vs Year") +
  labs(x='Month of Year', y='Count')



# require(stringr)
> regex
[1] "[-+]*[[:digit:]]+\\.*[[:digit:]]*"
> str_extract(df[1,], regex)
[1] "42.29324636"
> str_extract(df[2,], regex)
[1] "42.28260136"
> str_extract(df[,1], regex)
[1] "42.29324636" "42.28260136" "42.35262135"
> str_extract(df[,], regex)
[1] "42.29324636" "42.28260136" "42.35262135"
> regex <- "[[-+]*[[:digit:]]+\\.*[[:digit:]]*]+"
> str_extract(df[,], regex)
[1] "42.29324636" "42.28260136" "42.35262135"
> str_extract(df[,1], regex)
[1] "42.29324636" "42.28260136" "42.35262135"
> str_extract(df[,], regex)
[1] "42.29324636" "42.28260136" "42.35262135"

# lets use regex to capture the long/X, lat/Y from Location column of Boston data
> tt <- "<? 44.2 (-22)"
> regmatches(tt,gregexpr("[-+]*[[:digit:]]+\\.*[[:digit:]]*",tt))
[[1]]
[1] "44.2" "-22"

#using tidyr 
> df
x
1 (42.29324636, -71.06722456)
2 (42.28260136, -71.05569957)
3 (42.35262135, -71.05542957)

> df %>% separate(x, c("A", "B"), sep = "\\,")
A              B
1 (42.29324636  -71.06722456)
2 (42.28260136  -71.05569957)
3 (42.35262135  -71.05542957)
> 
> t <- '(42.29324636, -71.06722456)'
> gsub("\\((.+)\\)","\\1",t)
[1] "42.29324636, -71.06722456"
> gsub("\\((.+)\\)","\\1",df$x)
[1] "42.29324636, -71.06722456" "42.28260136, -71.05569957"
[3] "42.35262135, -71.05542957"
> boston$loc <- gsub("\\((.+)\\)","\\1",boston$Location)
> head(boston$loc)
[1] "42.29324636, -71.06722456" "42.28260136, -71.05569957"
[3] "42.35262135, -71.05542957" "42.29240136, -71.06244956"
[5] "42.28715647, -71.06498283" "42.33478135, -71.07531456"


#read boston data file
boston <- read.csv("C:/Ahmed/ML/dataset local copy/Crime_Incident_Reports.csv", 
                   header=T, sep=',', stringsAsFactors=F)

# first remove ( & ) from boston$Location and save in new field
boston$loc <- gsub("\\((.+)\\)","\\1",boston$Location)

require(tidyr)
# we saved result in another copy of boston, i.e. boston2
boston2 <- boston %>% separate(loc, c("lat", "lon"), sep=",")

bos_2<-boston2[which(boston2$Shooting=='Yes' & boston2$Year=='2014'),]
bos_3<-boston2[which(boston2$INCIDENT_TYPE_DESCRIPTION=='DRUG CHARGES' & boston2$Year=='2014'),]


# remove NA rows
bos_2 <- na.omit(bos_2)
bos_3 <- na.omit(bos_3)
table(is.na(bos_2))
table(is.na(bos_3))

#convert lat and long to double from char
bos_2$lat <- as.double(bos_2$lat)
bos_2$lon <- as.double(bos_2$lon)
bos_3$lat <- as.double(bos_3$lat)
bos_3$lon <- as.double(bos_3$lon)


#working OK
require(ggmap)
bos_plot<-ggmap(get_map("Boston, Massachusetts",zoom=12))
bos_plot+geom_point(data=bos_2,aes(x=lon,y=lat), 
                    col='red',alpha=.5,
                    size=5) +
        geom_point(data=bos_3,aes(x=lon,y=lat), 
                    col='blue',alpha=.5,
                    size=2) 


# ========================================
#other option- using maps library - not tested
library(maps) # For map data
# Get map data for USA
states_map <- map_data("state")
base_plot <- ggplot(states_map, aes(x=long, y=lat)) + 
  geom_polygon(fill="white", colour="black")

base_plot+geom_point(data=bos_2, aes(x=as.double(lon),y=as.double(lat)), 
                    col='red',alpha=.5,
                    size=5)

  +geom_point(data=bos_3,aes(x=bos_3$Lat,y=bos_3$Long), 
             col='blue',alpha=.5,
             size=2)
