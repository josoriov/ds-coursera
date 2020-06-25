# Apply function
# lapply
x <- list(a=1:5, b=norm(10))
lapply(x, mean)
lapply(x, runif, min=0, max=10) # Random uniform variable generator

# apply
x <- matrix(rnorm(200), 20, 10)
apply(x, 1, sum) # Sum of rows
apply(x, 2, mean) # Mean of columns
# Note that the functions colSums, colMeans, rowSums and rowMeans exist
apply(x, 1, quantile, probs=c(0.25,0.75)) # Calculate quantiles
a <- array(rnorm(2*2*10), c(2,2,10))
apply(a, c(1,2), mean) # Mean of first two dimensions

# mapply
mapply(rep, 1:4, 4:1)


# library(datasets)
# data(iris)
# dat <- iris[iris$Species == 'virginica',]
# 
# a<-apply(iris[,1:4], 2, mean)

# library(datasets)
# data(mtcars)

# a<-sapply(split(mtcars$hp, mtcars$cyl), mean)
# a<-with(mtcars, tapply(mpg, cyl, mean))