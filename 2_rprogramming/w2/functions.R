# Add two numbers
add2 <- function(x, y) {
  x+y
}

# Return a sub-vector of x whose numbers are above n
above <- function(x, n=10) {
  use <- x > n
  x[use]
}

# Calculate the means of the columns in a dataframe or matrix
column_mean <- function(x, removeNA=TRUE) {
  nc <- ncol(x) # Number of columns in x
  means <- numeric(nc) # Vector to store the means
  for(i in 1:nc) {
    means[i] <- mean(x[, i], na.rm = removeNA) # calculates the means of each column
  }
  means # Last expression to return
}