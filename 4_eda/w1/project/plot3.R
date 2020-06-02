library(data.table)

# Reading the data set
colNames = c("date", "subMetering1", "subMetering2", "subMetering3")
dat <- fread("data/household_power_consumption.txt", sep=";", na.strings="?",
             drop=c(2,3,4,5,6), col.names=colNames)

# Parsing data and getting only needed days
dat$date <- as.Date(dat$date, format="%d/%m/%Y")
dat <- dat[dat$date >= as.Date("2007-02-01") & dat$date<=as.Date("2007-02-02"),]

# Plotting and saving file
png(filename="plot3.png", width = 480, height = 480, units="px")
with(dat, {
    plot(subMetering1,type="l", xaxt="n", xlab="", ylab="Energy sub metering")
    lines(x=subMetering2, col="red")
    lines(x=subMetering3, col="blue")
})
legend("topright", lty=1, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis(side=1, at= c(1, as.integer(nrow(dat)/2), nrow(dat)), labels=c("Thu", "Fri", "Sat"))
dev.off()