# # 1
# subject <- c(1,2,3,4,5)
# baseline <- c(140,138,150,148,135)
# week2 <- c(132,135,151,146,130)
# examinations <- data.frame(subject, baseline, week2)
# examinations
# 
# test <- t.test(x = examinations$baseline, y = examinations$week2,
#                alt = "two.sided", paired = TRUE)
# pval <- test$p.value
# ans <- round(pval,3)

# # 2
# n <- 9
# μ <- 1100
# σ <- 30
# quantile = 0.975 # is 95% with 2.5% on both sides of the range
# confidenceInterval = μ + c(-1, 1) * qt(quantile, df=n-1) * σ / sqrt(n)

# # 3
# n <- 4
# x <- 3
# test <- binom.test(x=x, n=n, alt="greater")
# ans <- round(test$p.value,2)

# # 4
# rate <- 1/100
# cases <- 10
# days <- 1787
# test <-  poisson.test(cases, T = days, r = rate, alt="less")
# ans <- round(test$p.value,2)

# # 5
# n_y <- 9 # subjects treated
# n_x <- 9 # subjects placebo
# σ_y <- 1.5# kg/m2 std.dev. treated 
# σ_x <- 1.8# kg/m2 std.dev. placebo 
# μ_y <- -3#  kg/m2 average difference treated
# μ_x <- 1#  kg/m2 average difference placebo
# 
# # calculate pooled standard deviation
# σ_p <- (((n_x - 1) * σ_x^2 + (n_y - 1) * σ_y^2)/(n_x + n_y - 2))
# pval <- pt((μ_y - μ_x) / (σ_p * (1 / n_x + 1 / n_y)^.5), df=n_y + n_x -2)

# # 7
# n <- 100 #subject
# μ <- 0.01# m^3 brain volume loss mean
# σ <- 0.04# m^3 brain volume loss std. dev.
# p <- 0.05 # sign level
# 
# pow <- power.t.test(n=n, delta=μ, sd=σ , sig.level=p, type="one.sample",
#                     alt="one.sided")$power

# 8
μ <- 0.01# m^3 brain volume loss mean
σ <- 0.04# m^3 brain volume loss std. dev.
p <- 0.05 # sign level
pow <- 0.9 #power

n <- power.t.test(power=pow, delta=μ, sd=σ , sig.level=p, type="one.sample",
                  alt="one.sided")$n





