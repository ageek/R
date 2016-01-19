> foreach(i=1:10) %do% { i }
[[1]]
[1] 1

...
[[10]]
[1] 10



list<-foreach(i=1:10) %do% {  
i  
}

Note that the foreach loop returns a list of values by default. The foreach package will always return a result with the items in the same order as the counter, even when running in parallel. For example, the above loop will return a list with indices 1 through 10, each containing the same value as their index(1 to 10).

In order to return the results as a matrix, you will need to alter the .combine behavior of the foreach loop. This is done in the following code:

matrix<-foreach(i=1:10,.combine=cbind) %do% {  
i  
}
This will return a matrix with 10 columns, with values in order from 1 to 10.

> m <- foreach(i=1:10, .combine = cbind) %do% {
+ i
+ }
> m
     result.1 result.2 result.3 result.4 result.5 result.6 result.7 result.8
[1,]        1        2        3        4        5        6        7        8
     result.9 result.10
[1,]        9        10



Likewise, this will return a matrix with 10 rows:

matrix<-foreach(i=1:10,.combine=rbind) %do% {  
i  
}


> mr <- foreach(i=1:10, .combine = rbind) %do% {
+ i
+ }
> mr
          [,1]
result.1     1
result.2     2
result.3     3
result.4     4
result.5     5
result.6     6
result.7     7
result.8     8
result.9     9
result.10   10


> mtx2<-foreach(i=1:10,.combine=rbind) %do% {  
+     c(i,sqrt(i), i*i)  
+ }
> mtx2
          [,1]     [,2] [,3]
result.1     1 1.000000    1
result.2     2 1.414214    4
result.3     3 1.732051    9
result.4     4 2.000000   16
result.5     5 2.236068   25
result.6     6 2.449490   36
result.7     7 2.645751   49
result.8     8 2.828427   64
result.9     9 3.000000   81
result.10   10 3.162278  100
> 


> require(doParallel)
Loading required package: doParallel
Loading required package: iterators
> registerDoParallel(makeCluster(4))

c1 <- makeCluster(4)
> registerDoParallel(c1)
> data <- foreach(i=1:20, .combine = cbind) %dopar% {}
> data <- foreach(i=1:20, .combine = cbind) %dopar% {
+ c(i, i*i, i*i*i, sqrt(i))
+ }
stopCluster(c1)
> data
     result.1 result.2  result.3 result.4   result.5  result.6   result.7
[1,]        1 2.000000  3.000000        4   5.000000   6.00000   7.000000
[2,]        1 4.000000  9.000000       16  25.000000  36.00000  49.000000
[3,]        1 8.000000 27.000000       64 125.000000 216.00000 343.000000
[4,]        1 1.414214  1.732051        2   2.236068   2.44949   2.645751
       result.8 result.9   result.10   result.11   result.12   result.13
[1,]   8.000000        9   10.000000   11.000000   12.000000   13.000000
[2,]  64.000000       81  100.000000  121.000000  144.000000  169.000000
[3,] 512.000000      729 1000.000000 1331.000000 1728.000000 2197.000000
[4,]   2.828427        3    3.162278    3.316625    3.464102    3.605551
       result.14   result.15 result.16   result.17   result.18   result.19
[1,]   14.000000   15.000000        16   17.000000   18.000000   19.000000
[2,]  196.000000  225.000000       256  289.000000  324.000000  361.000000
[3,] 2744.000000 3375.000000      4096 4913.000000 5832.000000 6859.000000
[4,]    3.741657    3.872983         4    4.123106    4.242641    4.358899
       result.20
[1,]   20.000000
[2,]  400.000000
[3,] 8000.000000
[4,]    4.472136
