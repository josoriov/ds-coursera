library(caret); library(kernlab); data(spam)
set.seed(32323)

# Splitting the data
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
training <-  spam[inTrain,]
testing <- spam[-inTrain,]

# Variable capitalAve is very skewed
ca_mean <- mean(training$capitalAve)
ca_sd <- sd(training$capitalAve)

# Standardizing
trainCapAve <- training$capitalAve
trainCapAve <- (trainCapAve - mean(trainCapAve))/sd(trainCapAve)
# Same standardization in test set   
testCapAve <- testing$capitalAve
testCapAve <- (testCapAve - mean(trainCapAve))/sd(trainCapAve)

# Using a preprocess object to apply the same transformation
preObj <- preProcess(training[,-58], method=c("center", "scale"))
trainCapAveS <- predict(preObj, training[,-58])$capitalAve
testCapAveS <- predict(preObj, testing[,-58])$capitalAve


# Imputing data
# Making some values NA
training$capAve <- training$capitalAve
selectNA <- rbinom(dim(training)[1], size=1, prob=0.05) == 1
training$capAVe[selectNA] <- NA

# Impute and standardize
preObj <- preProcess(training[,-58], method="knnImpute")
capAve <- predict(preObj, training[,-58])$capAve

# Standardize true values
capAveTruth <- training$capitalAve
capAveTruth <- (capAveTruth - mean(capAveTruth))/sd(capAveTruth)













