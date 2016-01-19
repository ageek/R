# dplyr+ggplot for babenames dataset

install.packages("babynames")
require(dplyr)
require(babynames)

babynames %>% head()

#histogram of Mary being used as Male vs Female  name using Histogram
babynames %>% 
  group_by(year, sex) %>%
  filter(name=='Mary') %>%
  ggplot(aes(x=year, y=n, fill=sex))+geom_histogram(stat='identity')

#lets zoom in from 1925 and 1950 and see
babynames %>% 
  filter(year>1925 & year<1950) %>%
  group_by(year, sex) %>%
  filter(name=='Mary') %>%
  ggplot(aes(x=year, y=n, fill=sex))+geom_histogram(stat='identity')

  

# same thing as above but using scatterplots
# see how the Name "Mary" gets used for Female vs Male from 1875 to 2000
babynames %>% 
  group_by(year, sex) %>%
  filter(name=='Mary') %>%
  ggplot(aes(x=year, y=n, col=sex))+geom_point()   # try with geom_line()

#From the above plot: males rarely used the name Mary...there was some use between
# 1925 and 1950, but otherwise its very rare
# for Females, during 20's to around 60s, it was heavily used
# but now its declining drastically from 70s onwards

# check for another name='Madison'
babynames %>% 
  group_by(year, sex) %>%
  filter(name=='Madison') %>%
  ggplot(aes(x=year, y=n, col=sex))+geom_line()


# finding prop of each name by that year
ratios <- babynames %>%
  select(-prop) %>%
  group_by(year, name) %>%
  mutate(Total=sum(n)) %>%
  group_by(name, sex, year) %>%
  mutate(ratio = n/Total) %>%
  select(name, year, sex, ratio) %>%
  ungroup() %>%
  spread(sex, ratio)

# for names with 0 names of Male/Female, set NA to 0
ratios[is.na(ratios)] <- 0

#see how the pattern changed for Madison
ratios %>% filter(name == "Madison", year >= 1980, year <= 1990)

# zoom-in to 1975-2000  era
ratios %>% 
  filter(name == "Madison", year >= 1975, year <= 2000) %>%
  ggplot(aes(x=year, y=F))+geom_point()

# using geom_smooth(lm)
ratios %>% 
  filter(name == "Madison") %>%
  ggplot(aes(x=year, y=F))+geom_point() +
  geom_smooth(method='lm') +
  xlim(1940,2012) +ylim(0,1) +
  ggtitle('for Madison name usage by M & Female, year on year')



#check for multiple names and draw a plot
test_names <- c("Madison", "John", "Mary", "Leslie", "Jan")
"Madison" %in% test_names

ratios %>%
  filter(name %in% test_names) %>%
  ggplot(aes(x=year, y=F, col=name)) +    # set y=M, and see the behavior
  geom_line(lwd=1) +
  geom_point() +
  geom_smooth(method='lm') +
  ylab("Female") +
  ylim(0,1) +
  ggtitle("Linear regression for five names")


#modeling
madison <- ratios %>% filter(name=='Madison')
madison_model <- lm(F~year, data=madison)
summary(madison_model)

#how many unique names we have?
length(ratios$name %>% unique)

unique_names <- ratios$name %>% unique

#lets model on 2000 names out of 96.2K names only
sample_names <- sample(unique_names, 2000)
sample_names <- c(sample_names, test_names)

#pick the entries from ratios, where ratios$name == sample_names
names_to_fit <- ratios %>% filter(name %in% sample_names)

#one linear model for each name
names_model <- names_to_fit %>%
  group_by(name) %>%
  do (model = lm(F~year, data=.))

names_model

#check for Madison's model
filter(names_model, name=='Madison')$model


names_pearson <- names_to_fit %>%
  group_by(name) %>%
  do(Pearsons = with(., cor(year, F)))
names_pearson

#how many NAs
> table(is.na(names_pearson$Pearsons))

FALSE  TRUE 
209  1796 
> 

#drop NAs
#interesting names pearson
interesting_names_pearson <- names_pearson %>% filter(!is.na(Pearsons))

#
table(names_pearson$Pearsons > 0.9)

# our base line is for Females(check the linear model, we modelled on F ~year), 
# so +ve co-relation meaning 
# towrads Female name, whereas -ve /opposite co-relation means
# towards Male name
to_male <- interesting_names_pearson %>%
  filter(Pearsons <0 ) %>%
  arrange(as.numeric(Pearsons))

to_female <- interesting_names_pearson %>%
  filter(Pearsons >0 ) %>%
  arrange(as.numeric(Pearsons))

# names that became female
head(to_female, 10)

# names that became male
head(to_male, 10)
