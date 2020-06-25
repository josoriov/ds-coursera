# 1
library(AppliedPredictiveModeling);library(caret); library(rpart);
set.seed(125)
data(segmentationOriginal)

# Splitting the data
inTrain <- createDataPartition(y=segmentationOriginal$Case, list=FALSE)
training <- segmentationOriginal[inTrain,]
testing <- segmentationOriginal[-inTrain,]

# Fitting the model
modFit <- rpart(Class ~ ., data=training)

# Predictions
testA <- segmentationOriginal[0,]
testA[1,c("TotalIntenCh2", "FiberWidthCh1", "PerimStatusCh1")] <- c(23000, 10, 2)
predA <- predict(modFit, testA, type="prob")

testB <- segmentationOriginal[0,]
testB[1,c("TotalIntenCh2", "FiberWidthCh1", "VarIntenCh4")] <- c(50000, 10, 100)
predB <- predict(modFit, newdata=testB, type="prob")

testC <- segmentationOriginal[0,]
testC[1,c("TotalIntenCh2", "FiberWidthCh1", "VarIntenCh4")] <- c(57000, 8, 100)
predC <- predict(modFit, newdata=testC, type="prob")

testD <- segmentationOriginal[0,]
testD[1,c("FiberWidthCh1", "VarIntenCh4","PerimStatusCh1")] <- c(8, 100, 2)
predD <- predict(modFit, newdata=testD, type="prob")



# 3
library(pgmm); library(caret);
data(olive)
olive = olive[,-1]

# Fitting the model
modFit <- train(Area ~ ., method="rpart", data=olive)

# Prediction
pred <- predict(modFit, newdata = as.data.frame(t(colMeans(olive))))


# 4
library(ElemStatLearn);library(caret);
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]
set.seed(13234)

# Model fitting
modFit <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, data=trainSA,
                method="glm", family="binomial")

missClass = function(values,prediction){
    sum(((prediction > 0.5)*1) != values)/length(values)
}

# Predictions
predictTrainSA <- predict(modFit)
missTrain <- missClass(trainSA$chd, predictTrainSA)

predictTestSA <- predict(modFit, testSA)
missTest <- missClass(testSA$chd, predictTestSA)


# 5
library(ElemStatLearn);library(caret);
data(vowel.train)
data(vowel.test)

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)

# Model fitting
modFit <- train(y ~ ., data=vowel.train, method="rf")
res <- predict(modFit,vowel.test)

