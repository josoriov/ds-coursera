# Reading from MySQL
# require("RMySQL")
# ucscDB <- dbConnect(MySQL(), user="genome",
#                     host="genome-mysql.cse.ucsc.edu")
# result <- dbGetQuery(ucscDB, "Show databases;"); dbDisconnect(ucscDB);
# 
# hg19 <- dbConnect(MySQL(), user="genome", db="hg19",
#                     host="genome-mysql.cse.ucsc.edu")
# allTables <- dbListTables(hg19)
# 
# fields <- dbListFields(hg19, "affyU133Plus2")
# 
# query <- dbSendQuery(hg19, "SELECT * FROM affyU133Plus2 LIMIT 10;")
# dat <- fetch(query, n=5);dbClearResult(query);dbDisconnect(hg19)


# Reding from HDF5
# library("rhdf5")
# readA <- h5read("some_file.h5", "foo/A") 


# Reading from the web
# library("XML")
# url <- "some_url"
# html <- htmlTreeParse(url, useInternalNodes = T)
# xpathSApply(html, "//title", xmlValue) # Get the title
# 
# library("httr"); html <- GET(url)
# content <- content(html, as="text")
# parsedHtml <- htmlParse(content, asText=T)


# Reading from API's
library("httr")
myapp <- oauth_app("twitter", key="consumerKey",
                   secret="yourSecret")
sig <- sign_oauth1.0(myapp, token="yourToken",
                     token_secret="yourTokenSecret")
homeTl <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)