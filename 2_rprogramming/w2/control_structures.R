# Control structures
# For loop example
x <- c("a", "b", "c", "d")
for(i in seq_along(x)){
  print(x[i])
}
# While loop
count <- 0
while(count<10) {
  print(count)
  count <- count + 1
}
