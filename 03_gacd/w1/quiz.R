# 1
# dat <- read.csv("housing.csv")
# a <- dat(dat, VAL==24)
# Rta = 53

# 3
# RTA = 36534720    

# 4
require(XML)
dat <- xmlParse("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml")
xml_data <- xmlToList(dat)
xml_data <- xml_data[[1]]
a <- unlist(lapply(xml_data, function(x) x$zipcode == "21231"))

# 5
# library("data.table")
# dat <- fread(file="data_survey.csv")
# dat[, mean(pwgtp15), by=SEX]



