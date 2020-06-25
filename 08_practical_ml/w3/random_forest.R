data(iris); library(ggplot2); library(caret); library(rattle)

# Splitting the data
inTrain <- createDataPartition(y=iris$Species, p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]

# Fitting the random forest1
modFit <- train(Species ~ ., data=training, method="rf", prox=TRUE)

# Getting a single tree
getTree(modFit$finalModel)

# Class centers
irisP <- classCenter(training[, c(3,4)], training$Species, modFit$finalModel$prox)
irisP <- as.data.frame(irisP); irisP$Species <-  rownames(irisP)
p1 <- qplot(Petal.Width, Petal.Length, col=Species, data=training)inte
p1 <- p1 + geom_point(aes(x=Petal.Width, y=Petal.Length, col=Species),
                      size=5, shape=4, data=irisP)

# Predicting new values
pred <- predict(modFit, testing)
testing$predRight <- pred==testing$Species

table(pred, testing$Species)

# Visualizing the predictions
p2 <- qplot(Petal.Width, Petal.Length, colour=predRight, data=testing,
            main="Newdata predictions")