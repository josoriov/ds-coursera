# Getting the % of unigrams needed for 0.85 of text words
n_test <- freqReader(1,-1)

twitter.lines <- n_test[n_test$origin == "twitter",]
news.lines <- n_test[n_test$origin == "news",]
blogs.lines <- n_test[n_test$origin == "blogs",]

twitter.unigrams <- nrow(twitter.lines)
news.unigrams <- nrow(news.lines)
blogs.unigrams <- nrow(blogs.lines)

twitter.lines <- twitter.lines[twitter.lines$cumsum > 0.85,]
news.lines <- news.lines[news.lines$cumsum > 0.85,]
blogs.lines <- blogs.lines[blogs.lines$cumsum > 0.85,]

twitter.90 <- min(twitter.lines$id)
news.90 <- min(news.lines$id)
blogs.90 <- min(blogs.lines$id)

percent <- as.data.frame(list("twitter"=round(100*twitter.90/twitter.unigrams, 2),
                              "blogs"=round(100*blogs.90/blogs.unigrams, 2),
                              "news"=round(100*news.90/news.unigrams, 2)))


# 30 most commons bigrams for each category
n_test <- freqReader(2,30)

twitter.lines <- n_test[n_test$origin == "twitter",]
news.lines <- n_test[n_test$origin == "news",]
blogs.lines <- n_test[n_test$origin == "blogs",]