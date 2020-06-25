library(quantmod);library(forecast)

# Getting the data
from.dat <- as.Date("01/01/08", format="%m/%d/%y")
to.dat <- as.Date("12/13/13", format="%m/%d/%y")
getSymbols("GOOG", src="yahoo", from=from.dat, to=to.dat)
mGoog <- to.monthly(GOOG)
googOpen <- Op(mGoog)
# Converting to a time series object
ts1 <- ts(googOpen, frequency=12)
# Plots
p1 <- plot(ts1, xlab="Years+1", ylab="GOOG")
p2 <- plot(decompose(ts1), xlab="years+1")

# Splitting the data
ts1Train <- window(ts1, start=1, end=5)
ts1Test <- window(ts1, start=5, end=(7-0.01))

# Simple moving average
plot(ts1Train)
lines(ma(ts1Train, order=3),col="red")

# Exponential smoothing
ets1 <- ets(ts1Train, model="MMM")
fcast <- forecast(ets1)
plot(fcast); lines(ts1Test, col="red")

# Forecasting accuracy
accuracy(fcast, ts1Test)











