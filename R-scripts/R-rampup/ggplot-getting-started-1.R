> ls()
[1] "mpg"    "mtcars"
> rm(list=ls())
> ls()
character(0)
> data(mtcars)
> attach(mtcars)
The following object is masked from package:ggplot2:

    mpg

> plot(mpg, wt)
> qplot(mpg, wt)
> qplot(mpg, wt, col=cyl)
> qplot(mpg, wt, col=cyl, pch=19)
Error: A continuous variable can not be mapped to shape
> qplot(mpg, wt, col=cyl, data=mtcars)
> plot(mpg, wt, col=cyl, data=mtcars)
Warning messages:
1: In plot.window(...) : "data" is not a graphical parameter
2: In plot.xy(xy, type, ...) : "data" is not a graphical parameter
3: In axis(side = side, at = at, labels = labels, ...) :
  "data" is not a graphical parameter
4: In axis(side = side, at = at, labels = labels, ...) :
  "data" is not a graphical parameter
5: In box(...) : "data" is not a graphical parameter
6: In title(...) : "data" is not a graphical parameter
> plot(mpg, wt, col=cyl, data=mtcars, pch=20)
There were 18 warnings (use warnings() to see them)
> plot(mpg, wt, col=cyl, data=mtcars, pch=19)
There were 18 warnings (use warnings() to see them)
> qplot(mpg, wt, data=mtcars, size=cyl)
There were 12 warnings (use warnings() to see them)
> qplot(mpg, wt, data=mtcars)
> qplot(mpg, wt, data=mtcars, size=cyl)
> qplot(mpg, wt, data=mtcars, facets = vs~am)
> qplot(hp, wt)
> qplot(hp, wt, col=cyl)
> qplot(hp, wt, size=cyl)
> model <- lm(mpg~wt, data = mtcars)
> model

Call:
lm(formula = mpg ~ wt, data = mtcars)

Coefficients:
(Intercept)           wt  
     37.285       -5.344  

> plot(model)
Hit <Return> to see next plot: 
Hit <Return> to see next plot: 
Hit <Return> to see next plot: 
Hit <Return> to see next plot: 
> 
> resid(model)
          Mazda RX4       Mazda RX4 Wag          Datsun 710 
         -2.2826106          -0.9197704          -2.0859521 
     Hornet 4 Drive   Hornet Sportabout             Valiant 
          1.2973499          -0.2001440          -0.6932545 
         Duster 360           Merc 240D            Merc 230 
         -3.9053627           4.1637381           2.3499593 
           Merc 280           Merc 280C          Merc 450SE 
          0.2998560          -1.1001440           0.8668731 
         Merc 450SL         Merc 450SLC  Cadillac Fleetwood 
         -0.0502472          -1.8830236           1.1733496 
Lincoln Continental   Chrysler Imperial            Fiat 128 
          2.1032876           5.9810744           6.8727113 
        Honda Civic      Toyota Corolla       Toyota Corona 
          1.7461954           6.4219792          -2.6110037 
   Dodge Challenger         AMC Javelin          Camaro Z28 
         -2.9725862          -3.7268663          -3.4623553 
   Pontiac Firebird           Fiat X1-9       Porsche 914-2 
          2.4643670           0.3564263           0.1520430 
       Lotus Europa      Ford Pantera L        Ferrari Dino 
          1.2010593          -4.5431513          -2.7809399 
      Maserati Bora          Volvo 142E 
         -3.2053627          -1.0274952 
> qplot(resid(model), fitted(model))
> fittedm(model)
Error: could not find function "fittedm"
> fitted(model)
          Mazda RX4       Mazda RX4 Wag          Datsun 710 
          23.282611           21.919770           24.885952 
     Hornet 4 Drive   Hornet Sportabout             Valiant 
          20.102650           18.900144           18.793255 
         Duster 360           Merc 240D            Merc 230 
          18.205363           20.236262           20.450041 
           Merc 280           Merc 280C          Merc 450SE 
          18.900144           18.900144           15.533127 
         Merc 450SL         Merc 450SLC  Cadillac Fleetwood 
          17.350247           17.083024            9.226650 
