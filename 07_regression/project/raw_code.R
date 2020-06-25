# Libraries
library(datasets)
library(ggplot2)
library(GGally)
library(MASS)

# Processing
# Extracting the data
data(mtcars)
# Getting all the correlations
corr_list <- cor(mtcars$mpg, mtcars)

# Converting the non-continuous variables to factor
# Converting am
mtcars$am <- as.factor(mtcars$am)
levels(mtcars$am) <- c("Automatic", "Manual")
# Converting vs
mtcars$vs <- as.factor(mtcars$vs)
levels(mtcars$vs) <- c("V-shaped", "Straight")
# Converting cyl
mtcars$cyl <- as.factor(mtcars$cyl)
# Converting gear
mtcars$gear <- as.factor(mtcars$gear)


# Showing info of the data
str(mtcars)

# Visualizing the first rows of data
head(mtcars, 5)

# Exploratory data analysis
# Plotting the relationship between the variables of interest
p1 <- ggplot(mtcars, aes(x=am, y=mpg))
p1 <- p1 + geom_boxplot(aes(fill = am))

# Ordering the correlations and getting the highest-than-am ones
corr_list <- corr_list[,order(-abs(corr_list[1,]))]
ind <- which(names(corr_list) == "am")
corr_var <- names(corr_list)[1:ind]
corr_var

# Figure 2
p2 <- ggpairs(data=mtcars[, corr_var],  mapping = ggplot2::aes(color = am))


# Model selection
# Frist use a basic fit
fit1 <- lm(mpg ~ am, mtcars)
summary(fit1)
# P-values good, R squared bad

# Total model
fit_all <- lm(mpg ~ ., data=mtcars)
# P-values too high, R squared is good

# Calculating the best fit model
fit_best <- stepAIC(fit_all, direction="both",trace=FALSE)
# Low p-values, good R squared

# Plotting residuals
par(mfrow=c(2,2))
p3 <- plot(fit_best)}

# Conclusion
# No abnormal variance
# No high leverage residuals
