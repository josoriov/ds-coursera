# Importing the data to the environment
# source('~/Github/ds_coursera/4_eda/project/data_reading.R')

library(dplyr)
library(ggplot2)
# Filtering by fips code
dat <- NEI[NEI$fips == "24510",]
dat <- select(dat, year, Emissions, type)
dat <- aggregate(dat$Emissions, by=list(dat$year, dat$type), FUN=sum, na.rm=T)
names(dat) <- c("year", "type", "Emissions")
dat$Emissions <- dat$Emissions/1000.0 # Rescaling to KTon
dat$year <- as.character(dat$year)


gp <- ggplot(dat, aes(x=year, y=Emissions))
gp <- gp + geom_bar(stat="identity", fill="#5BC2C2") +
    geom_text(aes(label=round(Emissions, digits=2)), vjust=-0.5, color="black", size=3.5)
gp <- gp + facet_wrap(~type) + ggtitle("Emmisions by type")
gp <- gp + theme(axis.title.x = element_text(size=18)) + ylab("Emissions (KTon)") +
    theme(axis.title.y = element_text(size=18)) + xlab("Year")
png(filename="plot3.png", width = 1280, height = 640, units="px")
print(gp)
dev.off()