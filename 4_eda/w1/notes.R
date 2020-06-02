x <- rnorm(100)
y <- x + rnorm(100)
# plot(x, y)
# par(mar=c(2,2,2,2), cex=1)
# fit <- lm(x ~ y)
# abline(fit)
# See example of scatter point format
# example(points)


g <- gl(2, 50, labels=c("male", "female"))
plot(x,y, type="n")
points(x[g=="male"], y[g=="male"], col="green")
points(x[g=="female"], y[g=="female"], col="blue")