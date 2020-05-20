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
