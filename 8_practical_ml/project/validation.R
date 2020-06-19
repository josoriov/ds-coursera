# Validation RF
valRF4 <- predict(modRF4, validation.4)
valRF4.pca <- predict(modRF4.pca, validation.4.pca)
valRFAll <- predict(modRFAll, validation)
valRFAll.pca <- predict(modRFAll.pca, validation.pca)
# Validation GBM
valGBM4 <- predict(modGBM4, validation.4)
valGBM4.pca <- predict(modGBM4.pca, validation.4.pca)
valGBMAll <- predict(modGBMAll, validation)
valGBMAll.pca <- predict(modGBMAll.pca, validation.pca)

# Showing all the preiction from the different models
predictions <- data.frame(RF4=valRF4, RF4.pca=valRF4.pca, RFAll=valRFAll,
                          RFAll.pca=valRFAll.pca, GBM4=valGBM4, GBM4.pca=valGBM4.pca,
                          GBMAll=valGBMAll, GBMAll.pca=valGBMAll.pca)

# Showing the different accuracies
accuracies <- c(confRF4$overall[[1]], confRF4.pca$overall[[1]],
                           confRFAll$overall[[1]], confRFAll.pca$overall[[1]],
                           confGBM4$overall[[1]], confGBM4.pca$overall[[1]],
                           confGBMAll$overall[[1]], confGBMAll.pca$overall[[1]])

accuracies <- data.frame(accuracies)
row.names(accuracies) <- c("RF4", "RF4.pca", "RFAll", "RFAll.pca",
                           "GBM4", "GBM4.pca", "GBMAll", "GBMAll.pca")


