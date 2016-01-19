#ESR-chap7-Moving beyond linearity

require(ISLR)
data(Wage)

#Polynomial reg
fit <- lm(wage ~ poly(age, 4), data=Wage)
summary(fit)

# fitted-function with standard-errors
# whats the range of ages
agelims <- range(Wage$age)

#use that age range to make prediction one for each age value
# from 18 to 80 i.e. agelimis, min to max
age.grid <- seq(from=agelims[1], to=agelims[2])

preds <- predict(fit, newdata=list(age=age.grid), se=T)

#standard error bands, fit +/- 2*Se
se.bands <- cbind(preds$fit+2*preds$se, preds$fit-2*preds$se)
with(Wage, plot(age, wage, col="darkgrey"))

#for each age vs corresponding predicted value using the model
lines(age.grid, preds$fit, lwd=2, col="blue")

#using matlines() to plot multiple columns of matrix se.bands 
# at a time
matlines(age.grid, se.bands, col="red", lty=2)


#without using poly() function
fita <- lm(wage ~age+I(age^2)+I(age^3)+I(age^4), data=Wage)
summary(fita)

#plot fitted values from both this model and old model
plot(fitted(fit), fitted(fita))


#Anova
fita <- lm(wage~education, data=Wage)
fitb <- lm(wage~education+age, data=Wage)
fitc <- lm(wage~education+poly(age,2), data=Wage)
fitd <- lm(wage~education+poly(age, 3), data=Wage)
anova(fita, fitb, fitc, fitd)


#Polynomial Logistic Regression 

fit <- glm(I(wage>250)~ poly(age, 3), data=Wage, 
            family=binomial)
summary(fit)

preds <- predict(fit, list(age=age.grid), se=T)

# standard error band is on Logit scale
# tricky : (fit, fit-2*se, fit+2*se)
se.bands <- preds$fit + cbind(fit=0, lower=-2*preds$se.fit, 
                              upper=2*preds$se.fit)

se.bands[1:5, ]

# transfrom from logit scale to probability scale using this: 
prob.bands <- exp(se.bands)/(1+exp(se.bands))
#lwd, 2 -> actual fit line, 
# 1 -> lower se band
# 1 -> upper se band
#similarly for lty, 1 -> fit, 2,2 -> uppper,lower se bands
matplot(age.grid, prob.bands, col=c("blue","red","red"), lwd=c(2,1,1), 
        lty=c(1,2,2), type="l", ylim=c(0,.1))

#plot the poitns , add jitter to age, as there are 3k points 
# between 18-80, so there is huge overlap
with(Wage, points(jitter(age), I(wage>250)/10, pch="|", cex=.6))

#try this to see why we need to limit y to .1 or so, to get 
# a better view of plot
with(Wage, points(jitter(age), I(wage>250)/4, pch="|", cex=.8))



#Lab 2 - Splines

require(splines)

fit <- lm(wage~bs(age, knots=c(25,40,60)), data=Wage)
summary(fit)

with(Wage, plot(age, wage, col="darkgrey"))

lines(age.grid, predict(fit, list(age=age.grid)), 
      col="darkgreen", lwd=2)
#3 vertical lines for 3 knots at 25, 40 and 60 

#see the knots at these points. these have non-zero
# 1st order and 2nd order derivates. and 3rd order 
# derivative is zero
abline(v=c(25,40,60), lty=2, col="darkgreen")


#Smooth splines, splines everywhere
attach(Wage)
fit <- smooth.spline(age, wage, df=16)
lines(fit, col="red", lwd=2)

summary(fit)

#use LOOCV to determine df of smooth.spline, which internally
# decides the roughness penalty

fit <- smooth.spline(age, wage, cv=T)
lines(fit, col="purple", lwd=2)
summary(fit)
fit


#GAModels
require(gam)
gam1 = gam(wage~s(age, df=4)+s(year, df=4)+education, 
            data=Wage)
gam1

summary(gam1)

#for plotting gam1
par(mfrow=c(1,3))
plot(gam1,se=T)

gam2 <- gam(I(wage>250)~s(age,df=4)+s(year,df=4)+education, 
           data=Wage, family=binomial)
gam2
summary(gam2)
#plot not working
plot(gam2, se=T)

gam2a <- gam(I(wage>250)~s(age, df=4)+year+education, 
             data=Wage, family=binomial)

#anova indicates, non-linear term in yera is needed, linear
# is good enough
anova(gam2a, gam2, test="Chisq")

#using gam to plot modesl fit by lm and glm
lm1 <- lm(wage~ns(age, df=4)+ns(year, df=4)+education, 
          data=Wage)
par(mfrow=c(1,3))
plot.gam(lm1, se=T)
