library(ISLR); data(Wage); library(ggplot2); library(caret);
Wage <- subset(Wage, select=-c(logwage))

# Splitting the data
inBuild <- createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
validation <- Wage[-inBuild,]; buildData <- Wage[inBuild,]

inTrain <- createDataPartition(y=buildData$wage, p=0.7, list=FALSE)
training <- buildData[inTrain,]; testing <- buildData[-inTrain,]

# Building the models
mod1 <- train(wage ~ .,method="glm", data=training)
mod2 <- train(wage ~ ., methdo="rf", data=training,
              trControl=trainControl(method="cv"), number=3)

# Predictions
pred1 <- predict(mod1, testing); pred2 <- predict(mod2, testing);
p1 <- qplot(pred1, pred2, colour=wage, data=testing)

# Combining predictors
predDF <- data.frame(pred1, pred2, wage=testing$wage)
combModFit <- train(wage ~ ., method="glm", data=predDF)
combPred <- predict(combModFit, predDF)

# Predicting on the validation data
pred1V <- predict(mod1, validation); pred2V <- predict(mod2, validation);
predVDF <- data.frame(pred1=pred1, pred2=pred2)
combPredV <- predict(combModFit, predVDF)