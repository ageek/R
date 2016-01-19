# ggplot examples 
mydata100 <- read.csv("C:/Ahmed/ML/dataset local copy/r4sas&spssFiles2ndEd/myRfolder/mydata100.csv", 
                      header=T)

# On the x-axis there really is no variable, so I plugged in a
# call to the factor() 
# function that creates an empty one on the fly
mydata100 %>%
  ggplot(aes(x=factor(""), fill=workshop))+
  geom_histogram()

mydata100 %>%
  group_by(workshop) %>%
  ggplot(aes(x=workshop, fill=workshop)) +
  geom_histogram()

mydata100 %>%
  group_by(workshop) %>%
  ggplot(aes(x=factor(""), fill=workshop)) +
  geom_histogram()

#pie chart instead of stacked barplot
mydata100 %>%
  group_by(workshop) %>%
  ggplot(aes(x=factor(""), fill=workshop)) +
  geom_histogram() +
  coord_polar(theta = "y") +
  scale_x_discrete("")


mydata100 %>%
  ggplot() +
  geom_bar(aes(x=workshop))

#coord flipped
mydata100 %>%
  ggplot(aes(x=workshop, fill=workshop)) +
  geom_bar() +
  coord_flip()

# stacks showing counts
mydata100 %>%
  ggplot(aes(x=gender, fill=workshop)) +
  geom_histogram(position="stack")

# here fill the 0-1 y %age, and show equal/full length stacks
mydata100 %>%
  ggplot(aes(x=gender, fill=workshop)) +
  geom_histogram(position="fill")

# side by side
mydata100 %>%
  ggplot(aes(x=gender, fill=workshop)) +
  geom_histogram(position="dodge")

# in grey-scale
mydata100 %>%
  ggplot(aes(x=gender, fill=workshop)) +
  geom_histogram(position = "dodge") +
  scale_fill_grey(start=0, end=1)

# facet on gender
mydata100 %>%
  ggplot(aes(x=workshop)) +
  geom_histogram(position = "dodge") +
  scale_fill_grey(start=0, end=1) +
  facet_grid(gender~.)

# 
myTemp <- data.frame(
   myGroup=factor( c("Before","After") ),
   myMeasure=c(40, 60)
)

ggplot(data=myTemp, aes(myGroup, myMeasure) ) +
   geom_bar()


ggplot(mydata100, aes(workshop ) ) +
  geom_point(stat = "bin", size = 3) + coord_flip() +
  facet_grid(gender ~ .)

ggplot(mydata100, aes(posttest) ) +
  geom_histogram(color="white", binwidth=0.5)

#density plot
ggplot(mydata100, aes(posttest)) +
  geom_histogram(color="white") +
  geom_density()+
  geom_rug()

# qq plots
mydata100 %>%
  ggplot(aes(sample=posttest)) +
  stat_qq()

mydata100 %>%
  ggplot(aes(x=pretest, y=posttest, 
             position_jitter(x=2,y=2))) +
  geom_point() +
  geom_jitter(position="jitter")
  

# geom_density2D
mydata100 %>%
  ggplot(aes(x=pretest, y=posttest)) +
  geom_point() +
  geom_density2d()

#hexbin plot
mydata100 %>%
  ggplot(aes(x=pretest, y=posttest)) +
  geom_point() +
  geom_hex()

# with geom_smooth()
mydata100 %>%
  ggplot(aes(x=pretest, y=posttest)) +
  geom_point() +
  geom_smooth()
  

#showing text for points
mydata100 %>%
  ggplot(aes(x=pretest, y=posttest, 
             label=as.character(gender))) +
  geom_text(size=3)

#
  