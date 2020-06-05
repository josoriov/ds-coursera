# Importing the data to the environment
# source('~/Github/ds_coursera/4_eda/project/data_reading.R')

library(dplyr)

dat <- aggregate(NEI$Emissions, by=list(year=NEI$year), FUN=sum, na.rm=T)
names(dat) <- c("year", "Emissions")
dat$Emissions <- dat$Emissions/100000.0 # Rescaling by MTons 

png(filename="plot1.png", width = 480, height = 480, units="px")
barplot(dat$Emissions, names.arg=dat$year, xlab="Year", ylab="Emissions (MTon)",
        main="Total emissions chart", col="#5BC2C2", border="#122c34")

dev.off()
