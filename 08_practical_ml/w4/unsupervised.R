data(iris); library(ggplot2); library(caret);

# Splitting the data
inTrain <- createDataPartition(y=iris$Species, p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]

# K-means clustering
KMeans1 <- kmeans(subset(training, select=-c(Species)), centers=3)
training$clusters <- as.factor(KMeans1$cluster)

# Plotting the results
p1 <- qplot(Petal.Width, Petal.Length, colour=clusters, data=training)

# Comparing results
table(KMeans1$cluster, training$Species)

# Fitting a model
modFit <- train(clusters ~ ., data=subset(training, select=-c(Species)),
                                          method="rpart")
table(predict(modFit, training), training$Species)

# Applying on test set
testClusterPred <- predict(modFit, testing)
table(testClusterPred, testing$Species)
