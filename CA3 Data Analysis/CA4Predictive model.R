
#Finding whether the increase crime rates of men s related to the education rate in ireland.
robbery_data <- read.csv("Data/Robbery.csv")
education <- read.csv("Data/Education.csv")
#Merging the two datasets
colnames(robbery_data) <- c('Year','Male-Crime','Female-Crime')
colnames(education) <- c('Year', 'Male-Education', 'Female-Education')
crime_data <- merge(robbery_data,education)
crime_data
scatter.smooth(x =crime_data$Male , y = , main = "Dist ~ Speed") # scatterplot

boxplot(cars$speed, main = "Speed", sub = paste("Outlier rows: ", boxplot.stats(cars$speed)$out)) # box plot for 'speed'
boxplot(cars$dist, main = "Distance", sub = paste("Outlier rows: ", boxplot.stats(cars$dist)$out)) # box plot for 'distance'
#density plot for males and females in robbery
plot(density(robbery_data$Male), main = "Density Plot: Male in robbery-crime", ylab = "Frequency", sub = paste("Skewness:", round(e1071::skewness(robbery_data$Male), 2)))
polygon(density(robbery_data$Male), col = "red")
plot(density(robbery_data$Female), main = "Density Plot: Female in robbery-crime", ylab = "Frequency", sub = paste("Skewness:", round(e1071::skewness(robbery_data$Female), 2)))
polygon(density(robbery_data$Female), col = "red")
#calculte the correlation b/w male crime rate and education rate
cor(crime_data$`Male-Crime`,crime_data$`Male-Education`)
#build linear regression model
linearmod <- lm(`Male-Crime` ~ `Male-Education`, data = crime_data)
print(linearmod)
summary(linearmod)
AIC(linearmod)
BIC(linearmod)
#Splitting the data into Training and Testing Data 
no_od_records <- sample(1:nrow(crime_data), 0.8 * nrow(crime_data))
training_data <- crime_data[no_od_records,]
training_data
testing_data <- crime_data[-no_od_records,]
#Build the model on training model
lr_model <- lm(`Male-Crime` ~ `Male-Education`, data = training_data)
crime_predict <- predict(lr_model, testing_data)
crime_predict
summary(lr_model)
actual_preds <- data.frame(cbind(actuals = testing_data$`Male-Crime`, predicted = crime_predict))
head(actual_preds)
correlation_accuracy <- cor(actual_preds)
correlation_accuracy
#min-max accuracy
min_max_acc <- mean(apply(actual_preds, 1, min) / apply(actual_preds, 1, max))
min_max_acc
#mape
mape <- mean(abs((actual_preds$predicted - actual_preds$actuals)) / actual_preds$actuals)
mape