# Libraries
library(datasets)
library(car)
data("mtcars")

# # 1
# fit <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
# summary(fit)$coef

# 2
# fit2 <- lm(mpg ~ cyl - 1, mtcars)
# ans <- rbind(summary(fit)$coef[1:3,1],summary(fit2)$coef[,1])

# # 3
# fit1 <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
# fit2 <- lm(mpg ~ factor(cyl) * wt, data = mtcars)
# summ1 <- summary(fit1)$coef
# summ2 <- summary(fit2)$coef
# ans <- anova(fit1, fit2)

# # 4
# fit <- lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)

# # 5
# x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
# y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
# ans <- influence(lm(y ~ x))$hat

# # 6
# x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
# y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
# ans <- influence.measures(lm(y ~ x))