#data.table-getting-started-1
#https://rawgit.com/wiki/Rdatatable/data.table/vignettes/datatable-intro-vignette.html
require(data.table)


flights <- fread("C:/Ahmed/ML/dataset local copy/flights14.csv")
dim(flights)
class(flights)

DT = data.table(ID = c("b","b","b","a","a","c"), a = 1:6, b = 7:12, c=13:18)
class(DT$ID)

ans <- flights[origin == "JFK" & month == 6L]

#same as 
ans <- flights[origin=='JFK' & month==6L,]


ans <- flights[1:2]
ans

ans <- flights[order(origin, -dest)]
head(ans)

ans <- flights[order(-origin, dest)]
head(ans)

#Select arr_delay column, but return it as a vector
ans <- flights[, arr_delay]
head(ans)

#- Select arr_delay column, but return as a data.table instead
ans <- flights[, list(arr_delay)]
head(ans)

# data.table also allows using .() to wrap columns with. It is an alias
# to list(); they both mean the same. Feel free to use whichever you prefer.

ans <- flights[, .(arr_delay)]
head(ans)

#Select both arr_delay and dep_delay columns.
ans <- flights[, .(arr_delay, dep_delay)]
head(ans)

#Select both arr_delay and dep_delay columns and rename
# them to delay_arr and delay_dep.
ans <- flights[, .(delay_arr=arr_delay, delay_dep=dep_delay)]
head(ans)

#How many trips have had total delay < 0?
ans <- flights[, sum((arr_delay + dep_delay) < 0)]
head(ans)

#Subset in i and do in j
#- Calculate the average arrival and departure delay for 
#  all flights with "JFK" as the origin airport in the month of June.

ans <- flights[origin=="JFK" & month==6L, .(mean_arr=mean(arr_delay), 
                                     mean_dep=mean(dep_delay)) ]
head(ans)
ans

#using dplyr
require(dplyr)
flights %>%
  filter(origin=="JFK" & month==6L) %>%
  summarize(mean_arr=mean(arr_delay), mean_dep=mean(dep_delay))

#using aggregate--not working....TODO
aggregate(flights$arr_delay, 
   list(flights$origin=="JFK" & flights$month==6), mean)



# How many trips have been made in 2014 from "JFK" airport in
# the month of June?
# we want count of filtered rows, so lenght(x)
# where x is any column will just work fine
ans <- flights[month==6L & origin=="JFK", length(dest)]
ans

#using dplyr
flights %>%
  filter(month==6 & origin=="JFK") %>%
  summarise(Count=length(dest))

#not working -- TODO
aggregate(flights$dest, list(month==6, 
                        origin=="JFK"), 
          length(flights$dest))


# data.table contains .N which is count of rows
# so the last query can be written as this as well
ans <- flights[origin=="JFK" & month==6L, .N]
ans

#Select both arr_delay and dep_delay columns the data.frame way.
#using with=FALSE
ans <- flights[, c("arr_delay", "dep_delay"), with=F]
head(ans)


# How can we get the number of trips corresponding to each 
# origin airport?
ans <- flights[,.(.N), by=.(origin)]
ans

#When there's only one column or expression to refer to in j
# and by, we can drop the .() notation. This is purely for convenience. We could instead do:

ans <- flights[, .N, by=origin]
ans

#How can we calculate the number of trips for each origin airport
# for carrier code "AA"?
ans <- flights[carrier=="AA", .N, by=origin]
ans


#OR
ans <- flights[, .(.N), by="origin"]
ans

# How can we get the total number of trips for each origin, 
# dest pair for carrier code "AA"?
ans <- flights[carrier=="AA", .N, by=.(origin, dest)]
ans

#using dplyr
require(dplyr)
flights %>%
  filter(carrier=="AA") %>%
  group_by(origin, dest) %>%
  summarize(N=n())

#not working- TODO
aggregate(flights, list=(origin,dest), length)

#aggregate(dest~origin, data=flights, length)

# OR
ans <- flights[carrier == "AA", .N, by=c("origin", "dest")]
ans

#How can we get the average arrival and departure delay for 
# each orig,dest pair for each month for carrier code "AA"?

ans <- flights[carrier=="AA", .(avg_dep_delay=mean(dep_delay), 
                                avg_arr_delay=mean(arr_delay)), 
               by=.(origin,dest,month)]
ans

#using dplyr
flights %>%
  filter(carrier=="AA") %>%
  group_by(origin, dest, month) %>%
  summarize(avg_dep_delay=mean(dep_delay), 
            avg_arr_delay=mean(arr_delay))

#using sqldf - working
require(sqldf)
res <- sqldf("select origin, dest, month, 
              avg(dep_delay) as avg_dep_delay, 
              avg(arr_delay) as avg_arr_delay from flights 
              where carrier==\"AA\" 
              group by origin,dest,month")

res

# So how can we directly order by all the grouping variables?

res <- flights[carrier=="AA", .(mean(arr_delay), mean(dep_delay)), 
               keyby=.(origin, dest, month)]
res

#using dplyr
flights %>%
  filter(carrier=="AA") %>%
  group_by(origin, dest, month) %>%
  summarize(avg_dep_delay=mean(dep_delay), 
            avg_arr_delay=mean(arr_delay)) %>%
  arrange(origin, dest, month)


# getting the total number of trips for each origin, dest 
# pair for carrier "AA".
ans <- flights[carrier == "AA", .N, keyby = .(origin, dest)]  
ans
ans <- ans[order(origin, -dest)]
ans

# But this requires having to assign the intermediate result 
#and then overwriting that result. We can do one better and 
#avoid this intermediate assignment on to a variable altogther
#by chaining expressions.
ans <- flights[carrier == "AA", .N, by=.(origin, dest)
               ][order(origin, -dest)]
head(ans)
  
# find out how many flights started late but arrived early (or on time), started and arrived late

ans <- flights[, .N, .(dep_delay > 0, arr_delay > 0)]
ans

#Confusing example
DT = data.table(ID = c("b","b","b","a","a","c"), a = 1:6, b = 7:12, c=13:18)
DT

DT[,print(.SD), by=ID]

DT[, lapply(.SD, mean), by=ID]

DT= data.table(ID=c("b","b","b","a","a","c"), x = 1:6, y = 7:12, z=13:18)
DT

DT[,print(.SD), by=ID]

DT[, lapply(.SD, mean), by=ID]

flights[carrier=="AA", lapply(.SD, mean), 
        by=.(origin, dest, month), 
        .SDcols=c("arr_delay", "dep_delay")]

# How can we return the first two rows for each month?
ans <- flights[, head(.SD, 2), by=month]
head(ans)
