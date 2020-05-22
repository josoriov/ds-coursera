corr <- function(directory, threshold=0) {
  f <- list.files(directory)
  id <- 1:length(f)
  
  corr_vector <- vector()
  
  for(i in id){
    filename <- paste(directory, f[[i]], sep="/")
    dat <- read.csv(filename)
    dat2<-dat[complete.cases(dat), ] # Creates a dataframe with the complete rows
    comp_temp <- length(dat2[,1]) # Number of complete observations
    
    # Calculates the corr if complete surpasses threshold
    if(comp_temp > threshold) {
      corr_temp <- cor(dat2[,"sulfate"], dat2[,"nitrate"])
      corr_vector <- append(corr_vector, corr_temp)
    }
  }
  return(corr_vector)
}