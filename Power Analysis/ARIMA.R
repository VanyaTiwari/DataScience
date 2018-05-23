

ts_data <- EuStockMarkets[, 1]
opar <- par()
par(mfrow = c(1, 2))
decomposed_result <- decompose(ts_data, type = "mult")
plot(decomposed_result)
decomposed_result <- decompose(ts_data, type = "additive")
plot(decomposed_result)
seasonal_trend_error <- stl(ts_data, s.window = "periodic")
par <- opar
seasonal_trend_error$time.series
# -3 means moving forward and viceversa
lagged_ts <- lag(ts_data, 3)

install.packages("DataCombine")
library(DataCombine)
#create df with 1 lag and 1 lead value
my_df <- as.data.frame(ts_data)
my_df <- slide(my_df, "x", NewVar = "xLag1", slideBy = -1)#lag1 variable
my_df <- slide(my_df, "x", NewVar = "xLeaad1", slideBy = 1) #Lead1 variable

acf_res <- acf(AirPassengers)
head(my_df)
#Partial autocorrelation
pacf_res <- pacf(AirPassengers)

plot(JohnsonJohnson)
trained_model <- lm(JohnsonJohnson ~ c(1:length(JohnsonJohnson)))
plot(resid(trained_model), type = "l")

#Decompose the time series
install.packages("forecast")
library(forecast)
ts_decompose <- stl(AirPassengers, "periodic")
ts_seasonal_adjust <- seasadj(ts_decompose)
plot(AirPassengers, type = "l")
plot(ts_seasonal_adjust, type = "l")
seasonplot(ts_seasonal_adjust, 12, col = rainbow(12), year.labels = TRUE, main = "Seasonalplot")
#Testing time-series is stationary
library(tseries)
adf.test(ts_data)
kpss.test(ts_data)
nsdiffs(AirPassengers) #no.of seasonal differencing needed

AirPassengers_seasdiff <- diff(AirPassengers, lag = frequency(AirPassengers), differences = 1)
plot(AirPassengers_seasdiff, type = "l", maintainer = "Seasonal Difference")

library(forecast)
library(tseries)
plot(Nile)
ndiffs(Nile)
dnile <- diff(Nile)
plot(dnile)
ndiffs(dnile)

adf.test(dnile)
Acf(dnile)
pacf(dnile)

fit <- Arima(Nile, order = c(0, 1, 1))
fit
accuracy(fit)


qqnorm(fit$residuals)
qqline(fit$residuals)

Box.test(fit$residuals, type = "Ljung-Box")
fore_fit <- forecast(fit, 3)
plot(fore_fit)
fit <- auto.arima(Nile)
fit
accuracy(fit)