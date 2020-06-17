data(iris); library(ggplot2); library(caret); library(rattle)

# Splitting the data
inTrain <- createDataPartition(y=iris$Species, p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]

# Plot 1
p1 <- qplot(Petal.Width, Sepal.Width, colour=Species, data=training)

# Fitting the model with a decision tree1
modFit <- train(Species ~ ., method="rpart", data=training)
# Nice looking dendrogram
fancyRpartPlot(modFit$finalModel, sub="")

# Predicting
predict(modFit, newdata=testing)