#ggplot sample example codes
> qplot(mtcars$mpg, mtcars$wt)
> plot(mtcars$mpg, mtcars$wt)
>


qplot(mtcars$mpg, mtcars$wt, col=mtcars$cyl)

> coplot(mtcars$mpg~mtcars$wt|as.factor(mtcars$cyl))
> tapply(mtcars$wt, mtcars$cyl, mean)
       4        6        8 
2.285727 3.117143 3.999214 
>

boxplot(mtcars$wt~mtcars$cyl)

> boxplot(mtcars$wt~mtcars$cyl, xlab='Cylinder count', ylab='Weight', main='Cylinder to Weight Relation plot')
> tapply(mtcars$wt, mtcars$cyl, mean)
       4        6        8 
2.285727 3.117143 3.999214 
> tapply(mtcars$wt, mtcars$cyl, median)
    4     6     8 
2.200 3.215 3.755 
> tapply(mtcars$wt, mtcars$cyl, length)
 4  6  8 
11  7 14 
>



ggplot(mtcars, aes(x=wt, y=mpg))+geom_point() +geom_line()

> barplot(table(mtcars$cyl))
> qplot(mtcars$cyl)
stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
> table(mtcars$cyl)

 4  6  8 
11  7 14 
> qplot(as.factor(mtcars$cyl))
> 

ggplot(mtcars, aes(x=as.factor(cyl)))+geom_bar()

boxplot(mtcars$wt~mtcars$cyl, xlab='Cylinder count', ylab='Weight', main='Cylinder to Weight Relation plot')
# OR using ggplot
ggplot(mtcars, aes(x=as.factor(cyl), y=wt)) + geom_boxplot()


boxplot(birthwt$bwt~birthwt$smoke, xlab='0:No smoke, 1:Smoke', ylab='BirthWeight')

> boxplot(birthwt$bwt~birthwt$smoke, xlab='0:No smoke, 1:Smoke', ylab='BirthWeight')
> coplot(birthwt$bwt ~birthwt$age | factor(birthwt$smoke))
> coplot(birthwt$age ~birthwt$bwt | factor(birthwt$smoke))
> tapply(birthwt$bwt, birthwt$smoke, mean)
       0        1 
3055.696 2771.919 
> tapply(birthwt$bwt, birthwt$smoke, median)
     0      1 
3100.0 2775.5 
>

ggplot(birthwt, aes(x=bwt)) + geom_histogram(fill='white', color='blue') + facet_grid(smoke ~.)


# using tapply
tapply(birthwt$bwt, birthwt$smoke, hist)

# scale ='free', so that each category can chose its y scale range
ggplot(birthwt, aes(x=bwt)) + geom_histogram(fill='white', color='blue') + facet_grid(race ~., scales = 'free')


#identity bar plot
The position="identity" is important. Without it, ggplot() will stack the histogram
bars on top of each other vertically, making it much more difficult to see the distribution
of each group.
ggplot(birthwt, aes(x=bwt, fill=factor(smoke))) +geom_histogram(position = 'identity', alpha=0.4)


