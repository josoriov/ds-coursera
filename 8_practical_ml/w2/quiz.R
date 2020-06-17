library(caret)

# 1
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
# Ans
adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]

# 2
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
# Ans
library(Hmisc)
cols <- colnames(training)
subCols <- cols[-9] #all but CompressiveStrength
par(mfrow = c(ceil(length(subCols)/4), 4))
res <- sapply(subCols, function(colName){
    cut <- cut2(training[,colName])
    lab <- paste0("Color index:",colName)
    plot(training$CompressiveStrength, pch=19, col=cut, xlab=lab, ylab="CompressiveStrength")
})


# 3
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
# AnS
par(mfrow = c(1,2))
hist(training$Superplasticizer, breaks = 40)
hist(log(training$Superplasticizer + 1), breaks = 40)


# 4
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
# Ans
IL_Colnames = grep("^IL", colnames(training), value=TRUE,ignore.case=TRUE)
pcaMod <- preProcess(training[,IL_Colnames], method="pca", thresh=0.8)


# 5
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
# Ans
IL_Colnames = grep("^IL", colnames(adData), value=TRUE,ignore.case=TRUE)
trainingIL <- training[, IL_Colnames]; trainingIL$diagnosis <- training$diagnosis
testingIL <- testing[, IL_Colnames]; testingIL$diagnosis <- testing$diagnosis

modFit <- train(diagnosis ~ ., data=trainingIL, method="glm")
modFitPca <- train(diagnosis ~ ., data=trainingIL, method="glm", preProcess="pca")

cm_no_pca <- confusionMatrix(testingIL$diagnosis, predict(modFit, testingIL))
cm_pca <- confusionMatrix(testingIL$diagnosis, predict(modFitPca, testingIL))






