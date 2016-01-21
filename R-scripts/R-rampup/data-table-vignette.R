# data-table
require(data.table)

dt = data.table(x=c("b","b","b","a","a"),v=rnorm(5))
class(dt)
dt
dt['b',]
setkey(dt,x)

dt['b',]

sapply(dt, class)

tables()

dt[2,]

dt[x=='b',]

dt['b', mult='first']

dt['b', mult='last']

dt[,sum(v)]

dt[,sum(v), by=x]
# OR

require(dplyr)
dt %>%
  group_by(x) %>%
  summarise(v1=sum(v))

# OR
tapply(dt$v,dt$x,sum)


grpsize = ceiling(1e7/26^2) # 10 million rows, 676 groups

tt=system.time( df <- data.frame(
  x=rep(LETTERS,each=26*grpsize),
  y=rep(letters,each=grpsize),
  v=runif(grpsize*26^2),
  stringsAsFactors=FALSE)
  )
dim(df)
head(df)


dt1 <- as.data.table(df)

system.time(dt1[,sum(v), by=x])

system.time(
  dt1 %>%
  group_by(x) %>%
  summarize(V1=sum(v))
)

system.time(tapply(dt1$v,dt1$x,sum ))


system.time(
dt1 %>%
  group_by(x, y) %>%
  summarise(V1=sum(v))
)

system.time(
  dt1[,sum(v), by="x,y"]
)

system.time(
  tapply(dt1$v, list(dt1$x, dt1$y), sum)
)

# extra examples
require(MASS)

str(Cars93)

dt_car <- as.data.table(Cars93)

dt_car[, mean(MPG.city), by='Origin']

dt_car %>%
  group_by(Origin) %>%
  summarise(mean(MPG.city))

tapply(dt_car$MPG.city, dt_car$Origin, mean)

sapply(split(dt_car$MPG.city, dt_car$Origin), mean)

plot(Cars93$MPG.city, col = Cars93$Origin)
by(Cars93, Cars93$Origin)

lm(MPG.city~Origin+Weight, data=Cars93)

# lm Price based on Cylinders for different Origins
by(Cars93, Cars93$Origin,
   function(x) lm(Price ~ Cylinders, data=x))


flights <- fread("C:/Ahmed/ML/dataset local copy/flights14.csv")

#DT[i, j, by]

##   R:      i                 j        by
## SQL:  where   select | update  group by

head(flights[origin == "JFK" & month == 6L])

flights[1:2]

head(flights[order(origin, -dest)])

#return as a list
head(flights[, arr_delay])

#return as a data.table
flights[, list(arr_delay)]

ans <- flights[, .(arr_delay, dep_delay)]
head(ans)

# Select both arr_delay and dep_delay columns and rename them to delay_arr and delay_dep.

ans <- flights[, .(delay_arr = arr_delay, delay_dep = dep_delay)]
head(ans)

#How many trips have had total delay < 0?

ans <- flights[, sum((arr_delay + dep_delay) < 0)]
ans

# OR old-school way

nrow(flights[which((arr_delay+dep_delay) < 0)])


# Calculate the average arrival and departure delay for all flights
# with "JFK" as the origin airport in the month of June

ans <- flights[origin == "JFK" & month == 6L, 
               .(m_arr=mean(arr_delay), m_dep=mean(dep_delay))]

ans

# OR
apply(flights[which(origin=="JFK" & month==6),
              .(arr_delay, dep_delay)],
      MARGIN = 2, mean)


# How many trips have been made in 2014 from "JFK" airport in 
# the month of June?

flights[(origin=="JFK" & month==6L & year==2014L), length(dest)]

flights[(origin=="JFK" & month==6L & year==2014L), .N]

# OR
flights %>%
  filter(origin=="JFK" & month==6) %>%
  summarise(count=n())

#


# Select both arr_delay and dep_delay columns the data.frame way.
ans <- flights[, c("arr_delay", "dep_delay"), with=FALSE]
head(ans)


# returns all columns except arr_delay and dep_delay
ans <- flights[, !c("arr_delay", "dep_delay"), with=FALSE]
# or
ans <- flights[, -c("arr_delay", "dep_delay"), with=FALSE]
head(ans)


# returns year,month and day
ans <- flights[, year:day, with=FALSE]
# returns day, month and year
ans <- flights[, day:year, with=FALSE]
# returns all columns except year, month and day
ans <- flights[, -(year:day), with=FALSE]
ans <- flights[, !(year:day), with=FALSE]
head(ans)


#How can we get the number of trips corresponding to each origin 
# airport?
flights[,.N, by=origin]

flights[, .N, by=.(origin)]

flights %>%
  group_by(origin) %>%
  summarise(N=n())

flights[, .N, by=.(origin, month)]

# How can we calculate the number of trips for each origin airport for
# carrier code "AA"?

flights[carrier=='AA', .N, by=.(origin)]

# How can we get the total number of trips for each origin, 
# dest pair for carrier code "AA"?
flights[carrier=='AA', .N, by=.(origin, dest)]

flights %>%
  filter(carrier=='AA') %>%
  group_by(origin, dest) %>%
  summarise(N=n())

# incorrect??
with(flights, tapply(carrier, list(origin, dest), length))

# How can we get the average arrival and departure delay for each 
# orig,dest pair for each month for carrier code "AA"?
flights[carrier=='AA',.(avg_arr_del = mean(arr_delay), 
                        avg_dep_del = mean(dep_delay)) ,
        by=.(origin,dest)]

# OR
flights %>%
  filter(carrier=='AA') %>%
  group_by(origin, dest) %>%
  summarise(avg_arr_del=mean(arr_delay), 
            avg_dep_del=mean(dep_delay))


# So how can we directly order by origin, dest
flights[carrier=='AA',.(avg_arr_del = mean(arr_delay), 
                        avg_dep_del = mean(dep_delay)) ,
        keyby=.(origin,dest)]

# keyby all gruping variables
flights[carrier=='AA',.(avg_arr_del = mean(arr_delay), 
                        avg_dep_del = mean(dep_delay)) ,
        keyby=.(origin,dest, month)]

flights %>%
  filter(carrier=='AA') %>%
  group_by(origin, dest) %>%
  summarise(mean(arr_delay), mean(dep_delay)) %>%
  arrange(origin, dest)

#using origin, dest, month grouping
flights %>%
  filter(carrier=='AA') %>%
  group_by(origin, dest, month) %>%
  summarise(mean(arr_delay), mean(dep_delay)) %>%
  arrange(origin, dest, month)

ans <- flights[carrier == "AA", .N, by = .(origin, dest)]

# How can we order ans using the columns origin in ascending order,
# and dest in descending order?
ans[order(origin, -dest)]

flights[carrier == "AA", .N, by=.(origin, dest)][order(origin, -dest)]

# find out how many flights started late but arrived early 
# (or on time), started and arrived late 

flights[, .N, .(dep_delay >0, arr_delay >0)]

# False, False excluded, rest are added to give 134012
flights[dep_delay >0 | arr_delay >0, .N]

# OR
flights %>%
  filter(dep_delay >0 | arr_delay >0) %>%
  summarise(N=n())

# Now let us try to use .SD along with .SDcols to get
# the mean() of arr_delay and dep_delay columns grouped by origin,
# dest and month

flights[carrier=='AA',
        lapply(.SD, mean) , 
        by=.(origin, dest, month), 
        .SDcols=c("arr_delay", "dep_delay")]

# How can we return the first two rows for each month?
flights[, head(.SD, 2), by=month]
