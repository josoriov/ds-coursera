# The assignemt operator
# <- operator that assigns a value to a symbol
x <- 1:20
msg <- "hello"


# Vectors
# The c function can create vectors of objects
x <- c(0.5, 0.6) # Numeric
x <- c(TRUE, FALSE) # Logical
x <- c(T, F) # Logical
x <- c("a", "b", "c") # Character
x <- 9:29 # Integer
x <- c(1+0i, 2+4i) # Complex

# Using the vector() function
x <- vector("numeric", length = 10)


# Coercing
# Mixing types
y <- c(1.7, "a") # Character
y <- c(TRUE, 2) # Numeric
y <- c("a", TRUE) # Character

# Coerce from one class to another
x <- 0:6
as.numeric(x)
as.logical(x)
as.character(x)
as.complex(x)
# Non sensical coercion results in NA's


# Lists
x <- list(1, "a", TRUE, 1+4i)


# Matrices
# Matrices are constructed column-wise
m <- matrix(nrow=2, ncol=3)
dim(m)
# Creating a matrix by adding dimension to a vector
m <- 1:10
dim(m) <- c(2, 5)
attributes(m)
# column and row binding
x <- 1:3
y <- 10:12
cbind(x, y)
rbind(x, y)


# Factors
x <- factor(c("yes", "yes", "no", "yes", "no"))
table(x)
unclass(x)
# Giving the order of levels
x <- factor(c("yes", "yes", "no", "yes", "no"),
            levels=c("yes", "no"))


# Missing values
x <- c(1, 2, NA, NaN, 3)
is.na(x)
is.nan(x)
# NA's have a class. NaN is a NA, but NA is not necesarily NaN


# Dataframe store tabular data
# Usually created using read.table() or read.csv()
x <- data.frame(foo=1:4, bar=c(T,T,F,F))
nrow(x)
ncol(x)


