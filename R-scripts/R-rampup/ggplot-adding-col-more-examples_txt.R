R version 3.2.0 (2015-04-16) -- "Full of Ingredients"
Copyright (C) 2015 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Workspace loaded from ~/.RData]

> require(ggmap)
Loading required package: ggmap
Loading required package: ggplot2
Google Maps API Terms of Service: http://developers.google.com/maps/terms.
Please cite ggmap if you use it: see citation('ggmap') for details.
> bos_plot<-ggmap(get_map("Boston, Massachusetts",zoom=13))
Error in download.file(url, destfile = tmp, quiet = !messaging, mode = "wb") : 
  cannot open URL 'http://maps.googleapis.com/maps/api/staticmap?center=Boston,+Massachusetts&zoom=13&size=640x640&scale=2&maptype=terrain&language=en-EN&sensor=false'
In addition: Warning message:
In download.file(url, destfile = tmp, quiet = !messaging, mode = "wb") :
  cannot open: HTTP status was '403 Forbidden'
> bos_plot<-ggmap(get_map("Boston, Massachusetts",zoom=13))
Error in download.file(url, destfile = tmp, quiet = !messaging, mode = "wb") : 
  cannot open URL 'http://maps.googleapis.com/maps/api/staticmap?center=Boston,+Massachusetts&zoom=13&size=640x640&scale=2&maptype=terrain&language=en-EN&sensor=false'
In addition: Warning message:
In download.file(url, destfile = tmp, quiet = !messaging, mode = "wb") :
  cannot open: HTTP status was '403 Forbidden'
> cars
   speed dist
1      4    2
2      4   10
3      7    4
4      7   22
5      8   16
6      9   10
7     10   18
8     10   26
9     10   34
10    11   17
11    11   28
12    12   14
13    12   20
14    12   24
15    12   28
16    13   26
17    13   34
18    13   34
19    13   46
20    14   26
21    14   36
22    14   60
23    14   80
24    15   20
25    15   26
26    15   54
27    16   32
28    16   40
29    17   32
30    17   40
31    17   50
32    18   42
33    18   56
34    18   76
35    18   84
36    19   36
37    19   46
38    19   68
39    20   32
40    20   48
41    20   52
42    20   56
43    20   64
44    22   66
45    23   54
46    24   70
47    24   92
48    24   93
49    24  120
50    25   85
> str(mpg)
'data.frame':	234 obs. of  11 variables:
 $ manufacturer: Factor w/ 15 levels "audi","chevrolet",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ model       : Factor w/ 38 levels "4runner 4wd",..: 2 2 2 2 2 2 2 3 3 3 ...
 $ displ       : num  1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
 $ year        : int  1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
 $ cyl         : int  4 4 4 4 6 6 6 4 4 4 ...
 $ trans       : Factor w/ 10 levels "auto(av)","auto(l3)",..: 4 9 10 1 4 9 1 9 4 10 ...
 $ drv         : Factor w/ 3 levels "4","f","r": 2 2 2 2 2 2 2 1 1 1 ...
 $ cty         : int  18 21 20 21 16 18 18 18 16 20 ...
 $ hwy         : int  29 29 31 30 26 26 27 26 25 28 ...
 $ fl          : Factor w/ 5 levels "c","d","e","p",..: 4 4 4 4 4 4 4 4 4 4 ...
 $ class       : Factor w/ 7 levels "2seater","compact",..: 2 2 2 2 2 2 2 2 2 2 ...
> ggplot(mpg, aes(x=year))+geom_point()
Error in exists(name, envir = env, mode = mode) : 
  argument "env" is missing, with no default
> ggplot(mpg, aes(x=year y= hwy))+geom_point()
Error: unexpected symbol in "ggplot(mpg, aes(x=year y"
> ggplot(mpg, aes(x=year, y=hwy))+geom_point()
> table(mpg$year)

1999 2008 
 117  117 