Lincoln Continental   Chrysler Imperial            Fiat 128 
           8.296712            8.718926           25.527289 
        Honda Civic      Toyota Corolla       Toyota Corona 
          28.653805           27.478021           24.111004 
   Dodge Challenger         AMC Javelin          Camaro Z28 
          18.472586           18.926866           16.762355 
   Pontiac Firebird           Fiat X1-9       Porsche 914-2 
          16.735633           26.943574           25.847957 
       Lotus Europa      Ford Pantera L        Ferrari Dino 
          29.198941           20.343151           22.480940 
      Maserati Bora          Volvo 142E 
          18.205363           22.427495 
> qplot(mpg, wt, data=mtcars)
> qplot(mpg, wt, data=mtcars)
> qplot(mpg, data=mtcars)
stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
> qplot(y=mpg, data=mtcars)
> qplot(factor(cyl), wt, data=mtcars, geom=c("boxplot","jitter"))
> qplot(cyl, wt, data=mtcars, geom=c("boxplot","jitter"))
> qplot(factor(cyl), wt, data=mtcars, geom=c("boxplot","jitter"))
> qplot(factor(cyl), wt, data=mtcars, geom=c("boxplot"))
> qplot(factor(cyl), wt, data=mtcars, geom=c("boxplot","jitter"))
> df <- data.frame(gp = factor(rep(letters[1:3], each = 10)),
+                  y = rnorm(30))
> df
   gp           y
1   a  0.48435090
2   a -0.36519237
3   a  0.33989023
4   a  0.76154065
5   a  0.10378778
6   a  0.69175870
7   a -0.02677219
8   a  1.47896043
9   a -0.44096702
10  a  0.92451219
11  b -0.16369439
12  b  1.17698295
13  b -0.01973277
14  b -0.55065464
15  b  0.71515175
16  b -1.29079581
17  b  0.30830449
18  b  1.59111570
19  b  0.52948940
20  b  0.22862826
21  c  1.34697193
22  c -0.66494387
23  c -0.93547736
24  c -0.07951679
25  c -0.57783859
26  c  0.56967001
27  c -0.02773660
28  c  0.45440146
29  c -0.31966186
30  c  0.37785670
> plot(y, gp, data = df)
Error in plot(y, gp, data = df) : object 'y' not found
> plot(df$y, df$gp, data = df)
Warning messages:
1: In plot.window(...) : "data" is not a graphical parameter
2: In plot.xy(xy, type, ...) : "data" is not a graphical parameter
3: In axis(side = side, at = at, labels = labels, ...) :
  "data" is not a graphical parameter
4: In axis(side = side, at = at, labels = labels, ...) :
  "data" is not a graphical parameter
5: In box(...) : "data" is not a graphical parameter
6: In title(...) : "data" is not a graphical parameter
> qplot(df$y, df$gp, data = df)
There were 12 warnings (use warnings() to see them)
> qplot(df$y, df$gp, data = df, col=df$gp)
> qplot(df$gp, df$y, data = df, col=df$gp)
> install.packages("randomForest")
Installing package into ‘C:/Users/aansari/Documents/R/win-library/3.2’
(as ‘lib’ is unspecified)
trying URL 'http://cran.rstudio.com/bin/windows/contrib/3.2/randomForest_4.6-10.zip'
Content type 'application/zip' length 176369 bytes (172 KB)
downloaded 172 KB

package ‘randomForest’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\aansari\AppData\Local\Temp\Rtmpc1vX3x\downloaded_packages
> install.packages("glmnet")
Installing package into ‘C:/Users/aansari/Documents/R/win-library/3.2’
(as ‘lib’ is unspecified)
trying URL 'http://cran.rstudio.com/bin/windows/contrib/3.2/glmnet_2.0-2.zip'
Content type 'application/zip' length 1980928 bytes (1.9 MB)
downloaded 1.9 MB

