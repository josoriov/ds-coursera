library(ISLR);library(ggplot2); library(caret);
data(wage)

# Splitting the data
inTrain <- createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
training <-  Wage[inTrain,]
testing <- Wage[-inTrain,]

# Plotting the predictors
p1 <- featurePlot(x=training[,c("age", "education", "jobclass")],
                  y=training$wage, plot="pairs")

# Visualizing relationships
p2 <- qplot(age, wage, color=jobclass, data=training)

# Creating factors
library(Hmisc)
cutWage <- cut2(training$wage, g=3)

# Using factor to create a table
t1 <- table(cutWage, training$jobclass)

# Density plot
p3 <- qplot(wage, colour=education, data=training, geom="density")