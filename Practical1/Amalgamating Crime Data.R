#Amalgamating all crime data into single file.
csv_file_list <- list.files(path = "Data/NI Crime Data/NI Crime Data", pattern = "*.csv", recursive = TRUE)
csv_file_list

combine_files <- function(file_list) {


    NI_crime_file <- NULL
    for (i in file_list) {


        temp_file <- read.csv(header = TRUE, paste("Data/NI Crime Data/NI Crime Data/", i, sep = ""), stringsAsFactors = FALSE)
        NI_crime_file <- rbind(NI_crime_file, temp_file)



    }
    return(NI_crime_file)
}
NI_crime_data <- combine_files(csv_file_list)
str(NI_crime_data)
write.csv(NI_crime_data, file = "Data/AllNICrimeData.csv", quote = FALSE, na = "", row.names = FALSE)
AllNICrime_data <- read.csv("Data/AllNICrimeData.csv")
#No. of rows in AllNICrime file
NROW(AllNICrime_data)

#Removing the unwanted columns
str(AllNICrime_data)
AllNICrime_data <- AllNICrime_data[, c(2, 5, 6, 7, 10)]
str(AllNICrime_data)
head(AllNICrime_data)

#Factorizing crime_type attribute
Crime_type <- factor(AllNICrime_data$Crime.type, order = FALSE)
AllNICrime_data$Crime.type <- Crime_type
str(AllNICrime_data)

#Modifying location attribute
AllNICrime_data$Location <- gsub("On or near ", "", AllNICrime_data$Location)
AllNICrime_data$Location[AllNICrime_data$Location == ""] <- NA
AllNICrime_data$Location <- toupper(AllNICrime_data$Location)

head(AllNICrime_data)

#Task 5 
clean_postcode <- read.csv("Data/CleanNIPostcodeData.csv", stringsAsFactors = FALSE)
head(clean_postcode)

clean_postcode$Primary_Thorfare <- tolower(clean_postcode$Primary_Thorfare)


head(clean_postcode)


install.packages("dplyr")
library(dplyr)
crime_location <- select(AllNICrime_data, Location)
crime_location
postcode_loc <- select(clean_postcode, Primary_Thorfare, Postcode)
str(postcode_loc)

data <- tbl_df(postcode_loc)
str(data)

find_a_postcode <- function(loc) {

    filterd_data <- filter(data, Primary_Thorfare == loc)

    suitable_postcode <- names(which.max(table(filterd_data$Postcode)))
    return(suitable_postcode)

}

postcode <- lapply(AllNICrime_data$Location, find_a_postcode)
postcode <- sapply(postcode, paste0, collapse = "")
head(AllNICrime_data)
install.packages("ggmap")
library(ggmap)
#Finding postcode based on longitude and latitude
data_crime <- tbl_df(AllNICrime_data)
str(data_crime)
head(data_crime)
empty_loc_data <- filter(data_crime, Postcode == "")
empty_loc_data

empty_loc_data$Postcode <- mapply(tidy_location = function(lon, lat) revgeocode(c(lon, lat)), empty_loc_data$Longitude, empty_loc_data$Latitude)

#Appending attributes
AllNICrime_data$Town <- clean_postcode$Town[match(AllNICrime_data$Postcode, clean_postcode$Postcode)]
str(AllNICrime_data)
AllNICrime_data$county <- clean_postcode$County[match(AllNICrime_data$Postcode, clean_postcode$Postcode)]
str(AllNICrime_data)


NIPostcode <- read.csv("Data/NIPostcodes.csv", header = TRUE)
str(NIPostcode)
new_file <- merge(x = AllNICrime_data, y = NIPostcode, by = "Location", all.x = TRUE)
str(new_file)

#Writing in new file
write.csv(AllNICrime_data, file = "Data/FinalNICrimeData.csv", quote = FALSE, row.names = FALSE)
Finalcrimedata <- read.csv("Data/FinalNICrimeData")
str(Finalcrimedata)
head(Finalcrimedata)

new <- subset(Finalcrimedata, grepl("Strabane", Location) & grepl("BT82", Postcode))
str(new)