package ‘glmnet’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\aansari\AppData\Local\Temp\Rtmpc1vX3x\downloaded_packages
> install.packages("gbm")
Installing package into ‘C:/Users/aansari/Documents/R/win-library/3.2’
(as ‘lib’ is unspecified)
trying URL 'http://cran.rstudio.com/bin/windows/contrib/3.2/gbm_2.1.1.zip'
Content type 'application/zip' length 839621 bytes (819 KB)
downloaded 819 KB

package ‘gbm’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\aansari\AppData\Local\Temp\Rtmpc1vX3x\downloaded_packages
> data(diamonds)
> str(diamonds)
'data.frame':	53940 obs. of  10 variables:
 $ carat  : num  0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
 $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
 $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
 $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
 $ depth  : num  61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
 $ table  : num  55 61 65 58 58 57 57 55 61 61 ...
 $ price  : int  326 326 327 334 335 336 336 337 337 338 ...
 $ x      : num  3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
 $ y      : num  3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
 $ z      : num  2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...
> table(diamonds$cut)

     Fair      Good Very Good   Premium     Ideal 
     1610      4906     12082     13791     21551 
> barplot(table(diamonds$cut))
> ggplot(diamonds, aes(cut))+geom_histogram()
> ggplot(diamonds, aes(color))+geom_histogram()
> ggplot(diamonds, aes(clarity))+geom_histogram()
> prop.table(table(diamonds$clarity))

        I1        SI2        SI1        VS2        VS1       VVS2       VVS1 
0.01373749 0.17044865 0.24221357 0.22725250 0.15148313 0.09391917 0.06776047 
        IF 
0.03318502 
> ggplot(diamonds, aes(clarity))+geom_bar()
> ggplot(diamonds, aes(clarity))+geom_area()
Error in exists(name, envir = env, mode = mode) : 
  argument "env" is missing, with no default
> ggplot(diamonds, aes(clarity))+geom_boxplot()
Error: stat_boxplot requires the following missing aesthetics: y
> ggplot(diamonds, aes(clarity), col=clarity)+geom_bar()
> ggplot(diamonds, aes(clarity), col=cut)+geom_bar()
> ggplot(diamonds, aes(x=clarity))+geom_bar()
> ggplot(diamonds, aes(x=clarity, fill=cut))+geom_bar()
> barplot(table(diamonds$clarity))
> barplot(table(diamonds$clarity), fill=cut)
Warning messages:
1: In plot.window(xlim, ylim, log = log, ...) :
  "fill" is not a graphical parameter
