install.packages("pwr")
library(pwr)
library(dplyr)
effect_size <- cohen.ES("t", size = "medium")
effect_size
sample_size <- pwr.t.test(d = effect_size$effect.size, sig.level = 0.05, power = 0.80)
sample_size
plot(sample_size)

robbery_data <- read.csv("Data/robbery crime by sex.csv")
str(robbery_data)
sample <- sample_n(robbery_data,64)
sample
t.test(sample$Male, sample$Female)

effect_size <- cohen.ES("t", size = "large")
effect_size
sample_size <- pwr.t.test(d = effect_size$effect.size, sig.level = 0.05, power = 0.80)
sample_size
plot(sample_size)

large_sample <- sample_n(robbery_data, 26)
large_sample

t.test(large_sample$Male, large_sample$Female)




