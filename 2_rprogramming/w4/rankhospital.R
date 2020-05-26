dat <- read.csv("outcome-of-care-measures.csv", colClasses = "character")


rankhospital <- function(state, outcome, num="best") {
  a <- dat[c(2,7,11,17,23)] # Getting only the needed columns
  a <- a[a$State == state,]

  if(length(a[,1]) == 0) {
    stop("Invalid state")
  }
  else if(outcome == "heart attack") {
    a <- a[c(1,3)] # heart attack index is 3
  }
  else if(outcome == "heart failure") {
    a <- a[c(1,4)] # heart failure index is 4
  }
  else if(outcome == "pneumonia") {
    a <- a[c(1,5)] # pneumonia index is 5
  }
  else {
    stop("Invalid outcome")
  }
  
  # Cleaning the dataframe of other variables
  names(a)[2] <- "Rate"
  a[, 2] <- as.numeric(a[, 2]) # Coercing the column as numeric type
  a <- a[order(a[,2], a[,1]), ]
  a <- a[complete.cases(a), ] # Removing rows with NA
  
  # Second if to have in account the best parameter
  if (num == "best") {
    return(a[1,1])
  }
  else if (num == "worst") {
    return(a[length(a[,1]),1])
  }
  else if(typeof(num) == "double" && length(a[,1]) < num) {
    return(NA)
  }
  else if(typeof(num) == "double" && length(a[,1]) >= num) {
    return(a[num, 1])
  }
  else {
    stop("Invalid num parameter")
  }
}