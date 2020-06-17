library(caret); library(kernlab); data(spam)
set.seed(32323)

# Splitting the data
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
training <-  spam[inTrain,]
testing <- spam[-inTrain,]

# k-fold with caret
folds <- createFolds(y=spam$type, k=10, list=TRUE,
                     returnTrain=TRUE)
fold_length <- sapply(folds, length)

# Time slices
tme <- 1:1000
folds2 <- createTimeSlices(y=tme, initialWindow=20, horizon=10)
