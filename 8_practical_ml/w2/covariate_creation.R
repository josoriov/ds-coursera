library(ISLR);library(ggplot2); library(caret); library(splines);
data(wage)

# Splitting the data
inTrain <- createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
training <-  Wage[inTrain,]
testing <- Wage[-inTrain,]

# Creating dummy variables
dummies <- dummyVars(wage ~ jobclass, data=training)
head(predict(dummies, newdata=training))

# Removing zero covariates
nsv <- nearZeroVar(training, saveMetrics=TRUE)

# Spline basis
bsBasis <- bs(training$age, df=3)
# Fitting curves with splines
lm1 <- lm(wage ~ bsBasis, data=training)
# plot(training$age, training$wage, pch=19, cex=0.5)
# points(training$age, predict(lm1, newdata=training), col="red", pch=19, cex=0.5)
# Splines on the test set
# predict(bsBasis, age=testing$age)
