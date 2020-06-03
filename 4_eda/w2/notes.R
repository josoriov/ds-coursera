library(ggplot2)

# GRaph with color code
a <- qplot(displ, hwy, data=mpg, color=drv)
# Adding a statistic
b <- qplot(displ, hwy, data=mpg, geom=c("point", "smooth"))
# Histogram
c <- qplot(hwy, data=mpg, fill=drv)
# Facets
d <- qplot(displ, hwy, data=mpg, facets=.~drv)
e <- qplot(hwy, data=mpg, facets=drv~., binwidth=2)
