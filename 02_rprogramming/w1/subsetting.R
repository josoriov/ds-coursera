# Subsetting vectors
x <- c(1,2,3,4,5)
# Traditional subsetting
x[1]
x[1:4]
x[x < 1]
# Subsetting by creating a logical vector
u <- x > 1
x[u]

# Subsetting lists
x <- list(foo=1:4, bar=0.6, baz="hello")
x[1]
x[[1]]
x$bar
x["bar"]
x[["bar"]]
x[["b", exact=FALSE]] #Partial matching
# Extracting multiple elements
x[c(1, 3)]
# Subsetting ensted elements
x <- list(a=list(10,11,12), b=c(3.14, 2.81))
x[[c(1, 3)]]
x[[1]][[3]]


# Subsetting matrices
x <- matrix(1:6, 2, 3)
x[1, 2] # Returns 3
x[1, ] # Return first row
x[, 2] # Returns second column


# Removing missing values
x <- c(1, 2, NA, 4, NA, 6)
y <- c("a", "b", NA, "d", NA, "f")
bad <- is.na(x)
x[!bad]
# Remove NA values using logical vector
good <- complete.cases(x)
x[good]

# Vectorized operations
x <- 1:4; y <- 6:9
x+y
x > 2
x >= 2
x == 2
x*y
x/y
# The operations are executed opint to point

# Matrix multiplication
x <- matrix(1:2, 2, 2); y <- matrix(rep(10, 4), 2, 2)
x * y # Element-wise multiplication
x / y # Element-wise division
x %*% y # True matrix multiplication