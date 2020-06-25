library(ISLR);library(ggplot2); library(caret); set.seed(12893)
data(Wage); Wage <- subset(Wage, select=-c(logwage))

# Splitting the data
inTrain <- createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
training <-  Wage[inTrain,];testing <- Wage[-inTrain,]

# Fitting a model
modFit <- train(wage ~ age + jobclass + education, method="lm", data=training)
finMod <- modFit$finalModel
# Diagnostic plot
plot(finMod, 1, pch=19, cex=0.5, col="#00000010")

# Plot by non-used vairables
p1 <- qplot(finMod$fitted, finMod$residuals, colour=race, data=training)

# Predicted vs truth
pred <- predict(modFit, testing)
p2 <- qplot(wage, pred, colour=year, data=testing)

# Using all the covariates
modFitAll <- train(wage ~ ., data=training, method="lm")
pred <- predict(modFitAll, testing)
p3 <- qplot(wage, pred, data=testing)