# # 1
# x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
# y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
ans <- summary(lm(y ~ x))$coef

# # 2
# ans1 <- summary(lm(y ~ x))$sigma

# 3
data(mtcars)
data(mtcars)
fit <- lm(mpg ~ I(wt - mean(wt)), data = mtcars)
ans <- confint(fit)

# 5
fit <- lm(mpg ~ wt, data = mtcars)
ans <- predict(fit, newdata = data.frame(wt = 3), interval = "prediction")


# # 6
# fit <- lm(mpg ~ wt, data = mtcars)
# ans1 <- confint(fit)[2, ] * 2
# # Or equivalently change the units
# fit <- lm(mpg ~ I(wt * 0.5), data = mtcars)
# ans2 <- confint(fit)[2, ]

# 9
fit1 <- lm(mpg ~ wt, data = mtcars)
fit2 <- lm(mpg ~ wt - 1, data = mtcars)













