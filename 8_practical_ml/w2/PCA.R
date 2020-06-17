library(caret); library(kernlab); data(spam)
set.seed(32323)

# Splitting the data
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
training <-  spam[inTrain,]
testing <- spam[-inTrain,]

# Correlated predictors
M <- abs(cor(training[,-58]))
diag(M) <- 0

# Principal components analysis
smallSpam <- spam[,c(34,32)]
prComp <- prcomp(smallSpam)
# plot(prComp$x[,1], prComp$x[,2])

# PCA on all data
typeColor <- ((spam$type=="spam")*1 + 1)
prComp <- prcomp(log10(spam[,-58]+1))
plot(prComp$x[,1], prComp$x[,2], col=typeColor, xlab="PC1", ylab="PC2")

# PCA with caret
preProc <- preProcess(log10(spam[,-58]+1), method="pca", pcaComp=2)
spamPC <- predict(preProc, log10(spam[,-58]+1))
# Model fit a PCA component
trainPC <- predict(preProc, log10(training[,-58]+1))
modalFit <- train(training$type ~ ., method="glm", data=trainPC)