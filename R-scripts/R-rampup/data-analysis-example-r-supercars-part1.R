# data-analysis-example-r-supercars-part1

library(dplyr)
library(ggplot2)

###################
# IMPORT datasets #
###################


df.car_torque <- read.csv(url("http://www.sharpsightlabs.com/wp-content/uploads/2014/11/auto-snout_torque_DATA.txt"))
df.car_0_60_times  <- read.csv(url("http://www.sharpsightlabs.com/wp-content/uploads/2014/11/auto-snout_0-60-times_DATA.txt"))
df.car_engine_size <- read.csv(url("http://www.sharpsightlabs.com/wp-content/uploads/2014/11/auto-snout_engine-size_DATA.txt"))
df.car_horsepower  <- read.csv(url("http://www.sharpsightlabs.com/wp-content/uploads/2014/11/auto-snout_horsepower_DATA.txt"))
df.car_top_speed   <- read.csv(url("http://www.sharpsightlabs.com/wp-content/uploads/2014/11/auto-snout_top-speed_DATA.txt"))
df.car_power_to_weight <- read.csv(url("http://www.sharpsightlabs.com/wp-content/uploads/2014/11/auto-snout_power-to-weight_DATA.txt"))


#-------------------------
# Inspect data with head()
#-------------------------
head(df.car_torque)
head(df.car_0_60_times)
head(df.car_engine_size)
head(df.car_horsepower)
head(df.car_top_speed)
head(df.car_power_to_weight)


##############################
# LOOK FOR DUPLICATE RECORDS #
##############################
df.car_torque      %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count!=1)
df.car_0_60_times  %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count!=1)
df.car_engine_size %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count!=1)
df.car_horsepower  %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count!=1)
df.car_top_speed   %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count!=1)
df.car_power_to_weight %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count!=1)


# NOTE: duplicate records!
# several datasets have duplicate rows for the following cars (car_full_nm)

# Chevrolet Chevy II Nova SS 283 V8 Turbo Fire - [1964]     2
#           Koenigsegg CCX 4.7 V8 Supercharged - [2006]     2
#                   Pontiac Bonneville 6.4L V8 - [1960]     2

# unique(df.car_power_to_weight) %>% group_by(car_full_nm) %>% summarize(count=n()) %>% filter(count!=1)



