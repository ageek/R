# data.table - Reference Semantic - 
# https://rawgit.com/wiki/Rdatatable/data.table/vignettes/datatable-reference-semantics.html

require(data.table)

#fread reads the data/csv directly into a data.table format
flights <- fread("C:/Ahmed/ML/dataset local copy/flights14.csv")
dim(flights)
class(flights)

dt = flights
#The := operator
dt

dt[,`:=`(speed=distance/(air_time/60), 
         delay=arr_delay+dep_delay)]

head(dt)
# not working ??
dt[,head(.SD,2 ), `:=`(speed =  distance/(air_time/60), 
                         delay = (arr_delay + dep_delay)), 
   by=.(month)]


# new column addition using long form
# alternatively, using the 'LHS := RHS' form
dt[,c("speed","delay"):=list(distance/(air_time/60), 
                             (arr_delay + dep_delay))]
head(dt)

# Replace those rows where hour == 24 with the value 0
dt[hour==24L, hour:=0L][]


# Remove delay column
dt[, c("delay") := NULL]
head(dt)

# or using the short form
dt[, `:=`(delay=NULL)]
head(dt)


# := along with grouping using by

dt[,max_speed:=max(speed), by=.(origin, dest)]
head(dt)

require(dplyr)
flights %>%
  select(speed, origin, dest) %>%
  group_by(origin, dest) %>%
  summarize(max_speed=max(speed))
  
# How can we add two more columns computing max() of 
# dep_delay and arr_delay for each month, using .SD?

dt[, c("max_dep_delay", "max_arr_delay") := lapply(.SD, max), 
   by = .(month), .SDcols = c("dep_delay", "arr_delay")]
head(dt)


# Before moving on to the next section, let's clean up the 
# newly created columns speed, max_speed, max_dep_delay and max_arr_delay.

dt[, c("max_dep_delay", "max_arr_delay", "dep_delay", "arr_delay" ) := NULL]
head(dt)


# := for its side effect
# Let's say we would like to create a function that would 
# return the maximum speed for each month. But at the same time, 
# we would also like to add the column speed to flights. 
foo <- function(DT) {
  DT[, speed := distance/(air_time/60)]
  # OR , this also works (not always, make sure you know which is which!!!)
  # this just returns the speed column instead of the full data.table
  # DT[, .(speed=distance/(air_time/60))]
  DT[, .(max_speed = max(speed)), by=.(month)]
}
foo(dt)

# IMP:
#this just returns the speed column
dt[, .(speed=distance/(air_time/60))]

#this also adds speed column, but returns the full data.table
dt[, speed := distance/(air_time/60)]
head(dt)

# The copy() function


# clear speed column
dt[, c("speed", "max_speed"):= NULL]

foo <- function(DT) {
  DT <- copy(DT)   # deep copy
  DT[, speed := distance/(air_time/60)]
  DT[, .(max_speed = max(speed)), by=.(month)]
}
ans <- foo(flights)
head(flights)

head(ans)

