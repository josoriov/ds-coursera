library(ISLR); data(Wage); library(ggplot2); library(caret);
Wage <- subset(Wage, select=-c(logwage))

# Splitting the data
inTrain <- createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
training <- Wage[inTrain,]; testing <- Wage[-inTrain,]

# Fit the model
modFit <- train(wage ~ ., method="gbm", data=training, verbose=FALSE)

# Plotting the results
p1 <- qplot(wage, predict(modFit, testing), colour=jobclass, data=testing,
            ylab="Prediction")