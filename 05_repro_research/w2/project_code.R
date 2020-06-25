# 1
dat <- read.csv("data/activity.csv")
dat$date <- as.Date(dat$date, format="%Y-%m-%d")

# step_number <- aggregate(dat$steps, by=list(date=dat$date), FUN=sum, na.rm=T)
# names(step_number)[2] <- "steps"
# 
# interval_stat <- aggregate(dat$steps, by=list(interval=dat$interval), FUN=mean, na.rm=T)
# names(interval_stat)[2] <- "steps"

# 2
step_number <- aggregate(dat$steps, by=list(date=dat$date), FUN=sum, na.rm=T)
names(step_number)[2] <- "steps"
png(filename="plot2.png", width = 480, height = 480, units="px")
hist(step_number$steps, main="Hisogram of steeps number", breaks=10,
     col="#2F9CB1")
dev.off()

# 3
# step_number.mean <- round(mean(step_number$steps), digits=2)
# step_number.median <- median(step_number$steps)

# 4
# step_number <- aggregate(dat$steps, by=list(date=dat$date), FUN=mean, na.rm=T)
# names(step_number)[2] <- "steps"
# png(filename="plot4.png", width = 480, height = 480, units="px")
# plot(step_number$date, step_number$steps, col=rgb(47/255, 156/255, 177/255, 0.8),
#      xlab="Date", ylab="Average number of steps", pch = 16)
# dev.off()

# 5
# ind <- which.max(interval_stat$steps)
# max_interval <- interval_stat$interval[ind]

# 6
# miss <- which(is.na(dat$steps))
# # In case there's a NA value in step it will be replaced by the average of the interval
# for (i in miss) {
#     a <- dat$interval[i]
#     dat$steps[i] = round(interval_stat[interval_stat$interval == a,][[2]],
#                          digits=0)
# }
# rm(a, i, miss)

# 7
# step_number <- aggregate(dat$steps, by=list(date=dat$date), FUN=sum, na.rm=T)
# names(step_number)[2] <- "steps"
# png(filename="plot7.png", width = 480, height = 480, units="px")
# hist(step_number$steps, main="Hisogram of steeps number (No NA's)", breaks=10,
#      col="#2F9CB1")
# dev.off()

# 8
# library(lattice)
# Sys.setlocale("LC_TIME", "English")
# weekdays_val <- c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
# dat$wDay <- factor((weekdays(dat$date) %in% weekdays_val),
#                    levels=c(FALSE, TRUE), labels=c('weekend', 'weekday'))
# 
# wDay_interval.data <- aggregate(dat$steps, by=list(wDay=dat$wDay, interval=dat$interval),
#                          FUN=mean, na.rm=T)
# names(wDay_interval.data)[3] <- "steps"
# 
# plt <- xyplot(steps~interval|wDay, data=wDay_interval.data, main="Density Plot by type of day",
#               xlab="Interval", ylab="Steps", layout=c(1, 2), type="l")
# 
# trellis.device(device="png", filename="plot8.png", height=480, width=480, units="px")
# print(plt)
# dev.off()