2: In axis(if (horiz) 2 else 1, at = at.l, labels = names.arg, lty = axis.lty,  :
  "fill" is not a graphical parameter
3: In title(main = main, sub = sub, xlab = xlab, ylab = ylab, ...) :
  "fill" is not a graphical parameter
4: In axis(if (horiz) 1 else 2, cex.axis = cex.axis, ...) :
  "fill" is not a graphical parameter
> barplot(table(diamonds$clarity))
Warning messages:
1: "fill" is not a graphical parameter 
2: "fill" is not a graphical parameter 
3: "fill" is not a graphical parameter 
4: "fill" is not a graphical parameter 
5: "fill" is not a graphical parameter 
6: "fill" is not a graphical parameter 
7: "fill" is not a graphical parameter 
8: "fill" is not a graphical parameter 
> barplot(table(diamonds$clarity))
> par(mfrow=c(1,2))
> barplot(table(diamonds$clarity))
> ggplot(diamonds, aes(x=clarity, fill=cut))+geom_bar()
> require(dplyr)
Loading required package: dplyr

Attaching package: ‘dplyr’

The following object is masked from ‘package:stats’:

    filter

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

> selec(diamonds, clarity,cut)
Error: could not find function "selec"
> selec(diamonds, clarity,cut) %>%
+ group_by(clarity) %>%
+ summarize(n())
Error in eval(expr, envir, enclos) : could not find function "selec"
> select(diamonds, clarity,cut) %>%
+ group_by(clarity) %>%
+ summarize(n())
Source: local data frame [8 x 2]

  clarity   n()
1      I1   741
2     SI2  9194
3     SI1 13065
4     VS2 12258
5     VS1  8171
6    VVS2  5066
7    VVS1  3655
8      IF  1790
> select(diamonds, clarity,cut) %>%
+ group_by(clarity, cut) %>%
+ summarize(n())
Source: local data frame [40 x 3]
Groups: clarity

   clarity       cut  n()
1       I1      Fair  210
2       I1      Good   96
3       I1 Very Good   84
4       I1   Premium  205
5       I1     Ideal  146
6      SI2      Fair  466
7      SI2      Good 1081
8      SI2 Very Good 2100
9      SI2   Premium 2949
10     SI2     Ideal 2598
..     ...       ...  ...
> ggplot(diamonds, aes(x=clarity, fill=cut))+geom_bar()
> ggplot(diamonds, aes(x=clarity, fill=color))+geom_bar()





=======
> boxplot(diamonds$price ~ diamonds$clarity, data = diamonds)
> boxplot(diamonds$price ~ diamonds$clarity, data = diamonds, xlab='clarity', ylab='Price')

> median(diamonds$price[diamonds$clarity=='VS2'])
[1] 2054
> median(diamonds$price[diamonds$clarity=='VVS2'])
[1] 1311
> median(diamonds$price[diamonds$clarity=='l1'])
[1] NA
> median(diamonds$price[diamonds$clarity=='Sl1'])
[1] NA
> median(diamonds$price[diamonds$clarity=='I1'])
[1] 3344
> median(diamonds$price[diamonds$clarity=='SI2'])
[1] 4072
> median(diamonds$price[diamonds$clarity=='SI1'])
[1] 2822
> median(diamonds$price[diamonds$clarity=='VS2'])
[1] 2054
> median(diamonds$price[diamonds$clarity=='VS1'])
[1] 2005
> median(diamonds$price[diamonds$clarity=='VVS2'])
[1] 1311
> median(diamonds$price[diamonds$clarity=='VVS1'])
[1] 1093
> median(diamonds$price[diamonds$clarity=='IF'])
[1] 1080
>


> boxplot(diamonds$price ~ diamonds$clarity, data = diamonds, xlab='clarity', ylab='Price', col = 'green')



require(lattice)
bwplot(diamonds$price ~ diamonds$clarity, data = diamonds, col='red')



> boxplot(mtcars$mpg ~ mtcars$cyl)


> IQR(mtcars$mpg)
[1] 7.375
> summary(mtcars$mpg)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  10.40   15.42   19.20   20.09   22.80   33.90 
> boxplot(mtcars$mpg)






====galton data set

> data(galton)
> str(galton)
'data.frame':	928 obs. of  2 variables:
 $ child : num  61.7 61.7 61.7 61.7 61.7 62.2 62.2 62.2 62.2 62.2 ...
 $ parent: num  70.5 68.5 65.5 64.5 64 67.5 67.5 67.5 66.5 66.5 ...
> plot(galton$parent~ galton$child, data= galton)
> plot(galton$child ~ galton$parent, data= galton)
> boxplot(galton$child)
> boxplot(galton$parent)
> plot(galton$child ~ galton$parent, data= galton, pch=19)
> plot(galton$child ~ galton$parent, data= galton, pch=19, col='blue')
> lm1 <- lm(galton$child ~ galton$parent, data=galton)
> lines(galton$parent, lm1$fitted.values, col='red')
> summary(lm1)

Call:
lm(formula = galton$child ~ galton$parent, data = galton)

Residuals:
    Min      1Q  Median      3Q     Max 
-7.8050 -1.3661  0.0487  1.6339  5.9264 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)   23.94153    2.81088   8.517   <2e-16 ***
galton$parent  0.64629    0.04114  15.711   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.239 on 926 degrees of freedom
Multiple R-squared:  0.2105,	Adjusted R-squared:  0.2096 
F-statistic: 246.8 on 1 and 926 DF,  p-value: < 2.2e-16


