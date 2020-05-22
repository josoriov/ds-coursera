pollutantmean <- function(directory, pollutant, id=1:332) {
  #directory <- "specdata"
  #pollutant <- "sulfate"
  f <- list.files(directory)
  
  mean_vector <- vector()
  
  for(i in id){
    filename <- paste(directory, f[[i]], sep="/")
    dat <- read.csv(filename)
    mean_temp <- mean(dat[[pollutant]], na.rm=TRUE)
    mean_vector <- append(mean_vector, mean_temp)
  }
  total_mean <- mean(mean_vector, na.rm=TRUE)
  return(total_mean)
}