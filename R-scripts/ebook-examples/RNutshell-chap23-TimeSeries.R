#R in nutshell - chap 23 - Time Series

require(nutshell)
data(turkey.price.ts)

tk <- turkey.price.ts

#Autocorrelation function
acf(tk, plot = F)

pacf(tk, plot=F)

data(ham.price.ts)
ccf(turkey.price.ts, ham.price.ts, plot=F)
