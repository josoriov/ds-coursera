library(data.table)

# Reading the data set
colNames = c("date", "globalActivePower")
dat <- fread("data/household_power_consumption.txt", sep=";", na.strings="?",
             drop=c(2,4,5,6,7,8,9), col.names=colNames)

# Parsing data and getting only needed days
dat$date <- as.Date(dat$date, format="%d/%m/%Y")
dat <- dat[dat$date >= as.Date("2007-02-01") & dat$date<=as.Date("2007-02-02"),]

# Plotting and saving file
png(filename="plot2.png", width = 480, height = 480, units="px")
plot(dat$globalActivePower, type="l", xlab="",
     ylab="Global Active Power (Kilowatts)", xaxt="n")
axis(side=1, at= c(1, as.integer(nrow(dat)/2), nrow(dat)), labels=c("Thu", "Fri", "Sat"))
dev.off()