# Modellling
# my_model <- readRDS("model.rds")

control <- trainControl(verboseIter = TRUE)
# Model using 4 best correlations
# modRF4 <- train(classe ~ ., method="rf", data=training.4, trControl=control,
#                 ntree=100, verbose=T, keep.forest=T)
# modGBM4 <- train(classe ~ ., method="gbm", data=training.4, verbose=TRUE)
# Model with all
# modRFAll <- train(classe ~ .,method="rf", data=training, trControl=control,
#                   ntree=100, verbose=T, keep.forest=T)
# modGBMAll <- train(classe ~ ., method="gbm", data=training, verbose=TRUE)

# Evaluationg non-pca models
modRF4 <- readRDS("models/modRF4.rds")
modGBM4 <- readRDS("models/modGBM4.rds")
predRF4 <- predict(modRF4, testing)
confRF4 <- confusionMatrix(predRF4, testing.4$classe)
predGBM4 <- predict(modGBM4, testing)
confGBM4 <- confusionMatrix(predGBM4, testing.4$classe)

modRFAll <- readRDS("models/modRFAll.rds")
modGBMAll <- readRDS("models/modGBMAll.rds")
predRFAll <- predict(modRFAll, testing)
confRFAll <- confusionMatrix(predRFAll, testing$classe)
predGBMAll <- predict(modGBMAll, testing)
confGBMAll <- confusionMatrix(predGBMAll, testing$classe)



# Model using pca
pcaPreProcess <- preProcess(training[, -outputIndex], method = "pca",
                            thresh = 0.80)

pcaPreProcess.4 <- preProcess(training.4[, -outputIndex.4], method = "pca",
                              thresh = 0.80)

# PCA 4
training.4.pca <- predict(pcaPreProcess.4, training.4[, -outputIndex.4])
training.4.pca<- cbind(classe=training.4$classe, training.4.pca)
testing.4.pca <- predict(pcaPreProcess.4, testing.4[, -outputIndex.4])
testing.4.pca <- cbind(classe=testing$classe, testing.4.pca)
validation.4.pca <- predict(pcaPreProcess.4, validation.4[, -outputIndex.4])
validation.4.pca <- cbind(problem_id=validation.4$problem_id, validation.4.pca)
# PCA All
training.pca <- predict(pcaPreProcess, training[, -outputIndex])
training.pca <- cbind(training.pca, classe=training$classe)
testing.pca <- predict(pcaPreProcess, testing[, -outputIndex])
testing.pca <- cbind(testing.pca, classe=testing$classe)
validation.pca <- predict(pcaPreProcess, validation[, -outputIndex])
validation.pca <- cbind(validation.pca, problem_id=validation$problem_id)


# Model using 4 best correlations after PCA
# modRF4.pca <- train(classe ~ ., method="rf", data=training.4.pca,
#                     trControl=control, ntree=100, verbose=T, keep.forest=T)
# modGBM4.pca <- train(classe ~ ., method="gbm", data=training.4.pca,
#                      verbose=TRUE)
# Model with all after PCA
# modRFAll.pca <- train(classe ~ .,method="rf", data=training.pca,
#                       trControl=control, ntree=100, verbose=T, keep.forest=T)
# modGBMAll.pca <- train(classe ~ ., method="gbm", data=training.pca,
#                        verbose=TRUE)

# Evaluationg the pca models
modRF4.pca <- readRDS("models/modRF4.pca.rds")
modGBM4.pca <- readRDS("models/modGBM4.pca.rds")
predRF4.pca <- predict(modRF4.pca, testing.4.pca)
confRF4.pca <- confusionMatrix(predRF4.pca, testing.4.pca$classe)
predGBM4.pca <- predict(modGBM4.pca, testing.4.pca)
confGBM4.pca <- confusionMatrix(predGBM4.pca, testing.4.pca$classe)

modRFAll.pca <- readRDS("models/modRFAll.pca.rds")
modGBMAll.pca <- readRDS("models/modGBMAll.pca.rds")
predRFAll.pca <- predict(modRFAll.pca, testing.pca)
confRFAll.pca <- confusionMatrix(predRFAll.pca, testing.pca$classe)
predGBMAll.pca <- predict(modGBMAll.pca, testing.pca)
confGBMAll.pca <- confusionMatrix(predGBMAll.pca, testing.pca$classe)
