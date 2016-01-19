url <- "http://rosetta.reltech.org/TC/v15/Mapping/data/dist-Aus.csv"
dist.au <- read.csv(url)

row.names(dist.au) <- dist.au[, 1]
dist.au <- dist.au[, -1]
dist.au

fit <- cmdscale(dist.au, eig = TRUE, k = 2)
x <- fit$points[, 1]
y <- fit$points[, 2]

plot(x, y, pch = 19, xlim = range(x) + c(0, 600))
city.names <- c("Adelaide", "Alice Springs", "Brisbane", "Darwin", "Hobart", 
                "Melbourne", "Perth", "Sydney")
text(x, y, pos = 4, labels = city.names)


x <- 0 - x
y <- 0 - y
plot(x, y, pch = 19, xlim = range(x) + c(0, 600))
text(x, y, pos = 4, labels = city.names)


library(igraph)
g <- graph.full(nrow(dist.au))
V(g)$label <- city.names
layout <- layout.mds(g, dist = as.matrix(dist.au))
plot(g, layout = layout, vertex.size = 3)
