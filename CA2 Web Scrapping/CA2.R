install.packages("rvest")
library(rvest)
url <- 'https://www.irishtimes.com/profile/conor-lally-7.1010727'
web_page <- read_html(url)
head(web_page)
str(web_page)

#Using css selector to scrap  info
crime_data_html <- html_nodes(web_page, '#search_results > div:nth-child(n) > div > div > div > span > a')
crime_data <- html_text(crime_data_html)
head(crime_data, 10)
length(crime_data)

#Convert ranking data from strings to numeric
rank_data <- as.numeric(rank_data)


crime_type_html <- html_nodes(web_page, '#search_results > div:nth-child(n) > div > div > div > ul > li.news.first > a')
crime_type_data <- html_text(crime_type_html)
head(crime_type_data, 20)
length(crime_type_data)

crime_date_html <- html_nodes(web_page, '#search_results > div:nth-child(n) > div > div > div > ul > li.date')
crime_date_data <- html_text(crime_date_html)
head(crime_date_data, 20)
length(crime_date_data)


crime_desc_html <- html_nodes(web_page, '#search_results > div:nth-child(n) > div > div > p')
crime_desc_data <- html_text(crime_desc_html)
head(crime_desc_data, 20)
length(crime_desc_data)