> qqplot(galton$parent, lm1$fitted.values)
> ?galton
> plot(galton)
> plot(jitter(child,5) ~ jitter(parent, 5), galton)
> sunflowerplot(galton)
> ?sunflowerplot
> qqplot(galton$parent, lm1$fitted.values)
> summary(galton$parent)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  64.00   67.50   68.50   68.31   69.50   73.00 
> summary(lm1$fitted.values)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  65.30   67.57   68.21   68.09   68.86   71.12 
> summary(galton$child)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  61.70   66.20   68.20   68.09   70.20   73.70 
> lm1

Call:
lm(formula = galton$child ~ galton$parent, data = galton)

Coefficients:
  (Intercept)  galton$parent  
      23.9415         0.6463  

> var(galton$child)
[1] 6.340029
> var(lm1$fitted.values)
[1] 1.334341
> var(galton$parent)
[1] 3.194561
> cor(galton$parent, lm1$fitted.values)
[1] 1



> mean((lm1$fitted.values - galton$child)^2)
[1] 5.000294
> mean(lm1$residuals^2)
[1] 5.000294
> mean((lm1$fitted.values - galton$parent)^2)
[1] 0.4475187
>


> lm1

Call:
lm(formula = galton$child ~ galton$parent, data = galton)

Coefficients:
  (Intercept)  galton$parent  
      23.9415         0.6463  

>



> plot(galton$child, lm1$fitted.values, pch=19)
> qqplot(galton$parent, lm1$fitted.values)
> cor(galton$parent, lm1$fitted.values)
[1] 1
> cor(galton$child, lm1$fitted.values)
[1] 0.4587624
> newgalton <- data.frame(parent=rep(NA, 1e6), child=rep(NA,1e6))
> head(newgalton)
  parent child
1     NA    NA
2     NA    NA
3     NA    NA
4     NA    NA
5     NA    NA
6     NA    NA
> dim(newgalton)
[1] 1000000       2
> newgalton$parent <- rnorm(1e6, mean(galton$parent), sd=sd(galton$parent))
> head(newgalton)
    parent child
1 69.43871    NA
2 69.21246    NA
3 68.23126    NA
4 70.31926    NA
5 70.59632    NA
6 66.84062    NA
> newgalton$child <- lm1$coefficients[1]+lm1$coefficients[2]*newgalton$parent + rnorm(1e6, sd=sd(lm1$residuals))
> head(newgalton)
    parent    child
1 69.43871 68.87439
2 69.21246 71.23948
3 68.23126 67.64579
4 70.31926 64.50269
5 70.59632 69.08995
6 66.84062 68.01110
> head(galton)
  child parent
1  61.7   70.5
2  61.7   68.5
3  61.7   65.5
4  61.7   64.5
5  61.7   64.0
6  62.2   67.5
> summary(galton)
     child           parent     
 Min.   :61.70   Min.   :64.00  
 1st Qu.:66.20   1st Qu.:67.50  
 Median :68.20   Median :68.50  
 Mean   :68.09   Mean   :68.31  
 3rd Qu.:70.20   3rd Qu.:69.50  
 Max.   :73.70   Max.   :73.00  
> summary(newgalton)
     parent          child      
 Min.   :58.97   Min.   :56.13  
 1st Qu.:67.10   1st Qu.:66.39  
 Median :68.31   Median :68.09  
 Mean   :68.31   Mean   :68.09  
 3rd Qu.:69.52   3rd Qu.:69.79  
 Max.   :76.96   Max.   :80.65  
> smoothScatter(newgalton$parent, newgalton$child)
> abline(lm1, col='red', lwd=3)


