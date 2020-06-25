complete <- function(directory, id=1:332) {
  f <- list.files(directory) # Get vector of filenames
  comp_vector <- vector()
  id_vector <- vector()
  
  for(i in id){
    filename <- paste(directory, f[[i]], sep="/")
    dat <- read.csv(filename)
    dat2<-dat[complete.cases(dat), ] # New dataframe with complete cases
    id_vector <- append(id_vector, i)
    comp_temp <- length(dat2[,1])
    comp_vector <- append(comp_vector, comp_temp)
  }
  
  column.names <- c("id", "nobs")
  row.names <- 1:length(id_vector)
  # Constructing the returning array
  result <- array(c(id_vector, comp_vector), dim=c(length(id_vector), 2),
                  dimnames=list(row.names, column.names))
  
  return(result)
}