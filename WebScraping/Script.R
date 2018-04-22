install.packages("rvest")
library(rvest)
url <- 'https://www.imdb.com/search/title?release_date=2017-01-01,2017-12-31&count=250'
web_page <- read_html(url)
head(web_page)
str(web_page)
#Using css selector to scrap ranking info
rank_data_html <- html_nodes(web_page, '.text-primary')
head(rank_data_html, 10)
length(rank_data_html)
#Converting HTML to text
rank_data <- html_text(rank_data_html)
head(rank_data, 10)
#Convert ranking data from strings to numeric
rank_data <- as.numeric(rank_data)
head(rank_data)
#Using CSS selector to scrap title
title_data_html <- html_nodes(web_page, '.lister-item-header')
head(title_data_html)
#Narrowing down to only title
title_data_html <- html_nodes(web_page, 'div.lister-item-content > h3 > a')
head(title_data_html)
descrip_data_html <- html_nodes(web_page, '.text-muted')
description_data <- html_text(descrip_data_html)
head(description_data)

descrip_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > p:nth-child(4)')
description_data <- html_text(descrip_data_html)
head(description_data)
description_data <- gsub("\n *", "", description_data)
head(description_data, 10)
length(description_data)

runtime_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > p:nth-child(2) > span.runtime')
runtime_data <- html_text(runtime_data_html)
runtime_data <- gsub(" min", "", runtime_data)
runtime_data <- as.numeric(runtime_data)
head(runtime_data,10)
head(runtime_data)
length(runtime_data)

genre_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > p:nth-child(2) > span.genre')
genre_data <- html_text(genre_data_html)
genre_data <- gsub("\n", "", genre_data)
genre_data <- gsub(" ", "", genre_data)#Removing excess spaces
genre_data <- gsub(",.*", "", genre_data)
head(genre_data, 10)
length(genre_data)


rating_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > div > div.inline-block.ratings-imdb-rating > strong')
rating_data <- html_text(rating_data_html)
rating_data <- as.numeric(rating_data)
head(rating_data, 10)
length(rating_data)

director_data_html <- html_nodes(web_page, '#main > div > div > div.lister-list > div:nth-child(n) > div.lister-item-content > p:nth-child(5)')
director_data <- html_text(director_data_html)
head(director_data)
length(director_data)