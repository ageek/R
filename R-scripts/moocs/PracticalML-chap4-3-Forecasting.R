#DA using R - chap 4-3-Forecasting

require(quantmod)
from.dat <- as.Date("01/01/10", format="%m/%d/%y")
to.dat <- as.Date("12/31/14", format="%m/%d/%y")
getSymbols("GOOG", src="google", from=from.dat, to=to.dat)

head(GOOG)
GOOG

mgoog <- to.monthly(GOOG)
googopen <- Op(mgoog)

ts1 <- ts(googopen, frequency = 12)
plot(ts1, xlab="years+1", ylab="GOOG")

plot(decompose(ts1), xlab="years+1")

