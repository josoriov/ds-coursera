library(caret)

# 1
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.test$y <- as.factor(vowel.test$y)
vowel.train$y <- as.factor(vowel.train$y)
set.seed(33833)

# Models
modRF <- train(y ~ .,method="rf", data=vowel.train)
modGBM <- train(y ~ ., method="gbm", data=vowel.train, verbose=FALSE)

# Predicting with the models
predRF <- predict(modRF, vowel.test)
confRF <- confusionMatrix(predRF, vowel.test$y)
predGBM <- predict(modGBM, vowel.test)
confGBM <- confusionMatrix(predGBM, vowel.test$y)

agreedIndex <- predRF == predGBM
confAgreed <- confusionMatrix(vowel.test$y[agreedIndex],predRF[agreedIndex])



# 2
library(caret)
library(gbm)
set.seed(3433)

library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)

inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)

# Creating the models
modRF <- train(diagnosis ~ .,method="rf", data=training)
modGBM <- train(diagnosis ~ ., method="gbm", data=training, verbose=FALSE)
modLDA <- train(diagnosis ~ ., method="lda", data=training, verbose=FALSE)

# Calculating predicted values
predRF <- predict(modRF, testing)
predGBM <- predict(modGBM, testing)
predLDA <- predict(modLDA, testing)

# Fitting combined model
combData <- data.frame(predRF, predGBM, predLDA, diagnosis=testing$diagnosis)
modComb <- train(diagnosis ~ ., data=combData, method="rf", verbose=FALSE)
# Combinated model predicted values
predComb <- predict(modComb, combData)
# Confusion matrices
confRF <- confusionMatrix(testing$diagnosis, predRF)
confGBM <- confusionMatrix(testing$diagnosis, predGBM)
confLDA <- confusionMatrix(testing$diagnosis, predLDA)
confComb <- confusionMatrix(testing$diagnosis, predComb)

# 5
set.seed(3523)
library(AppliedPredictiveModeling);library(caret);library(e1071);
library(forecast)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(325)
modSVM <- svm(CompressiveStrength ~ ., data=training)
predSVM <- predict(modSVM, testing)
accSVM <- accuracy(predSVM, testing$CompressiveStrength)


# 3
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
# Fitting the model
set.seed(233)
modLasso <- train(CompressiveStrength ~ ., data=training, method="lasso")
# Plotting the coefficients
plot.enet(modLasso$finalModel,  xvar="penalty", use.color=TRUE)


# 4
library(lubridate) # For year() function below
library(forecast)
dat = read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv"))

training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

# Fitting the model
modBats <- bats(tstrain)
modForecast <- forecast(modBats, level=95, h=nrow(testing))

# Counting the values within the limits
nVal <- sum(testing$visitsTumblr > modForecast$lower &  testing$visitsTumblr < modForecast$upper)
ans <- nVal / nrow(testing) * 100
