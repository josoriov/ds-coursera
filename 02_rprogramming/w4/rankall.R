dat <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

rankall <- function(outcome, num="best") {
  a <- dat[c(2,7,11,17,23)] # Getting only the needed columns
  
  if(outcome == "heart attack") {
    a <- a[c(1,2,3)] # heart attack index is 3
  }
  else if(outcome == "heart failure") {
    a <- a[c(1,2,4)] # heart failure index is 4
  }
  else if(outcome == "pneumonia") {
    a <- a[c(1,2,5)] # pneumonia index is 5
  }
  else {
    stop("Invalid outcome")
  }
  
  # Cleansing the dataframe of other variables
  names(a)[3] <- "Rate"
  a[, 3] <- as.numeric(a[, 3]) # Coercing the column as numeric type
  a <- a[order(a[, 2], a[,3], a[,1]), ] # Order by state, rate and name
  a <- a[complete.cases(a), ] # Removing rows with NA
  a <- split(a, a$State)
  # Index is a vector indicating the n-th value that should be selected
  ind <- NULL 
  # Second if to have in account the best parameter
  if (num == "best") {
    # The index is always 1 because is the best
    ind <- replicate(length(a), 1)
  }
  else if (num == "worst") {
    # Index correspond to the length of each list element since it's the worst
    ind <- lapply(a, function(x) length(x[, 1]))
    ind <- unlist(ind)
  }
  else {
    # Index correspond to the input number
    ind <- replicate(length(a),num)
  }
  # Creating the dataframe to be returned
  df <- data.frame(Hospital=character(), State=character())
  # Looping through the a list to fill the dataframe
  for(i in 1:length(a)) {
    state.name <- names(a)[i] # Getting the state name
    hospital.name <- a[[i]][ind[i],1] # Getting the ind hospital name of the i-th state
    # Adding a new row to the dataframe
    df[nrow(df) + 1,] = c(hospital.name, state.name) # This allow only a single data type
  }
  return(df)
}