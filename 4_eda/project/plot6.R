# Importing the data to the environment
# source('~/Github/ds_coursera/4_eda/project/data_reading.R')

library(dplyr)
library(ggplot2)

# Filtering by coal

a <- filter(SCC, grepl("Vehicles|vehicles", EI.Sector))
scc_codes <- as.vector(a$SCC)
dat <- filter(NEI, SCC %in% scc_codes)
# Filtering by fips code
dat <- dat[dat$fips == "24510" | dat$fips == "06037",]

dat <- aggregate(dat$Emissions, by=list(dat$year, dat$fips), FUN=sum, na.rm=T)
names(dat) <- c("year", "city", "Emissions")
# dat$Emissions <- dat$Emissions/1000.0 # Rescaling to KTon
rm(a, scc_codes)
dat$year <- as.character(dat$year)
dat$city <- gsub("24510", "Baltimore", dat$city)
dat$city <- gsub("06037", "LA County", dat$city)

gp <- ggplot(dat, aes(x=year, y=Emissions))
gp <- gp + geom_bar(stat="identity", fill="#5BC2C2", show.legend=T) +
    geom_text(aes(label=round(Emissions, digits=2)), vjust=-0.5, color="black", size=3.5)
gp <- gp + facet_wrap(~city)
gp <- gp + theme(axis.title.x = element_text(size=18)) + ylab("Emissions (KTon)")
    theme(axis.title.y = element_text(size=18)) + xlab("Year")
png(filename="plot6.png", width = 1280, height = 640, units="px")
print(gp)
dev.off()