library(caret);data(faithful); set.seed(333);
# Splitting the data
inTrain <- createDataPartition(y=faithful$waiting, p=0.5, list=FALSE)
trainFaith <- faithful[inTrain,];testFaith <- faithful[-inTrain,];

# Fitting a linear model
lm1 <- lm(eruptions ~ waiting, data=trainFaith)
plot(trainFaith$waiting, trainFaith$eruptions, pch=19, col="blue",
     xlab="Waiting", ylab="Eruption")
lines(trainFaith$waiting, lm1$fitted, lwd=3)

# Plotting on train and test set
par(mfrow=c(1,2))
plot(trainFaith$waiting, trainFaith$eruptions, pch=19, col="blue",
     xlab="Waiting", ylab="Eruption")
lines(trainFaith$waiting, predict(lm1), lwd=3)

plot(testFaith$waiting, testFaith$eruptions, pch=19, col="blue",
     xlab="Waiting", ylab="Eruption")
lines(testFaith$waiting, predict(lm1, newdata=testFaith), lwd=3)

# Same fit using caret
modFit <- train(eruptions ~ waiting, data=trainFaith, method="lm")