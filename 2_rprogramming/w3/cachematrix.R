## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
# Function that takes a matrix and stores it in the cache along with its inverse
makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    # Store the matrix in the cache
    set <- function(y) {
        x <<- y
        # Initilizes the inverse as a null value
        inv <<- NULL
    }
    # Return the matrix
    get <- function() x
    # Set the inverse of the matrix
    set_inverse <- function(inverse) inv <<- inverse
    # Return the inverse of the matrix
    get_inverse <- function () inv
    # List of object functions
    list(set=set, get=get,
         setinverse=set_inverse,
         getinverse=get_inverse)
}


## Write a short comment describing this function
# Function that takes the matrix and calculates or retrieves its inverse
cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'

    # Get the inverse of the matrix
    inv <- x$getinverse()
    # If said inverse exists, the system returns it
    if(!is.null(inv)) {
        return(inv)
    }
    # If it doesn't exists the function calculates the inverse
    else{
        dat <- x$get()
        inv <- solve(dat, ...)
        x$setinverse(inv)
        return(inv)
    }
}