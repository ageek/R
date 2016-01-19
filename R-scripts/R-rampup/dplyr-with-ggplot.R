#dplyr piped to ggplot2

# dplyr + ggplot
# PRICE DISTRIBUTION, Ideal-cut diamonds
diamonds %>%                                        # Start with the 'diamonds' dataset
  filter(cut == "Ideal") %>%                        # Then, filter down to rows where cut == Ideal
  ggplot(aes(x=color,y=price)) +                     # Then, plot using ggplot
  geom_boxplot()  

# dplyr + ggplot
# HISTOGRAM of price, ideal cut diamonds
diamonds %>%                                        # Start with the 'diamonds' dataset
  filter(cut == "Ideal") %>%                        # Then, filter down to rows where cut == Ideal
  ggplot(aes(price)) +                            # Then, plot using ggplot
  geom_histogram() +                              # and plot histograms
  facet_wrap(~ color)                             # in a 'small multiple' plot, broken out by 'color'


# Another example for ggplot - with dplyr
df.car_spec_data <- read.csv("http://www.sharpsightlabs.com/wp-content/uploads/2014/12/auto-snout_car-specifications_COMBINED.txt")
df.car_spec_data$year <- as.character(df.car_spec_data$year)

#--------------
# Create Theme
#--------------

# BASIC THEME
theme.car_chart <- 
  theme(legend.position = "none") +
  theme(plot.title = element_text(size=26, family="Trebuchet MS", face="bold", hjust=0, color="#666666")) +
  theme(axis.title = element_text(size=18, family="Trebuchet MS", face="bold", color="#666666")) +
  theme(axis.title.y = element_text(angle=0)) 


# SCATTERPLOT THEME
theme.car_chart_SCATTER <- theme.car_chart +
  theme(axis.title.x = element_text(hjust=0, vjust=-.5))

# HISTOGRAM THEME
theme.car_chart_HIST <- theme.car_chart +
  theme(axis.title.x = element_text(hjust=0, vjust=-.5))

# SMALL MULTIPLE THEME
theme.car_chart_SMALLM <- theme.car_chart +
  theme(panel.grid.minor = element_blank()) +
  theme(strip.text.x = element_text(size=16, family="Trebuchet MS", face="bold", color="#666666"))   


###########################################
# PLOT DATA (Preliminary Data Inspection) #
###########################################

#-------------------------
# Horsepower vs. Top Speed
#-------------------------

ggplot(data=df.car_spec_data, aes(x=horsepower_bhp, y=top_speed_mph)) +
  geom_point(alpha=.4, size=4, color="#880011") +
  ggtitle("Horsepower vs. Top Speed") +
  labs(x="Horsepower, bhp", y="Top Speed,\n mph") +
  theme.car_chart_SCATTER

#------------------------
# Histogram of Top Speed
#------------------------

ggplot(data=df.car_spec_data, aes(x=top_speed_mph)) +
  geom_histogram(fill="#880011") +  
  ggtitle("Histogram of Top Speed") +
  labs(x="Top Speed, mph", y="Count\nof Records") +
  theme.car_chart_HIST


#----------------------------------
# ZOOM IN ON SPEED CONTROLLED CARS
#
# What is the 'limited' speed?
#  (create bar chart)
#----------------------------------

df.car_spec_data %>%
  filter(top_speed_mph >149 & top_speed_mph <159) %>%
  ggplot(aes(x= as.factor(top_speed_mph))) +
  geom_bar(fill="#880011") +
  labs(x="Top Speed, mph") +
  theme.car_chart


#------------------------
# Histogram of Top Speed
#  By DECADE
#------------------------

ggplot(data=df.car_spec_data, aes(x=top_speed_mph)) +
  geom_histogram(fill="#880011") +
  ggtitle("Histogram of Top Speed\nby decade") +
  labs(x="Top Speed, mph", y="Count\nof Records") +
  facet_wrap(~decade) +
  theme.car_chart_SMALLM

#-------------------------------
# TABLE OF CAR COMPANIES WITH 
#  CARS AT MAX SPEED = 155
#-------------------------------
df.car_spec_data %>%
  filter(top_speed_mph == 155 & year>=1990) %>%
  group_by(make_nm) %>% 
  summarize(count_speed_controlled = n()) %>%
  arrange(desc(count_speed_controlled))

#          make_nm          count_speed_controlled
#             BMW                     53
#            Audi                     51
#        Mercedes                     41
#          Jaguar                     14
#          Nissan                      9
#          Subaru                      7
#  Volkswagen(VW)                      7
#           Volvo                      7
#            Ford                      5
#     Mitsubishi                      5
#     Alfa-Romeo                      4
#       Infiniti                      4
#          Lexus                      4
#  Vauxhall-Opel                      4
#        Bentley                      3
#       Chrysler                      3
#        Pontiac                      3
#    Rolls-Royce                      3
#       Cadillac                      2
#       Caterham                      2
#      Chevrolet                      2
#          Mazda                      2
#        Porsche                      2
#         Toyota                      2
#             AC                      1
#          Dodge                      1
#           Fiat                      1
#         Fisker                      1
#         Holden                      1
#          Honda                      1
#           Jeep                      1
#          Lotus                      1
#             MG                      1
#        Maybach                      1
#          Noble                      1
#           Saab                      1
#           Seat                      1


