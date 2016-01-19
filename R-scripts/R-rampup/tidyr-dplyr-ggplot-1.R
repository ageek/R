#dplyr-tidyr-ggplot
# https://rstudio-pubs-static.s3.amazonaws.com/58498_dd3b603ba4fb4b469bb1c57b5a951c39.html#introduction

DF <- read.table(text="Group Year Qtr.1 Qtr.2 Qtr.3 Qtr.4
      1 2006    15    16    19    17
      1 2007    12    13    27    23
      1 2008    22    22    24    20
      1 2009    10    14    20    16
      2 2006    12    13    25    18
      2 2007    16    14    21    19
      2 2008    13    11    29    15
      2 2009    23    20    26    20
      3 2006    11    12    22    16
     3 2007    13    11    27    21
     3 2008    17    12    23    19
     3 2009    14     9    31    24 ", header=T, strip.white=T)

long_DF <- DF %>% gather(Quarter, Revenue, Qtr.1:Qtr.4)

#Group Year Quarter Revenue
1      1 2006   Qtr.1      15
2      1 2007   Qtr.1      12
3      1 2008   Qtr.1      22
4      1 2009   Qtr.1      10
5      2 2006   Qtr.1      12
6      2 2007   Qtr.1      16
7      2 2008   Qtr.1      13
8      2 2009   Qtr.1      23
9      3 2006   Qtr.1      11

# SAme results, but another way: 

DF %>% gather(Quarter, Rev, Qtr.1, Qtr.2, Qtr.3, Qtr.4)

#OR

DF %>% gather(Quarter, Rev, 3:6)

# OR

DF %>% gather(Quarter, Rev, -Group, -Year)



#Separate

data <- read.table(text="Grp_Ind    Yr_Mo       City_State        First_Last     Extra_variable
     1.a 2006_Jan      Dayton (OH) George Washington   XX01person_1
     1.b 2006_Feb Grand Forks (ND)        John Adams   XX02person_2
     1.c 2006_Mar       Fargo (ND)  Thomas Jefferson   XX03person_3
     2.a 2007_Jan   Rochester (MN)     James Madison   XX04person_4
     2.b 2007_Feb     Dubuque (IA)      James Monroe   XX05person_5
     2.c 2007_Mar Ft. Collins (CO)        John Adams   XX06person_6
     3.a 2008_Jan   Lake City (MN)    Andrew Jackson   XX07person_7
     3.b 2008_Feb    Rushford (MN)  Martin Van Buren   XX08person_8
     3.c 2008_Mar          NA  William Harrison   XX09person_9", 
                   header=T)


long_DF %>% separate(Quarter, c("Time_interval", "Interval_ID"), sep='\\.')
#OR
separate_DF <- long_DF %>% separate(Quarter, c("Time_interval", "Interval_ID"))


#Unite
unite_DF <- separate_DF %>% unite(Quarter, Time_interval, Interval_ID, sep = "_")


#spread - opposite to gather()

wide_DF <- unite_DF %>% spread(Quarter, Revenue)


#==============dplyr
school.exp.left <- read.table(text="Division      State   X1980    X1990    X2000    X2001    X2002    X2003
        6    Alabama 1146713  2275233  4176082  4354794  4444390  4657643
        9     Alaska  377947   828051  1183499  1229036  1284854  1326226
        8    Arizona  949753  2258660  4288739  4846105  5395814  5892227
        7   Arkansas  666949  1404545  2380331  2505179  2822877  2923401
        9 California 9172158 21485782 38129479 42908787 46265544 47983402
        8   Colorado 1243049  2451833  4401010  4758173  5151003  5551506", 
                              header=T)
school.exp.right <- read.table(text="X2004    X2005    X2006    X2007    X2008    X2009    X2010    X2011
  4812479  5164406  5699076  6245031  6832439  6683843  6670517  6592925
  1354846  1442269  1529645  1634316  1918375  2007319  2084019  2201270
  6071785  6579957  7130341  7815720  8403221  8726755  8482552  8340211
  3109644  3546999  3808011  3997701  4156368  4240839  4459910  4578136
 49215866 50918654 53436103 57352599 61570555 60080929 58248662 57526835
  5666191  5994440  6368289  6579053  7338766  7187267  7429302  7409462", 
                               header=T)

school.exp <- data.frame(school.exp.left, school.exp.right)

# Gather exp by year
school.exp %>% gather(Year, Exp, X1980:X2011)

# Total Exp for each State 
school.exp %>% gather(Year, Exp, X1980:X2011) %>%
  group_by(State) %>%
  summarize(expenditure=mean(Exp)) %>%
  ggplot(aes(x=State,y=expenditure))+geom_histogram(stat = 'identity')

# above plot, with re-ordered factor:state based on total expenditure
# not working - to check
school.exp %>% gather(Year, Exp, X1980:X2011) %>%
  group_by(State) %>%
  summarize(expenditure=mean(Exp)) %>%
  arrange(desc(expenditure)) %>%
  ggplot(aes(x=State,y=expenditure))+geom_histogram(stat = 'identity')


#Mutate
st <- school.exp[,c(1,2,3:5)]
st %>% mutate(Total=X1980+X1990+X2000)

# expenditure vs year, facet_wrap for each state
school.exp %>% gather(Year, Exp, X1980:X2011) %>%
  group_by(State) %>%
  ggplot(aes(x=Year, y=Exp))+
  geom_histogram(stat='identity') +
  facet_wrap(~State)

# same as above with selected x points
school.exp %>% gather(Year, Exp, X1980:X2011) %>%
  group_by(State) %>%
  ggplot(aes(x=Year, y=Exp))+
  geom_histogram(stat='identity') +
  facet_wrap(~State)

#total expenditure by Division histogram
school.exp %>% 
  gather(Year, Exp, X1980:X2011) %>% 
  group_by(Division) %>%
  ggplot(aes(x=Division, fill=State))+geom_histogram()

#clean XYear to year
school.cleaned <- school.exp %>% 
  gather(Year, Exp, X1980:X2011) %>%
  separate(Year, c("x",'Year'), sep='X') %>%
  select(-x) 
  
school.cleaned$Year <- as.numeric(school.cleaned$Year)


#join() in dplyr
inflation <- read.table(text="Year  Annual Inflation
  2007 207.342 0.9030811
  2008 215.303 0.9377553
  2009 214.537 0.9344190
  2010 218.056 0.9497461
  2011 224.939 0.9797251
  2012 229.594 1.0000000", header=T)

#join with matching column (not specified but selected to be "Year")
school.cleaned %>% left_join(inflation)

#inner_join : join with overlapping/intersection data from both
school.cleaned %>% inner_join(inflation)

#right join, all from right, when left's column has no value, set it to NA
school.cleaned %>% right_join(inflation)

#semi, overlapping join but show only left's column, nothing from right
school.cleaned %>% semi_join(inflation)



#
sample_df_wide <- data.frame(
  name = toupper(letters[1:10]),
  denomination = sample(c("Presbyterian", "Episcopalian",
                          "Catholic", "Baptist"), 10, replace = TRUE),
  city = sample(c("New York", "Boston", "Baltimore"), 10,  replace = TRUE),
  members_1830 = sample(seq(1e2, 1e3, 10), 10, replace = TRUE),
  members_1840 = sample(seq(1e2, 1e3, 10), 10, replace = TRUE),
  members_1850 = sample(seq(1e2, 1e3, 10), 10, replace = TRUE),
  stringsAsFactors = FALSE)

#remove junk members_ from gathered column data
sample_df_wide %>%
  gather(Year, TotalMembers, members_1830:members_1850) %>%
  separate(Year, c("x", "Year")) %>%
  select(-x)

sample_df_wide %>%
  gather(Year, TotalMembers, members_1830:members_1850) %>%
  separate(Year, c("x", "Year")) %>%
  select(-x) %>%
  group_by(denomination,city, Year) %>%
  ggplot(aes(x=city, y=TotalMembers, fill=factor(denomination))) +
  geom_bar(stat="identity", position = "dodge") +
  #geom_histogram(stat="identity")
  facet_wrap(~Year)




