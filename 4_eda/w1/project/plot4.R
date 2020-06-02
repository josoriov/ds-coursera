library(data.table)

# Reading the data set
colNames = c("date", "time", "globalActivePower", "globalReactivePower", "voltage",
             "globalIntensity", "subMetering1", "subMetering2", "subMetering3")

dat <- fread("data/household_power_consumption.txt", sep=";", na.strings="?",
             col.names=colNames)

# Parsing data and getting only needed days
dat$date <- as.Date(dat$date, format="%d/%m/%Y")
dat <- dat[dat$date >= as.Date("2007-02-01") & dat$date<=as.Date("2007-02-02"),]


# Plotting and saving file
png(filename="plot4.png", width = 480, height = 480, units="px")
par(mfrow=c(2,2))

# Plot 1
plot(dat$globalActivePower, type="l", xlab="",
     ylab="Global Active Power", xaxt="n")
axis(side=1, at= c(1, as.integer(nrow(dat)/2), nrow(dat)), labels=c("Thu", "Fri", "Sat"))

# Plot 2
plot(dat$voltage, type="l", xlab="",
     ylab="Voltage", xaxt="n")
axis(side=1, at= c(1, as.integer(nrow(dat)/2), nrow(dat)), labels=c("Thu", "Fri", "Sat"))

# Plot 3
with(dat, {
    plot(subMetering1,type="l", xaxt="n", xlab="", ylab="Energy sub metering")
    lines(x=subMetering2, col="red")
    lines(x=subMetering3, col="blue")
})
legend("topright", lty=1, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       box.col = "transparent", bg="transparent")
axis(side=1, at= c(1, as.integer(nrow(dat)/2), nrow(dat)), labels=c("Thu", "Fri", "Sat"))

# Plot 4
plot(dat$globalReactivePower, type="l", xlab="",
     ylab="Global_reactive_power", xaxt="n")
axis(side=1, at= c(1, as.integer(nrow(dat)/2), nrow(dat)), labels=c("Thu", "Fri", "Sat"))


dev.off()