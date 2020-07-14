set.seed(12873)
twitter.lines <- sampleClean(paste(path, twitter, sep=""), 25000)
blogs.lines <- sampleClean(paste(path, blogs, sep=""), 250000)
news.lines <- sampleClean(paste(path, news, sep=""), 25000)
rm(blogs, news, twitter, path)
all.lines <- c(twitter.lines, blogs.lines, news.lines)
rm(twitter.lines, blogs.lines, news.lines)

# Top 50 Startwords
startwords <- unlist(lapply(all.lines, function (word) {
    strsplit(word, split=" ")[[1]][1]
    }))
startwords <- data.table(Word = startwords, Freq = 1)
startwords <- startwords[,lapply(.SD, sum), by = Word]
startwords <- startwords[order(-Freq)]
startwords <- startwords[grep("^[a-zA-Z']+$", startwords$Word)]
startwords <- head(startwords, 25)
save(startwords, file = "./data/startwords.bin")
# tokenizer(linesVector=all.lines, ngram=1, filename="")
# rm(all.lines)
