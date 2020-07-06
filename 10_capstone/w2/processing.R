# Reading the files
path <- "../Data/final/en_US/"

blogs <- "en_US.blogs.txt"
news <- "en_US.news.txt"
twitter <- "en_US.twitter.txt"

# Number of lines of each file
blogs.n <- determine_nlines(paste(path, blogs, sep=""))
news.n <- determine_nlines(paste(path, news, sep=""))
twitter.n <- determine_nlines(paste(path, twitter, sep=""))


# Sampling a fixed number of lines
blogs.lines <- sample_lines(paste(path, blogs, sep=""), 4500)
news.lines <- sample_lines(paste(path, news, sep=""), 4500)
twitter.lines <- sample_lines(paste(path, twitter, sep=""), 13500)


# Removing digits, punctuation and control characters
blogs.lines <- gsub("[[:digit:]]", "", blogs.lines)
blogs.lines <- gsub("[[:punct:]]", "", blogs.lines)
blogs.lines <- gsub("[[:cntrl:]]", "", blogs.lines)

news.lines <- gsub("[[:digit:]]", "", news.lines)
news.lines <- gsub("[[:punct:]]", "", news.lines)
news.lines <- gsub("[[:cntrl:]]", "", news.lines)

twitter.lines <- gsub("[[:digit:]]", "", twitter.lines)
twitter.lines <- gsub("[[:punct:]]", "", twitter.lines)
twitter.lines <- gsub("[[:cntrl:]]", "", twitter.lines)

# Function to count words and lines
countLinesWords = function (data, nlines) {
    words = sum (sapply(gregexpr("\\W+", data), length) + 1)
    lines = length(data)
    avgWords = round(words/lines, 1)
    estWords = round(words*nlines/lines, 0)
    summary = list("words"=words, "lines"=lines, "totalLines"=nlines,
                   "avgWords"=avgWords, "estWords"= estWords)
    return (summary)
}

# Getting relevant stats for all three datasets
blogs.stats <- countLinesWords(blogs.lines, blogs.n)
news.stats <- countLinesWords(news.lines, news.n)
twitter.stats <- countLinesWords(twitter.lines, twitter.n)

# Printing important stats
all.stats <- as.data.frame(rbind(blogs.stats, news.stats, twitter.stats))
saveRDS(all.stats, file="all.stats.Rda")

## Merging all data to one single object
# all.lines <- c(blogs.lines, news.lines, twitter.lines)

# Removing unnecesary elements from workspace
rm(blogs.n, news.n, twitter.n)
rm(blogs.stats, news.stats, twitter.stats)


# Creating the tokens
tokenizer(twitter.lines, "twitter")
tokenizer(blogs.lines, "blogs")
tokenizer(news.lines, "news")
rm(blogs.lines, news.lines, twitter.lines)

