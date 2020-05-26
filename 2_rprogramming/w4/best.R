dat <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

# 2
best <- function(state, outcome) {
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
  a[, 2] <- as.numeric(a[, 2]) # Coercing the column as numeric type
  a <- a[order(a[,2], a[,1]), ]
  return(a[1,1])
}