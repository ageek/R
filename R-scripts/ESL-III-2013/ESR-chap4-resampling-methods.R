#chap5- Resampling Methods

#Lab1 - cross validation

require(ISLR)
require(boot)
?boot

?cv.glm

plot(mpg~horsepower, data=Auto)

# LOOCV
glm.fit <- glm(mpg~horsepower, data=Auto)
summary(glm.fit)

cv.glm(Auto, glm.fit)$delta

?cv.glm

#writing function for LOOCV
loocv = function(fit) {
  h = lm.influence(fit)$h
  mean((residuals(fit)/(1-h))^2)
}

loocv(glm.fit)

cv.error=rep(0,5)
cv.error
degree=1:5

for (d in degree) {
  glm.fit =glm(mpg~poly(horsepower, d), data=Auto)
  cv.error[d]=loocv(glm.fit)
}

plot(degree, cv.error, type="b")

#10-fold CV
cv.error10=rep(0,5)
for(d in degree) {
  glm.fit = glm(mpg~poly(horsepower, d), data=Auto)
  cv.error10[d] = cv.glm(Auto, glm.fit, K=10)$delta[1]
}

lines(degree, cv.error10, type="b", col="red")

# Boostrap
alpha = function(x, y) {
  vx=var(x)
  vy=var(y)
  cxy=cov(x,y)
  (vy-cxy)/(vx+vy-2*cxy)
}

alpha(Portfolio$X, Portfolio$Y)

alpha.fn=function(data, index) {
    with(data[index,], alpha(X,Y))
}

alpha.fn(Portfolio, 1:100)

set.seed(1)
alpha.fn(Portfolio, sample(1:100, 100, replace = T))

boot.out=boot(Portfolio, alpha.fn, R=1000)
boot.out
plot(boot.out)
 