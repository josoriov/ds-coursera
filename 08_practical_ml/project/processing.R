# Preprocessing
library(dplyr); library(caret); library(corrplot); library(Rmisc)
# Getting the data
set.seed(124879)
training.raw <- read.csv("data/pml-training.csv")
validation <- read.csv("data/pml-testing.csv")

# Remove the columns with a lot of missing values
naRemove <- which(colSums(is.na(training.raw) | training.raw == "")/
                      nrow(training.raw) > 0.15)
training.raw <- training.raw[, -naRemove]
validation <- validation[, -naRemove]

# Removing timestamp since that is not an useful covariate
timeRemove <- grep("timestamp", names(training.raw))
training.raw <- training.raw[,-timeRemove]
validation <- validation[,-timeRemove]
classeLevels <- unique(training.raw$classe)
training.raw$classe <- factor(training.raw$classe, labels=classeLevels)

# Removing X, user_name, new_window columns
training.raw <- select(training.raw, -c("X", "user_name", "new_window"))
validation <- select(validation, -c("X", "user_name", "new_window"))

# Checking to see if an imputer is needed
# sum(colSums(is.na(training)))


# Exploratory analysis

# Splitting the data
inTrain <- createDataPartition(y=training.raw$classe, p=0.7, list=FALSE)
training <- training.raw[inTrain,]
testing <- training.raw[-inTrain,]
outputIndex <- which(names(training) == "classe")


# Search correlations
correlations <- cor(training[,-outputIndex], as.numeric(training$classe))
# 4 Highest correlated variables to classe
highCorr <- subset(as.data.frame(correlations),abs(V1)>0.26)
corrVariables <- row.names(highCorr)
training.4 <- select(training, c("classe", corrVariables))
outputIndex.4 <- which(names(training.4) == "classe")
testing.4 <- select(testing, c("classe", corrVariables))
validation.4 <- select(validation, c("problem_id", corrVariables))

p1 <- ggplot(training.4, aes(classe,pitch_forearm)) +
    geom_boxplot(aes(fill=classe))

p2 <- ggplot(training.4, aes(classe,magnet_arm_y)) +
    geom_boxplot(aes(fill=classe))

p3 <- ggplot(training.4, aes(classe,magnet_arm_x)) +
    geom_boxplot(aes(fill=classe))

p4 <- ggplot(training.4, aes(classe,magnet_belt_y)) +
    geom_boxplot(aes(fill=classe))

multiplot(p1,p2,p3,p4, cols=2)

# Plotting the corr matrix
correlations <- cor(training[, -outputIndex])
corrplot(correlations, method="color", type="lower", order="hclust",
         tl.col="black", tl.srt = 45, diag = FALSE, tl.cex=0.60,
         col=colorRampPalette(c("#80CED7","#63C7B2","#8E6C88","#263D42"))(100))