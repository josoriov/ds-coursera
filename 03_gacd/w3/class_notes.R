# Subsetting and sorting
set.seed(13435)
x <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
x <- x[sample(1:5), ]; x$var2[c(1,3)] = NA

x[,1] # First column
x[,"var1"] # var1 column
x[1:2,"var2"] #First and second row of var2 column
#Logicals
x[(x$var1 <= 3 & x$var3 > 11),] # and
x[(x$var1 <= 3 | x$var3 > 15),] # or
# Dealing with missing values
x[which(x$var2 > 8),] # Return indices where condition is met