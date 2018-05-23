
data(diamonds, package = "ggplot2")
head(diamonds,4)
dim(head(diamonds, 4))
library(magrittr)
diamonds %>% head(4) %>% dim #Using pipes

x <- c(0.109,0.359,0.256,0.894,0.258,0.154,0.458,0.238,0.987,0.123)
round(exp(diff(log(x))),1)
x %>% log %>% diff %>% exp %>% round(1)

install.packages(dplyr)
library("dplyr")
head(diamonds)
diamonds
select(diamonds, carat, price)
diamonds %>% select(carat,price)

my_attributes <- c('carat', 'price')
select(diamonds,one_of(my_attributes))
diamonds %>% slice(c(1:5, 8, 15:20))
set <- select(diamonds, carat, price)
mutate(set, ratio = price / carat)
diamonds %>% select(carat, price) %>% mutate(ratio = price / carat) #using pipes
mutate(set, ratio = price / carat, double = ratio *2)
diamonds %>% select(carat, price) %>% mutate(ratio = price / carat, double = ratio * 2)

summarise(diamonds, AvgPrice = mean(price),
          medianPrice = median(price),
          avgcarat = mean(carat))
diamonds %>% group_by(cut) %>% summarise(avgprice = mean(price))
diamonds %>% group_by(cut) %>% summarise(avgprice = mean(price), sumcarat = sum(carat)) %>% arrange(avgprice)
lotto <- read.csv("C:/Big Data/Data science/Practicals/Data/Lotto.csv")

