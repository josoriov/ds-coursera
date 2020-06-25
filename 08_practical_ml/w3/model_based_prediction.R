data(iris); library(ggplot2); library(caret);

# Splitting the data
inTrain <- createDataPartition(y=iris$Species, p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]

# Building and LDA and Navie Bayes model
modlda <- train(Species ~ ., data=training, method="lda")
modnb <- train(Species ~ ., data=training, method="nb")
plda <- predict(modlda, newdata=testing)
pnb <- predict(modnb, newdata=testing)
table(plda, pnb)

# Comparison of the results
equalPredictions <- (plda==pnb)
p1 <- qplot(Petal.Width, Sepal.Width, colour=equalPredictions, data=testing)
