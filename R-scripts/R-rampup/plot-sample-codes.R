plot(iris$Petal.Length, iris$Petal.Width, pch=as.integer(iris$Species))

Your dataset contains (at least) two numeric variables and a factor. You want to create
several scatter plots for the numeric variables, with one scatter plot for each level of the
factor.
Solution
This kind of plot is called a conditioning plot, which is produced by the coplot function:
> coplot(y ~ x | f)

> coplot(Horsepower ~ MPG.city | Origin, data=Cars93)

> tapply(Cars93$MPG.city, Cars93$Origin, mean)
     USA  non-USA 
20.95833 23.86667 
> 


For example, the airquality dataset contains a numeric Temp column and a Month column. We can create
a bar chart of the mean temperature by month in two steps. First, we compute the means:
> heights <- tapply(airquality$Temp, airquality$Month, mean)
That gives the heights of the bars, from which we create the bar chart:
> barplot(heights)
The result is shown in the lefthand panel of Figure 10-9. The result is pretty bland, as
you can see, so it’s common to add some simple adornments: a title, labels for the bars,
and a label for the y-axis:
> barplot(heights,
+ main="Mean Temp. by Month",
+ names.arg=c("May", "Jun", "Jul", "Aug", "Sep"),
+ ylab="Temp (deg. F)")
The righthand panel of Figure 10-9 shows the improved bar chart.


Use boxplot(x), where x is a vector of numeric values
The box surrounding the median identifies the first and third quartiles; the bottom
of the box is Q1, and the top is Q3.

Problem
Your dataset contains a numeric variable and a factor (categorical variable). You want
to create several box plots of the numeric variable broken out by factor levels.
10.17 Creating One Box Plot for Each Factor Level | 247
Solution
Use the boxplot function with a formula:
> boxplot(x ~ f)
Here, x is the numeric variable and f is the factor.


boxplot(Cars93$MPG.city~ Cars93$Origin)

samething using plot command: 

> plot(Cars93$Origin, Cars93$MPG.city)

> boxplot(iris$Petal.Length~iris$Species)

> coplot(Petal.Length~Petal.Width | Species, data=iris)
> tapply(iris$Petal.Width, iris$Species, mean)
    setosa versicolor  virginica 
     0.246      1.326      2.026 
> 

> split(iris$Petal.Width, iris$Species)
$setosa
 [1] 0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 0.2 0.2 0.1 0.1 0.2 0.4 0.4 0.3
[19] 0.3 0.3 0.2 0.4 0.2 0.5 0.2 0.2 0.4 0.2 0.2 0.2 0.2 0.4 0.1 0.2 0.2 0.2
[37] 0.2 0.1 0.2 0.2 0.3 0.3 0.2 0.6 0.4 0.3 0.2 0.2 0.2 0.2

$versicolor
 [1] 1.4 1.5 1.5 1.3 1.5 1.3 1.6 1.0 1.3 1.4 1.0 1.5 1.0 1.4 1.3 1.4 1.5 1.0
[19] 1.5 1.1 1.8 1.3 1.5 1.2 1.3 1.4 1.4 1.7 1.5 1.0 1.1 1.0 1.2 1.6 1.5 1.6
[37] 1.5 1.3 1.3 1.3 1.2 1.4 1.2 1.0 1.3 1.2 1.3 1.3 1.1 1.3

$virginica
 [1] 2.5 1.9 2.1 1.8 2.2 2.1 1.7 1.8 1.8 2.5 2.0 1.9 2.1 2.0 2.4 2.3 1.8 2.2
[19] 2.3 1.5 2.3 2.0 2.0 1.8 2.1 1.8 1.8 1.8 2.1 1.6 1.9 2.0 2.2 1.5 1.4 2.3
[37] 2.4 1.8 1.8 2.1 2.4 2.3 1.9 2.3 2.5 2.3 1.9 2.0 2.3 1.8

> 

#Incorrect one , relation ~ is misisng
> boxplot(iris$Sepal.Width, iris$Species)

#correct one with boxplot(numeric~factor)
> boxplot(iris$Sepal.Width~iris$Species)

> data(UScereal, package='MASS')
> str(UScereal)
'data.frame':	65 obs. of  11 variables:
 $ mfr      : Factor w/ 6 levels "G","K","N","P",..: 3 2 2 1 2 1 6 4 5 1 ...
 $ calories : num  212 212 100 147 110 ...
 $ protein  : num  12.12 12.12 8 2.67 2 ...
 $ fat      : num  3.03 3.03 0 2.67 0 ...
 $ sodium   : num  394 788 280 240 125 ...
 $ fibre    : num  30.3 27.3 28 2 1 ...
 $ carbo    : num  15.2 21.2 16 14 11 ...
 $ sugars   : num  18.2 15.2 0 13.3 14 ...
 $ shelf    : int  3 3 3 1 2 3 1 3 2 1 ...
 $ potassium: num  848.5 969.7 660 93.3 30 ...
 $ vitamins : Factor w/ 3 levels "100%","enriched",..: 2 2 2 2 2 2 2 2 2 2 ...
> boxplot(sugars~shelf, data=UScereal)


> boxplot(sugars~shelf, data=UScereal, xlab='Shelf', ylab="Sugar(grams per portion)", main='Sugar content by shelf')



> hist(Cars93$MPG.city,20)


> coplot(sugars~calories|as.factor(shelf), data=UScereal)


# adding density plot over histogram plot
> hist(Cars93$MPG.city,20, probability = T)
> lines(density(Cars93$MPG.city))


# discrete histogram, one for each type of data
plot(table(Cars93$MPG.city), type='h')

#qqplot
> qqnorm(Cars93$Price, main="Q-Q Plot: Price")
> qqline(Cars93$Price)


# curve
curve(sin, -3, +3)

