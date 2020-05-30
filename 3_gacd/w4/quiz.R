# 1
dat <- read.csv("1.csv")
a <- names(dat)
# a <- strsplit(names(dat), "wgtp")

# 2
# library(dplyr)
# dat <- read.csv("2.csv", skip=4)
# dat$X.4 <- gsub("\\,", "", dat$X.4)
# dat <- dat[1:215,]
# dat$X.4 <- as.numeric(dat$X.4)
# a <- dat[,"X.4"]
# RTA 377652.4

# 3
# library(dplyr)
# dat <- read.csv("2.csv", skip=4)
# dat$X.4 <- gsub("\\,", "", dat$X.4)
# dat <- dat[1:215,]
# countrynames <- dat[,"X"]
# RTA ^United


# 4
# library(dplyr)
# library(stringr)
# gdp_data <- read.csv("4_1.csv", skip=4)
# gdp_data <- gdp_data[1:215,]
# education_data <- read.csv("4_2.csv")
# 
# a <- merge(gdp_data, education_data, by.x="X", by.y="CountryCode")
# fiscal <-  a[a$Special.Notes != "",]
# fiscal <- a[, "Special.Notes"]

# 5
# library(quantmod)
# amzn <- getSymbols("AMZN",auto.assign=FALSE)
# sampleTimes <- index(amzn)
# year <- substring(sampleTimes,1,4)