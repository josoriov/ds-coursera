# # 1
# library(MASS)
# data(shuttle)
# ## Creating binomial variables
# shuttle$auto <- 1 * (shuttle$use == "auto")
# shuttle$headwind <- 1 * (shuttle$wind == "head")
# fit <- glm(auto ~ headwind, data = shuttle, family = binomial)
# ans <- exp(coef(fit))

# # 2
# shuttle$auto <- 1 * (shuttle$use == "auto")
# shuttle$headwind <- 1 * (shuttle$wind == "head")
# fit <- glm(auto ~ headwind + magn, data = shuttle, family = binomial)
# ans <- exp(coef(fit))

# # 4
# library(datasets)
# data(InsectSprays)
# fit <- glm(count ~ relevel(spray, "B"), data = InsectSprays, family = poisson)
# ans <- exp(coef(fit))

# 5
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
z <- (x > 0) * x
fit <- lm(y ~ x + z)
ans <- coef(fit)
