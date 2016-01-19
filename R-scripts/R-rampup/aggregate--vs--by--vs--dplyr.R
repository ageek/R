#aggregate function in R
## Compute the averages for the variables in 'state.x77', grouped
## according to the region (Northeast, South, North Central, West) that
## each state belongs to.
aggregate(state.x77, list(Region = state.region), mean)

## Compute the averages according to region and the occurrence of more
## than 130 days of frost.
aggregate(state.x77,
          list(Region = state.region,
               Cold = state.x77[,"Frost"] > 130),
          mean)
## (Note that no state in 'South' is THAT cold.)

#where is state.region ???
#using dplyr
require(dplyr)
as.data.frame(state.x77) %>%
  group_by(state.region) %>%
  summarise(avg_pop=mean(Population))


# web examples: 
# http://davetang.org/muse/2013/05/22/using-aggregate-and-apply-in-r/
data <- as.data.frame(ChickWeight)
head(data)

require(ggplot2)
data %>%
  ggplot(aes(x=Time, y=weight, colour=Chick, group=Chick)) +
  geom_point() +
  geom_line()

#using aggregate - output dataframe
aggregate(data$weight, list(diet=data$Diet), mean)


#using by _out put is not a dataframe: its a "by" object
#hence aggregate is better, as output can be used further
#with other toosl like ggplot etc
by(data$weight, data$Diet, mean)

#using dplyr - output is a dataframe
# more convinient to be used with other tools
data %>%
  select(weight, Diet) %>%
  group_by(Diet) %>%
  summarize(avg_weight=mean(weight))

aggregate(data$weight, list(time=data$Time), sd)

by(data$weight, data$Time, sd)

data %>%
  select(weight, Time) %>%
  group_by(Time) %>%
  summarize(avg_weight=mean(weight))


data %>%
  ggplot(aes(x=Time, y=weight, color=Chick)) +
  geom_line() +
  facet_wrap(~Diet) +
  guides(col=guide_legend(ncol=3))