> tapply(mpg$cty, mpg$year, mean)
    1999     2008 
17.01709 16.70085 
> tapply(mpg$cty, mpg$year, median)
1999 2008 
  17   17 
> boxplot(mpg$year ~ mpg$cty)
> boxplot(mpg$cty ~ mpg$year)
> ggplot(mpg, aes(x=year, y=cty)) +geom_boxplot()
> boxplot(mpg$cty ~ mpg$year)
> ggplot(mpg, aes(x=year, y=cty)) +geom_boxplot()
> ggplot(mpg, aes(x=factor(year), y=cty)) +geom_boxplot()
>  p <- ggplot(mpg, aes(x=factor(year), y=cty)) +geom_boxplot()
> p
> p + facet_wrap(drv~.)
Error in layout_base(data, vars, drop = drop) : 
  At least one layer must contain all variables used for facetting
> ggplot(mpg, aes(x=factor(year), y=cty)) +geom_boxplot() + facet_wrap(drv~.)
Error in layout_base(data, vars, drop = drop) : 
  At least one layer must contain all variables used for facetting
> table(mpg$drv)

  4   f   r 
103 106  25 
> ggplot(mpg, aes(x=factor(year), y=hwy)) +geom_boxplot()
> ggplot(mpg, aes(x=factor(year), y=hwy)) +geom_boxplot() facet_wrap(drv~.)
Error: unexpected symbol in "ggplot(mpg, aes(x=factor(year), y=hwy)) +geom_boxplot() facet_wrap"
> ggplot(mpg, aes(x=factor(year), y=hwy)) +geom_boxplot()+ facet_wrap(drv~.)
Error in layout_base(data, vars, drop = drop) : 
  At least one layer must contain all variables used for facetting
> ggplot(mpg, aes(x=factor(displ), y=hwy)) +geom_boxplot()+ facet_wrap(drv~.)
Error in layout_base(data, vars, drop = drop) : 
  At least one layer must contain all variables used for facetting
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_boxplot()+ facet_wrap(drv~.)
Error in layout_base(data, vars, drop = drop) : 
  At least one layer must contain all variables used for facetting
> select(mpg, drv, year, cty) %>%
+ group_by (year, drv) %>%
+ summarize(N=n())
Error: could not find function "%>%"
> require(dplyr)
Loading required package: dplyr

Attaching package: ‘dplyr’

The following object is masked from ‘package:stats’:

    filter

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

> select(mpg, drv, year, cty) %>%
+ group_by (year, drv) %>%
+ summarize(N=n())
Source: local data frame [6 x 3]
Groups: year

  year drv  N
1 1999   4 49
2 1999   f 57
3 1999   r 11
4 2008   4 54
5 2008   f 49
6 2008   r 14
> ggplot(mpg, aes(x=factor(year), y=hwy)) +geom_boxplot()
> ggplot(mpg[mpg$drv==4,], aes(x=factor(year), y=hwy)) +geom_boxplot()
> ggplot(mpg[mpg$drv==f,], aes(x=factor(year), y=hwy)) +geom_boxplot()
Error in `[.data.frame`(mpg, mpg$drv == f, ) : object 'f' not found
> ggplot(mpg[mpg$drv=='f',], aes(x=factor(year), y=hwy)) +geom_boxplot()
> t <- select(mpg, drv, year, cty) %>%
+ group_by (year, drv) %>%
+ summarize(N=n())
> t
Source: local data frame [6 x 3]
Groups: year

  year drv  N
1 1999   4 49
2 1999   f 57
3 1999   r 11
4 2008   4 54
5 2008   f 49
6 2008   r 14
> ggplot(t, aes(x=year, y=drv))+geom_boxplot()
> ggplot(t, aes(x=year))+geom_boxplot()
Error: stat_boxplot requires the following missing aesthetics: y
> ggplot(t, aes(x=year, y=N))+geom_boxplot()
> ggplot(t, aes(x=factor(year), y=N))+geom_boxplot()
> ggplot(t, aes(x=factor(year), y=N))+geom_boxplot() +facet_wrap(drv~.)
Error in layout_base(data, vars, drop = drop) : 
  At least one layer must contain all variables used for facetting
