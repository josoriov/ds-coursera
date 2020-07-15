# First part
# Loading libraries
library(ggplot2)
library(datasets)

# setting the seed for reproducibility
set.seed(12893)

# Defining constants
n <- 40
lambda <- 0.3
n_sims <- 1500

# Running the simulations
exp_distributions <- matrix(data=rexp(n*n_sims, lambda), nrow=n_sims)
exp_distributions_means <- data.frame(means=apply(exp_distributions, 1, mean))

# Plotting the distribution
p0 <- ggplot(exp_distributions_means, aes(x=means)) + xlab("Means") + ylab("Density") +
    geom_histogram(aes(y=..density..), fill="#69b3a2", color="#ACB8C3", alpha=0.6) +
    theme_gray()

# Comparing means and variances
# Simulated mean, variance and standard deviation
mean_sim <- mean(exp_distributions_means$means)
var_sim <- var(exp_distributions_means$means)
sd_sim <- sd(exp_distributions_means$means)

# Theoretical mean, variance and standar deviation
mean_teo <- 1/lambda
var_teo <- 1/(lambda^2)
sd_teo <- 1/(lambda*sqrt(n))

# Plotting the distribution with normal approximations
p1 <- ggplot(exp_distributions_means, aes(x=means)) + xlab("Means") + ylab("Density") +
    geom_histogram(aes(y=..density..), fill="#69b3a2", color="#ACB8C3", alpha=0.6) +
    theme_gray() +
    stat_function(fun = dnorm, args = list(mean = mean_sim, sd = sd_sim),
                  color="#564E58", size=1.25) +
    geom_density(aes(y=..density..), color="#F19A3E", size=1.25)


# Second part
data("ToothGrowth")

# Visualizing the data structure
head(ToothGrowth, 5)

# Dims of data
str(ToothGrowth)

# Summary of the data
summary(ToothGrowth)


# Boxplot to visualize data
p2 <- ggplot(data=ToothGrowth, aes(x=supp, y=len)) + facet_grid(.~dose) +
    geom_point() + geom_boxplot(aes(fill=supp)) + ylab("Tooth length") +
    xlab("Supplement") + ggtitle("Tooth growth by dosage (mg) and supplement")

# Splittin data set by dosage
dose_05 <- ToothGrowth$len[ToothGrowth$dose == 0.5]
dose_10 <- ToothGrowth$len[ToothGrowth$dose == 1.0]
dose_20 <- ToothGrowth$len[ToothGrowth$dose == 2.0]

# Splitting data by supplement
supp_oj <- ToothGrowth$len[ToothGrowth$supp == "OJ"]
supp_vc <- ToothGrowth$len[ToothGrowth$supp == "VC"]

# Splitting data by supplement and dosage = 2.0
supp_oj_20 <- ToothGrowth$len[ToothGrowth$supp == "OJ" & ToothGrowth$dose == 2.0]
supp_vc_20 <- ToothGrowth$len[ToothGrowth$supp == "VC" & ToothGrowth$dose == 2.0]

# Testing that the 2mg dosage is more effective than both others
# Testing that dose 1.0 is greater than dose 0.5
t.test(dose_10, dose_05, alternative = "greater", paired = FALSE,
       var.equal = FALSE, conf.level = 0.95)
# Testing that dose 2.0 is greater than dose 1.0
t.test(dose_20, dose_10, alternative = "greater", paired = FALSE,
       var.equal = FALSE, conf.level = 0.95)

# Testing that in general OJ has grater effects than vc
t.test(supp_oj, supp_vc, alternative = "greater", paired = FALSE,
       var.equal = FALSE, conf.level = 0.95)

# Testing that oj 2.0 has similar effects than vc 2.0
t.test(supp_oj_20, supp_vc_20, alternative = "two.sided", paired = FALSE,
       var.equal = FALSE, conf.level = 0.95)