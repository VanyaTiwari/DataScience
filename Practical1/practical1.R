#Reading diabetes dataset into my_data data frame
my_data <- read.csv("C:/Big Data/Data science/Practicals/Data/Diabetes-md.csv")
head(my_data)
# Displaying the structure and class type of my_data
str(my_data)
class(my_data)
#Configuring the column names
c_names <- c("PatientName", "NIAdress", "Type", "Age", "HealthStatus")
colnames(my_data) <- c_names
#Refactoring Health status and Type columns
Health_Status <- factor(my_data$`HealthStatus`, order = TRUE, levels = c("Poor","Improved","Excellent"))
my_data$`Health Status` <- Health_Status
D_Type <- factor(my_data$Type, order = TRUE, levels = c("Type 1", "Type 2"))
my_data$Type <- D_Type
str(my_data)

#Storing the name attribute of my_data into patient_name
patient_name <- data.frame(my_data$'PatientName')
head(patient_name, n = 10)
class(patient_name)
#Counting number of missing values in my_data
my_data[my_data == ""] <- NA #Assingning blank spaces with NA
summary(my_data) #Examining number of NA values
sum(is.na(my_data)) #Count total no. of na values

#Removing the missing values from my_data
my_data <- na.omit(my_data)
str(my_data)

