> ggplot(t, aes(x=factor(year), y=drv))+geom_boxplot() +facet_wrap(drv~.)
Error in layout_base(data, vars, drop = drop) : 
  At least one layer must contain all variables used for facetting
> ggplot(t, aes(x=factor(year), y=N))+geom_boxplot() +facet_wrap(drv~.)
Error in layout_base(data, vars, drop = drop) : 
  At least one layer must contain all variables used for facetting
> ggplot(t, aes(x=factor(year), y=N))+geom_boxplot()
> ggplot(t, aes(x=drv, y=year))+geom_boxplot()
> ggplot(t, aes(x=factor(year), y=N))+geom_histogram()
Error : Mapping a variable to y and also using stat="bin".
  With stat="bin", it will attempt to set the y value to the count of cases in each group.
  This can result in unexpected behavior and will not be allowed in a future version of ggplot2.
  If you want y to represent counts of cases, use stat="bin" and don't map a variable to y.
  If you want y to represent values in the data, use stat="identity".
  See ?geom_bar for examples. (Defunct; last used in version 0.9.2)
> ggplot(t, aes(x=factor(year), y=N))+geom_histogram(stat='identity')
> tapply(t$drv, t$year, sum)
Error in Summary.factor(1:3, na.rm = FALSE) : 
  ‘sum’ not meaningful for factors
> tapply(t$drv, t$year, length)
1999 2008 
   3    3 
> t
Source: local data frame [6 x 3]
Groups: year

  year drv  N
1 1999   4 49
2 1999   f 57
3 1999   r 11
4 2008   4 54
5 2008   f 49
6 2008   r 14
> tapply(t, t$year, length)
Error in tapply(t, t$year, length) : arguments must have same length
> tapply(t, t$year, sum)
Error in tapply(t, t$year, sum) : arguments must have same length
> t %>% group_by (year) %>% summarize(total=sum(N))
Source: local data frame [2 x 2]

  year total
1 1999   117
2 2008   117
> ggplot(t, aes(x=drv, y=N)) +geom_histogram()
Error : Mapping a variable to y and also using stat="bin".
  With stat="bin", it will attempt to set the y value to the count of cases in each group.
  This can result in unexpected behavior and will not be allowed in a future version of ggplot2.
  If you want y to represent counts of cases, use stat="bin" and don't map a variable to y.
  If you want y to represent values in the data, use stat="identity".
  See ?geom_bar for examples. (Defunct; last used in version 0.9.2)
> ggplot(t, aes(x=drv, y=N)) +geom_histogram(stat='identity')
> mpg
    manufacturer                  model displ year cyl      trans drv cty hwy fl
1           audi                     a4   1.8 1999   4   auto(l5)   f  18  29  p
2           audi                     a4   1.8 1999   4 manual(m5)   f  21  29  p
....
226 subcompact
227 subcompact
228    midsize
229    midsize
230    midsize
231    midsize
232    midsize
233    midsize
234    midsize
> 

> 

> str(mpg)
'data.frame':	234 obs. of  11 variables:
 $ manufacturer: Factor w/ 15 levels "audi","chevrolet",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ model       : Factor w/ 38 levels "4runner 4wd",..: 2 2 2 2 2 2 2 3 3 3 ...
 $ displ       : num  1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
 $ year        : int  1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
 $ cyl         : int  4 4 4 4 6 6 6 4 4 4 ...
 $ trans       : Factor w/ 10 levels "auto(av)","auto(l3)",..: 4 9 10 1 4 9 1 9 4 10 ...
 $ drv         : Factor w/ 3 levels "4","f","r": 2 2 2 2 2 2 2 1 1 1 ...
 $ cty         : int  18 21 20 21 16 18 18 18 16 20 ...
 $ hwy         : int  29 29 31 30 26 26 27 26 25 28 ...
 $ fl          : Factor w/ 5 levels "c","d","e","p",..: 4 4 4 4 4 4 4 4 4 4 ...
 $ class       : Factor w/ 7 levels "2seater","compact",..: 2 2 2 2 2 2 2 2 2 2 ...
