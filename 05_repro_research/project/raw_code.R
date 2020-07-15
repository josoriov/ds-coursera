# Rrading the data using only the column needed
library(data.table)
library(dplyr)
library(ggplot2)
library(viridis)

cols.keep <- c("EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP",
               "CROPDMG", "CROPDMGEXP") 
dat <- fread("data/storm_data.csv", select=cols.keep)
names(dat) <- c("evtype", "fatalities", "injuries", "propdmg", "propdmgexp",
                "cropdmg", "cropdmgexp")

# Function to replace the exponents
replace_exp <- function(x) {
    if (x=="K" | x=="k") {
        return(1000)
    }
    else if (x=="M" | x=="m") {
        return(1000000)
    }
    else {
        return(1)
    }
}
# Only data with kilo or mega exp will be processed
# The other ones could not be understood an so we will asume them as 1
dat$propdmgexp <- sapply(dat$propdmgexp, replace_exp)
dat$cropdmgexp <- sapply(dat$cropdmgexp, replace_exp)

# Multiplying the value for the correspondent exponent and dropping exp columns
dat$propdmg <- dat$propdmg * dat$propdmgexp
dat$cropdmg <- dat$cropdmg * dat$cropdmgexp
dat[,c("propdmgexp", "cropdmgexp"):=NULL]


# # Calculating the cost in lives
# 
# 
# # Ratio of fatalities to injuries is calculated
# injury_fatal.ratio <- floor(sum(dat$injuries)/sum(dat$fatalities))
# # There is 9 time more fatalities than injuries
# # The score will be given on this basis
# 
# health_cost <- dat %>% select(evtype, fatalities, injuries) %>%
#     mutate(health.score = (fatalities*injury_fatal.ratio) + injuries)
# health_cost <- aggregate(list(health_cost$fatalities, health_cost$injuries,
#                               health_cost$health.score),
#                          FUN=sum, na.rm=T, by=list(evtype=health_cost$evtype))
# names(health_cost)[2:4] <- c("fatalities", "injuries", "health.score")
# health_cost <- health_cost[order(-health_cost$health.score),]
# row.names(health_cost) <- NULL
# 
# # Re scale to thousands
# health_cost[,2:4] <- lapply(health_cost[,2:4], function(x) {
#     x/1000.0
# })
# 
# a <- head(health_cost, 10)
# # Plotting the results
# plt <- ggplot(data=a, aes(x=injuries, y=fatalities, col=health.score)) +
#     geom_point(size=3) + scale_color_gradientn(colours=viridis(10)) +
#     geom_text(aes(label=evtype), size=3, vjust="inward", hjust="inward") +
#     theme_grey(base_size = 14) + xlab("Injuries") + ylab("Fatalities")
# 
# 
# png(filename="plot1.png", width = 620, height = 480, units="px")
# # plot(a$fatalities, a$injuries, xlab="Event", pch=19, cex=1.5,
# #         ylab="Fatalities", main="Fatalities and injuries", col="#5BC2C2")
# print(plt)
# dev.off()




# Calculating the cost in property dmg
monetary <- dat %>% select(evtype, propdmg, cropdmg) %>%
    mutate(total = propdmg + cropdmg)
monetary <- aggregate(list(monetary$propdmg, monetary$cropdmg,
                           monetary$total),
                         FUN=sum, na.rm=T, by=list(evtype=monetary$evtype))
names(monetary)[2:4] <- c("propdmg", "cropdmg", "total")
monetary <- monetary[order(-monetary$total),]
row.names(monetary) <- NULL
# Re scale to millions
monetary[,2:4] <- lapply(monetary[,2:4], function(x) {
    x/1000000.0
})

# Plotting the results
b <- head(monetary, 10)
plt <- ggplot(data=b, aes(x=propdmg, y=cropdmg, col=total)) +
    geom_point(size=3) + scale_color_gradientn(colours=viridis(10)) +
    geom_text(aes(label=evtype), size=3, vjust="inward", hjust="inward") +
    theme_grey(base_size = 14) + xlab("Property damage (millions)") +
    ylab("Crop Damage (millions)")


png(filename="plot2.png", width = 640, height = 540, units="px")
print(plt)
dev.off()