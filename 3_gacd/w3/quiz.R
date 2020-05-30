# 1
# dat <- read.csv('1.csv')
# agricultureLogical <- (dat$ACR == 3 & dat$AGS == 6)

#125, 238, 262

# 2
# library(jpeg)
# dat <- readJPEG("2.jpg", native = TRUE)

# -15259150 -10575416

# 3
library(dplyr)
a <- read.csv('3_1.csv')
b <- read.csv('3_2.csv')

c <- merge(a, b, by.x="X", by.y="CountryCode")
c$Gross.domestic.product.2012 <- as.numeric(c$Gross.domestic.product.2012)
c <- arrange(c, desc(Gross.domestic.product.2012))

# 4
# high_income <-  filter(c, c$Income.Group == "High income: OECD" 
#                        | c$Income.Group == "High income: nonOECD")
# high_income <- group_by(high_income, Income.Group)
# summarize(high_income, GDP=mean(Gross.domestic.product.2012))
# RTA 32 91

# 5
# RTA 5



