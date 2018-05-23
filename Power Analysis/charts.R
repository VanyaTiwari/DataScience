
data(diamonds, package = "ggplot2")
head(diamonds, 4)
dim(head(diamonds, 4))
library(magrittr)
diamonds %>% head(4) %>% dim


install.packages("hflights")
library(hflights)

dose <- c(20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)
drugs <- data.frame(dose, drugA, drugB)
colnames(drugs) <- c("Dosage", "Response to Drug A", "Response to DrugB")
plot(drugs)
plot(dose, type = "o", col = "blue")
? plot()
plot(dose, drugA, type = "b")
par(new = TRUE)
plot(dose, drugB, type = "b")
? par()
opar <- par(no.readonly = TRUE)
?? lty
par(lty = 2, pch = 17)
plot(dose, drugA, type = "b")
par(opar) #Resetting par
plot(dose, drugA, type = "b", lty = 3, lwd = 3, pch = 15, cex = 2)
title(main = "Drug Dosage", col.main = "blue", font.main = 4)
plot(dose, drugA, type = "b", lty = 3, lwd = 3, pch = 15, cex = 15, ylim = c(0, 100))
title(main = "Drug Dosage", col.main = "blue", font.main = 4)
lines(dose, drugB, type = "o", pch = 22, lty = 2, col = "red")
#range of drugA and drugB
graph_range <- range(0, drugA, drugB) #Give biggest range of drugA and drugB
plot(drugA, type = "b", pch = 15, lty = 3, lwd = 3, ylim = graph_range, axes = FALSE, xlab = "millilitres")
lines(drugB, type = "o", pch = 22, lty = 2, col = "red")
? axis()
axis(1, at = 1:5, labels = c("20ml", "40ml", "60ml", "80ml", "100ml"))
axis(2, las = 1, at = 5 * 0:graph_range[2])
box()


