install.packages(car)
library(cars)
scatter.smooth(cars$speed, y = cars$dist, maintainer = "Dist ~ Speed")

install.packages("e1071")
library(e1071)
par(mfrow = c(1, 2)) #Divide graph in 2 columns
#density plot for speed 
plot(density(cars$speed),main = "Density Plot: Speed", ylab = "Frequency", sub =paste("Skewness:",round(e1071::skewness(cars$speed),2)))
polygon(density(cars$speed), col = "red")
plot(density(cars$dist), main = "Density Plot: Distance", ylab = "Frequency", sub = paste("Skewness:", round(e1071::skewness(cars$dist), 2)))
polygon(density(cars$dist), col = "red")
#calculte the correlation b/w speed & distance
cor(cars$speed, cars$dist)
#build linear regression model
linearmod <- lm(dist ~ speed, data = cars)
print(linearmod)
summary(linearmod)
AIC(linearmod)
BIC(linearmod)
no_od_records <- sample(1:nrow(cars), 0.8 * nrow(cars))
training_data <- cars[no_od_records,]
training_data
testing_data <- cars[-no_od_records,]
#Build the model on training model
lr_model <- lm(dist ~ speed, data = training_data)
dist_predict <- predict(lr_model, testing_data)
dist_predict
summary(lr_model)
actual_preds <- data.frame(cbind(actuals = testing_data$dist, predicted = dist_predict))
head(actual_preds)
correlation_accuracy <- cor(actual_preds)
correlation_accuracy
#min-max accuracy
min_max_acc <- mean(apply(actual_preds, 1, min) / apply(actual_preds, 1, max))
min_max_acc
#mape
mape <- mean(abs((actual_preds$predicted - actual_preds$actuals)) / actual_preds$actuals)
mape
install.packages("DAAG")
library(DAAG)
cvresults <- suppressWarnings(CVlm(data = cars, form.lm = dist ~ speed, m = 5, dots = FALSE, seed = 29, legend.pos = "topleft", printit = FALSE, main = "Small sybols are predicted values while bigger ones are actuals"));