> ggplot(mpg, aes(x=factor(year), y=displ)) +geom_boxplot()
> ggplot(mpg, aes(x=factor(year), y=displ)) +geom_boxplot() +facet_wrap(drv~.)
Error in layout_base(data, vars, drop = drop) : 
  At least one layer must contain all variables used for facetting
> mpg %>% group_by(year, drv) %>% summarize(meanDisp=mean(displ))
Source: local data frame [6 x 3]
Groups: year

  year drv meanDisp
1 1999   4 3.879592
2 1999   f 2.440351
3 1999   r 4.972727
4 2008   4 4.105556
5 2008   f 2.695918
6 2008   r 5.335714
> mpg %>% group_by(year) %>% summarize(meanDisp=mean(displ))
Source: local data frame [2 x 2]

  year meanDisp
1 1999 3.281197
2 2008 3.662393
> t1 <- mpg %>% group_by(year) %>% summarize(meanDisp=mean(displ))
> ggplot(t1, aes(x=drv, y=meanDisp))+geom_point()
Error in eval(expr, envir, enclos) : object 'drv' not found
> t1 <- mpg %>% group_by(year, drv) %>% summarize(meanDisp=mean(displ))
> ggplot(t1, aes(x=drv, y=meanDisp))+geom_point()
> ggplot(t1, aes(x=drv, y=meanDisp))+geom_boxplot()
> ggplot(mpg, aes(x=factor(year), y=displ)) +geom_boxplot() 
> ggplot(mpg, aes(x=factor(year), y=displ)) +geom_boxplot()  +facet_grid(cyl~.)
> mpg %>% group_by(year, displ, cyl) %>% summarise(meanDisp = mean(displ))
Source: local data frame [54 x 4]
Groups: year, displ

   year displ cyl meanDisp
1  1999   1.6   4      1.6
2  1999   1.8   4      1.8
3  1999   1.9   4      1.9
4  1999   2.0   4      2.0
5  1999   2.2   4      2.2
6  1999   2.4   4      2.4
7  1999   2.5   4      2.5
8  1999   2.5   6      2.5
9  1999   2.7   4      2.7
10 1999   2.8   6      2.8
..  ...   ... ...      ...
> ggplot(mpg, aes(x=factor(year), y=displ)) +geom_boxplot()  +facet_wrap(cyl~.)
Error in layout_base(data, vars, drop = drop) : 
  At least one layer must contain all variables used for facetting
> ggplot(mpg, aes(x=factor(year), y=displ)) +geom_boxplot()  +facet_grid(cyl~.)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point()
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_wrap(drv~.)
Error in layout_base(data, vars, drop = drop) : 
  At least one layer must contain all variables used for facetting
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(drv~.)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(.~cyl)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(drv~.)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(cyl~.)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(cyl~.)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(.~cyl)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(drv~cyl)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(~class)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(.~class)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(~class)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(~class, ncol=3)
Error in facet_grid(~class, ncol = 3) : unused argument (ncol = 3)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_wrap(~class)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_wrap(.~class)
Error in layout_base(data, vars, drop = drop) : 
  At least one layer must contain all variables used for facetting
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_wrap(~class)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(~class)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(.~class)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_wrap(~class)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(.~cyl)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(cyl~.)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(cyl~drv)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(drv~cyl)
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(drv~cyl, scales = 'free')
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(drv~cyl, scales = 'free_y')
> ggplot(mpg, aes(x=displ, y=hwy)) +geom_point() +facet_grid(drv~cyl)
> ggplot(mpg, aes(x=wt, y=mpg))+geom_point()

