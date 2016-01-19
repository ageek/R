# germany gmap example

# Get the right data
ger <- read.table(text="lon lat
                  6.585863 51.09021
                  8.682127 50.11092
                  7.460367 51.52755", header = TRUE, strip.white = TRUE)

# Finding a good centerpoint
mean(ger$lon) # outcome: 7.576119
mean(ger$lat) # outcome: 50.90956

# Get the map; you might have to try several zoomlevels te get the right one
library(ggmap)
mapImageData <- get_googlemap(center = c(lon = 7.576119, lat = 50.90956), zoom=8)

# Plot the points on the map
ggmap(mapImageData) +
  geom_point(data=ger, aes(x=lon, y=lat), colour="red", size=6, alpha=.6)


# sample points on boston

boston <- read.table(text="lat lon
                  42.29324636 -71.06722456
                  42.28260136 -71.05569957
                  42.35455043 -71.12670472
                  42.24326137 -71.13766454", header = TRUE, strip.white = TRUE)

library(ggmap)
mapImageData <- get_googlemap(center = c(lon = mean(boston$lon), lat = mean(boston$lat)), zoom=12)

# Plot the points on the map
ggmap(mapImageData) +
  geom_point(data=boston, aes(x=lon, y=lat), colour="red", size=6, alpha=.6)