#Overview first, zoom and filter, then details-on-demand
#We've revealed details by following a specific process: overview first, zoom and filter, then details on demand. (This visual-information seeking mantra was originally described by Ben Shneiderman.)
#We started with a high-level view with a chart of horsepower vs speed. Then, we saw something that looked unusual and "took a closer look" by examining the speed variable independently. We did this by filtering our data and using new charts to "zoom in."
#Finally, we gathered an initial set of details by creating list of car companies that have (probably) been using speed limiter systems. We've uncovered details about what was causing the data-feature in question.
#Hypothetically, we could do more research (or ask a team member to do more research). We could read about these systems, talk to subject matter experts, etc.
#To recap, we started with a high-level overview, and used filtering and different chart types to zoom in.
#This is important. Learn to approach data exploration in this way. 


#-------------------------------
# BHP by SPEED (faceted: decade)
#-------------------------------
ggplot(data=df.car_spec_data, aes(x=horsepower_bhp, y=top_speed_mph)) +
  geom_point(alpha=.6,color="#880011") +
  facet_wrap(~decade) +
  ggtitle("Horsepower vs Top Speed\nby decade") +
  labs(x="Horsepower, bhp", y="Top Speed\n mph") +
  theme.car_chart_SMALLM


#-----------------------------
# Top Speed vs Year (all cars)
#-----------------------------
ggplot(data=df.car_spec_data, aes(x=year, y=df.car_spec_data$top_speed_mph)) +
  geom_point(alpha=.35, size=4.5, color="#880011", position = position_jitter()) +
  scale_x_discrete(breaks = c("1950","1960","1970","1980","1990","2000","2010")) +
  ggtitle("Car Top Speeds by Year") +
  labs(x="Year" ,y="Top Speed\nmph") +
  theme.car_chart_SCATTER

#------------------------------------------
# PLOT: Maximum Speed (fastest car) by Year
#------------------------------------------

df.car_spec_data %>%
  group_by(year) %>%
  summarize(max_speed = max(top_speed_mph, na.rm=TRUE)) %>%
  ggplot(aes(x=year,y=max_speed,group=1)) + 
  geom_point(size=5, alpha=.8, color="#880011") +
  stat_smooth(method="auto",size=1.5) +
  scale_x_discrete(breaks = c("1950","1960","1970","1980","1990","2000","2010")) +
  ggtitle("Speed of Year's Fastest Car by Year") +
  labs(x="Year",y="Top Speed\n(fastest car)") +
  theme.car_chart_SCATTER


#--------------------------
# 0-to-60 by Horsepower
#  version 2 
#  ADD JITTER
#--------------------------

ggplot(data=df.car_spec_data, aes(x=horsepower_bhp,y=car_0_60_time_seconds)) +
  geom_point(position="jitter")



#--------------------------
# 0-to-60 by Horsepower
#  version 3
#  THEMED (Final)
#--------------------------

ggplot(data=df.car_spec_data, aes(x=horsepower_bhp,y=car_0_60_time_seconds)) +
  geom_point(size=4, alpha=.7,color="#880011",position="jitter") +
  stat_smooth(method="auto",size=1.5) +
  ggtitle("0 to 60 times by Horsepower") +
  labs(x="Horsepower, bhp",y="0-60 time\nseconds") +
  theme.car_chart_SCATTER


#######################
# Horsepower Per Tonne
#######################

#--------------------------
# 0-to-60 by Horsepower-per-tonne
#  THEMED (Final)
#--------------------------

ggplot(data=df.car_spec_data, aes(x=horsepower_per_ton_bhp,y=car_0_60_time_seconds)) +
  geom_point(size=4, alpha=.5,color="#880011",position="jitter") +
  stat_smooth(method="auto",size=1.5) +
  ggtitle("0 to 60 times\nbyHorsepower-per-Tonne") +
  labs(x="Horsepower-per-tonne",y="0-60 time\nseconds") +
  theme.car_chart_SCATTER



#----------------------
# Bar Chart
#  top 10 fastest cars
#----------------------
df.car_spec_data %>%
  select(car_full_nm,top_speed_mph) %>%
  filter(min_rank(desc(top_speed_mph)) <= 10) %>%
  arrange(desc(top_speed_mph)) %>%
  ggplot(aes(x=reorder(car_full_nm,top_speed_mph), y=top_speed_mph)) +
  geom_bar(stat="identity",fill="#880011") +
  coord_flip() +
  ggtitle("Top 10 Fastest Cars (through 2012)") +
  labs(x="",y="") +
  theme.car_chart +
  theme(axis.text.y = element_text(size=rel(1.5))) +
  theme(plot.title = element_text(hjust=1))


iris %>%
  group_by(Species)%>%
  summarize(meanSepLength=mean(Sepal.Length)) %>%
  ggplot(aes(x=Species, meanSepLength)) +geom_bar(stat='identity')