Don't know how to automatically pick scale for object of type data.frame. Defaulting to continuous
Error in eval(expr, envir, enclos) : object 'wt' not found
> ggplot(mtcars, aes(x=wt, y=mpg))+geom_point()
> ggplot(mtcars, aes(x=wt, y=mpg, col=cyl))+geom_point()
> ggplot(mtcars, aes(x=wt, y=mpg, col=factor(cyl))+geom_point()
+ ggplot(mtcars, aes(x=wt, y=mpg, color=factor(cyl))+geom_point()
Error: unexpected symbol in:
"ggplot(mtcars, aes(x=wt, y=mpg, col=factor(cyl))+geom_point()
ggplot"
> ggplot(mtcars, aes(x=wt, y=mpg, colour=factor(cyl))+geom_point()
+ ggplot(mtcars, aes(x=wt, y=mpg, colour=as.factor(cyl))+geom_point()
Error: unexpected symbol in:
"ggplot(mtcars, aes(x=wt, y=mpg, colour=factor(cyl))+geom_point()
ggplot"
> ggplot(mtcars, aes(x=wt, y=mpg, col=as.factor(cyl))+geom_point()
+ 

> ggplot(mtcars, aes(x=wt, y=mpg, col=as.factor(cyl)))+geom_point()
> ggplot(mtcars, aes(x=wt, y=mpg, col=cyl))+geom_point()
> ggplot(mtcars, aes(x=wt, y=mpg, col=as.factor(cyl)))+geom_point()
> ggplot(mtcars, aes(x=wt, y=mpg, col=as.factor(cyl)))+geom_point()
> library(gcookbook)

Attaching package: ‘gcookbook’

The following object is masked from ‘package:ggmap’:

    wind

> p <- ggplot(uspopage, aes(x=Year, y=Thousands))+geom_area()
> p
> str(uspopage)
'data.frame':	824 obs. of  3 variables:
 $ Year     : int  1900 1900 1900 1900 1900 1900 1900 1900 1901 1901 ...
 $ AgeGroup : Factor w/ 8 levels "<5","5-14","15-24",..: 1 2 3 4 5 6 7 8 1 2 ...
 $ Thousands: int  9181 16966 14951 12161 9273 6437 4026 3099 9336 17158 ...
> summary(uspopage$Year)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   1900    1925    1951    1951    1977    2002 
> range(uspopage$Year)
[1] 1900 2002
> table(uspopage$Year)

1900 1901 1902 1903 1904 1905 1906 1907 1908 1909 1910 1911 1912 1913 1914 1915 
   8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8 
1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928 1929 1930 1931 
   8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8 
1932 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942 1943 1944 1945 1946 1947 
   8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8 
1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 
   8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8 
1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 
   8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8 
1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 
   8    8    8    8    8    8    8    8    8    8    8    8    8    8    8    8 
1996 1997 1998 1999 2000 2001 2002 
   8    8    8    8    8    8    8 
> uspopage %>% group_by(Year, Thousands) %>% summarize(N=n())
Source: local data frame [824 x 3]
Groups: Year

   Year Thousands N
1  1900      3099 1
2  1900      4026 1
3  1900      6437 1
4  1900      9181 1
5  1900      9273 1
6  1900     12161 1
7  1900     14951 1
8  1900     16966 1
9  1901      3174 1
10 1901      4122 1
..  ...       ... .
> head(tapply(Thousands, Year, sum))
Error in tapply(Thousands, Year, sum) : object 'Year' not found
> head(tapply(uspopage$Thousands, uspopage$Year, sum))
 1900  1901  1902  1903  1904  1905 
76094 77584 79163 80632 82166 83822 
> ?geom_area
> uspopage %>% group_by(Year, Thousands) 
Source: local data frame [824 x 3]
Groups: Year, Thousands

   Year AgeGroup Thousands
1  1900       <5      9181
2  1900     5-14     16966
3  1900    15-24     14951
4  1900    25-34     12161
5  1900    35-44      9273
6  1900    45-54      6437
7  1900    55-64      4026
8  1900      >64      3099
9  1901       <5      9336
10 1901     5-14     17158
..  ...      ...       ...
> uspopage %>% group_by(Year, Thousands) %>% 
+ ggplot(aes(x=Year, y=Thousands))+geom_boxplot()
> ggplot(aes(x=factor(Year), y=Thousands))+geom_boxplot()
Error: ggplot2 doesn't know how to deal with data of class uneval
> uspopage %>% group_by(Year, Thousands) %>% 
+ ggplot(aes(x=factor(Year), y=Thousands))+geom_boxplot()
> ggplot(aes(x=factor(Year), y=Thousands))+geom_histogram()
Error: ggplot2 doesn't know how to deal with data of class uneval
> uspopage %>% group_by(Year, Thousands) %>% 
+ ggplot(aes(x=factor(Year), y=Thousands))+geom_histogram()
Error : Mapping a variable to y and also using stat="bin".
  With stat="bin", it will attempt to set the y value to the count of cases in each group.
  This can result in unexpected behavior and will not be allowed in a future version of ggplot2.
  If you want y to represent counts of cases, use stat="bin" and don't map a variable to y.
  If you want y to represent values in the data, use stat="identity".
  See ?geom_bar for examples. (Defunct; last used in version 0.9.2)
> uspopage %>% group_by(Year, Thousands) %>% 
+ ggplot(aes(x=factor(Year), y=Thousands))+geom_histogram(stat='identity')
> uspopage %>% group_by(Year, Thousands) %>% 
+ ggplot(aes(x=factor(Year), y=Thousands, col=Age))+geom_histogram(stat='identity')
Error in eval(expr, envir, enclos) : object 'Age' not found
> uspopage %>% group_by(Year, Thousands) %>% 
+ ggplot(aes(x=factor(Year), y=Thousands, col=AgeGroup))+geom_histogram(stat='identity')
> 

ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup))+geom_area()


ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup))+geom_area() + scale_fill_brewer()


> str(mpg)
'data.frame':	234 obs. of  11 variables:
 $ manufacturer: Factor w/ 15 levels "audi","chevrolet",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ model       : Factor w/ 38 levels "4runner 4wd",..: 2 2 2 2 2 2 2 3 3 3 ...
 $ displ       : num  1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
 $ year        : int  1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
 $ cyl         : int  4 4 4 4 6 6 6 4 4 4 ...
 $ trans       : Factor w/ 10 levels "auto(av)","auto(l3)",..: 4 9 10 1 4 9 1 9 4 10 ...
 $ drv         : Factor w/ 3 levels "4","f","r": 2 2 2 2 2 2 2 1 1 1 ...
 $ cty         : int  18 21 20 21 16 18 18 18 16 20 ...
 $ hwy         : int  29 29 31 30 26 26 27 26 25 28 ...
 $ fl          : Factor w/ 5 levels "c","d","e","p",..: 4 4 4 4 4 4 4 4 4 4 ...
 $ class       : Factor w/ 7 levels "2seater","compact",..: 2 2 2 2 2 2 2 2 2 2 ...
> mosaic(~factor(cyl)+drv+fl, data=mpg)
> mosaic(~factor(cyl)+drv, data=mpg)
> 



world_map <- map_data('world')

india_map <- filter(world_map, region=='India')

ggplot(india_map, aes(x=long, y=lat, group=group)) +
    geom_polygon(fill="white", colour="black")
	
ggplot(india_map, aes(x=long, y=lat, group=group)) +
    geom_path() + coord_map("mercator")
	
	