install.packages("rvest")
library(rvest)

#Irish Times webpage is loaded
url <- 'https://www.irishtimes.com/profile/conor-lally-7.1010727'
web_page <- read_html(url)
head(web_page)
str(web_page)

#Scrapping crime headings
crime_data_html <- html_nodes(web_page, '#search_results > div:nth-child(n) > div > div > div > span > a')
crime_data <- html_text(crime_data_html)
head(crime_data, 10)
length(crime_data)

#Scrapping news category
crime_type_html <- html_nodes(web_page, '#search_results > div:nth-child(n) > div > div > div > ul > li.news.first > a')
crime_type_data <- html_text(crime_type_html)
head(crime_type_data, 10)
length(crime_type_data)

#Scrapping date of the crime 
crime_date_html <- html_nodes(web_page, '#search_results > div:nth-child(n) > div > div > div > ul > li.date')
crime_date_data <- html_text(crime_date_html)
head(crime_date_data, 10)

#Removing the time from the date
crime_date <- sub(",[^,]+$*", "", crime_date_data)
head(crime_date, 10)
length(crime_date)

#Scrapping description of crime
crime_desc_html <- html_nodes(web_page, '#search_results > div:nth-child(n) > div > div > p')
crime_desc_data <- html_text(crime_desc_html)
head(crime_desc_data, 20)
length(crime_desc_data)

new_dataset <- data.frame(crime_data, crime_type_data, crime_date, crime_desc_data)
str(new_dataset)
head(new_dataset)

#Aligning the data into columns
install.packages("knitr")
library(knitr)
new_dataset <- kable(new_dataset)
head(new_dataset, 10)
saveRDS(new_dataset, file = "crime_webScrapping.rds")
