# Importing the data to the environment
# source('~/Github/ds_coursera/4_eda/project/data_reading.R')

library(dplyr)
# Filtering by fips code
dat <- NEI[NEI$fips == "24510",]
dat <- select(dat, year, Emissions)
dat <- aggregate(dat$Emissions, by=list(year=dat$year), FUN=sum, na.rm=T)
names(dat) <- c("year", "Emissions")
dat$Emissions <- dat$Emissions/1000.0 # Rescaling to KTon

png(filename="plot2.png", width = 480, height = 480, units="px")
barplot(dat$Emissions, names.arg=dat$year, xlab="Year", ylab="Emissions (KTon)",
        main="Baltimore emissions chart", col="#5BC2C2", border="#122c34")

dev.off()
