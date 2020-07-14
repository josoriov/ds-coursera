# Getting relevant stats for all three datasets
blogs.stats <- fileStats(paste(path, blogs, sep=""), 22500)
news.stats <- fileStats(paste(path, news, sep=""), 22500)
twitter.stats <- fileStats(paste(path, twitter, sep=""), 67500)

# Printing important stats
all.stats <- as.data.frame(rbind(blogs.stats, news.stats, twitter.stats))
saveRDS(all.stats, file="./data/all.stats.Rda")
rm(blogs.stats, news.stats, twitter.stats)

# Creating the token models
twitter.lines <- sampleClean(paste(path, twitter, sep=""), 67500)
blogs.lines <- sampleClean(paste(path, blogs, sep=""), 22500)
news.lines <- sampleClean(paste(path, news, sep=""), 22500)
tokenizer(twitter.lines, "twitter")
tokenizer(blogs.lines, "blogs")
tokenizer(news.lines, "news")
rm(blogs.lines, news.lines, twitter.lines)