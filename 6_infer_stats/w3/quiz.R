# 6
n1 <- n2 <- 10
xbar1 <- 3
xbar2 <- 5
s1 <- 0.6
s2 <- 0.68
a <- xbar2 - xbar1 + c(-1, 1) * qnorm(0.95) * sqrt(s1^2/n1 + s2^2/n2)


# # 7
# n1 <- n2 <- 9
# x1 <- -3 ##treated
# x2 <- 1 ##placebo
# s1 <- 1.5 ##treated
# s2 <- 1.8 ##placebo
# s <- sqrt(((n1 - 1) * s1^2 + (n2 - 1) * s2^2)/(n1 + n2 - 2))
# (x1 - x2) + c(-1, 1) * qt(0.95, n1 + n2 - 2) * s * sqrt(1/n1 + 1/n2)