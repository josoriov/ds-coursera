library(caret); library(kernlab); data(spam)
# Splitting the data
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
training <-  spam[inTrain,]
testing <- spam[-inTrain,]

# Fit a model
set.seed(32343)
modelFit <- train(type ~ ., data=training, method="glm")

# Predicting
predictions <- predict(modelFit, newdata=testing)

# Confusion matrix
conf_matrix <- confusionMatrix(predictions, testing$type)