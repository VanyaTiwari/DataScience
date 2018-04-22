# 1. Importing NIPostcode dataset
nip_data <- read.csv("C:/Big Data/Data science/Practicals/Data/NIPostcodes.csv", header = FALSE, stringsAsFactors = FALSE, na.strings = c("","NA"))
#Structure and first 10 rows of the dataset
str(nip_data)
head(nip_data, n = 10)

# 2. Sum and mean of the total missing data
sum(is.na(nip_data))
missing_result <- mean(is.na(nip_data))
missing_result
#Sum and mean of the missing data row-wise
missing_data <- !complete.cases(nip_data)
sum(missing_data)
mean(missing_data)

# 3. Removing the data with missing values
na_count <- sapply(nip_data, function(x) sum(is.na(x))) #Checking missing values in each column
na_count
nip_data$V1 <- NULL
nip_data$V2 <- NULL
nip_data$V6 <- NULL
nip_data$V7 <- NULL
head(nip_data)
str(nip_data)

#sum(is.na(nip_data$V12))
#nip_data <- nip_data[!is.na(nip_data$V12),]
#str(nip_data)

#na.omit(nip_data, cols =nip_data$V12 )

# 4. Adding suitable title to each attribute
col_names <- c("Building_Name","Number", "Primary_Thorfare", "Locality", "Townland", "Town", "County", "Postcode", "x_coordinates", "y_coordinates", "Primary_key")
colnames(nip_data) <- col_names
head(nip_data)
str(nip_data)

# 5. Modify the county attribute to the categorising factor
attach(nip_data)
County1 <- factor(County, order = FALSE)
nip_data$County <- County1
head(nip_data)
str(nip_data)





# 7. Moving primary key to start of dataframe
nip_data = nip_data[, c(11, 1:10)]
str(nip_data)
head(nip_data)
# 8. Limavady file with  information that has locality, townland and town containing the name “Limavady”.
attach(nip_data)
Limavady_data <- subset(nip_data, grepl("LIMAVADY",Locality) & grepl("LIMAVADY",Townland) & grepl("LIMAVADY",Town))
str(Limavady_data)
head(Limavady_data)
write.csv(Limavady_data, file = "C:/Big Data/Data science/Practicals/Data/Limavady.csv ", quote = FALSE,row.names = FALSE)
read.csv("C:/Big Data/Data science/Practicals/Data/Limavady.csv ")

# 9. Save the modified dataset in a csv file called CleanNIPostcodeData
write.csv(nip_data, file = "C:/Big Data/Data science/Practicals/Data/CleanNIPostcodeData.csv ", quote = FALSE, row.names = FALSE)
new_file <- read.csv("C:/Big Data/Data science/Practicals/Data/CleanNIPostcodeData.csv ")
str(new_file)
head(new_file)

# 6. Align attributes and relevant data
install.packages("knitr")
library(knitr)
nip_data <- kable(nip_data)
head(nip_data,10)