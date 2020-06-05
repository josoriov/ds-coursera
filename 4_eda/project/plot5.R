# Importing the data to the environment
# source('~/Github/ds_coursera/4_eda/project/data_reading.R')

library(dplyr)

# Filtering by coal

a <- filter(SCC, grepl("Vehicles|vehicles", EI.Sector))
scc_codes <- as.vector(a$SCC)
dat <- filter(NEI, SCC %in% scc_codes)
# Filtering by fips code
dat <- dat[dat$fips == "24510",]

dat <- aggregate(dat$Emissions, by=list(year=dat$year), FUN=sum, na.rm=T)
names(dat) <- c("year", "Emissions")
dat$Emissions <- dat$Emissions/1000.0 # Rescaling to KTon
rm(a, scc_codes)

png(filename="plot5.png", width = 480, height = 480, units="px")
barplot(dat$Emissions, names.arg=dat$year, xlab="Year", ylab="Emissions (KTon)",
        main="Emmisions from Vehicles (Baltimore)", col="#5BC2C2", border="#122c34")

dev.off()

