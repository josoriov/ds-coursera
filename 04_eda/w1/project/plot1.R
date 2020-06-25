library(data.table)

# Reading the data set
colNames = c("date", "globalActivePower")
dat <- fread("data/household_power_consumption.txt", sep=";", na.strings="?",
             drop=c(2,4,5,6,7,8,9), col.names=colNames)

# Parsing data and getting only needed days
dat$date <- as.Date(dat$date, format="%d/%m/%Y")
dat <- dat[dat$date >= as.Date("2007-02-01") & dat$date<=as.Date("2007-02-02"),]

# Plotting
png(filename="plot1.png", width = 480, height = 480, units="px")
hist(dat$globalActivePower, main="Global active power", col="red",
     xlab="Global Active Power (Kilowatts)")
dev.off()