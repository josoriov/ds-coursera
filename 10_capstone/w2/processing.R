# Setting seed fro reproducibility
set.seed(18375)

# Reading the files
path <- "../Data/final/en_US/"

blogs <- "en_US.blogs.txt"
news <- "en_US.news.txt"
twitter <- "en_US.twitter.txt"

# Sample a fixed number of lines and removing special chars
sampleClean <- function (filepath, lines){
    # Sampling lines from filepath
    data.lines <- sample_lines(filepath, lines)
    # Removing digits, punctuation and control characters
    data.lines <- gsub("[[:digit:]]", "", data.lines)
    data.lines <- gsub("[[:punct:]]", "", data.lines)
    data.lines <- gsub("[[:cntrl:]]", "", data.lines)
    
    return(data.lines)
}

# Function to count words and lines given filepath and lines to be extracted
fileStats <- function (filepath, lines) {
    # Getting the line data
    data.lines <-  sampleClean(filepath, lines)
    # Determine the number of lines in file
    nlines <- determine_nlines(filepath)
    # Getting the file size
    size <- file.info(filepath)$size
    
    words = sum (sapply(gregexpr("\\W+", data.lines), length) + 1)
    lines = length(data.lines)
    avgWords = round(words/lines, 1)
    estWords = round(words*nlines/lines, 0)
    summary = list("size"=size, "words"=words, "importedLines"=lines, "totalLines"=nlines,
                   "avgWords"=avgWords, "estWords"= estWords)
    return (summary)
}

# Getting relevant stats for all three datasets
blogs.stats <- fileStats(paste(path, blogs, sep=""), 22500)
news.stats <- fileStats(paste(path, news, sep=""), 22500)
twitter.stats <- fileStats(paste(path, twitter, sep=""), 67500)

# Printing important stats
all.stats <- as.data.frame(rbind(blogs.stats, news.stats, twitter.stats))
saveRDS(all.stats, file="./data/all.stats.Rda")
rm(blogs.stats, news.stats, twitter.stats)

# # Creating the token models
# twitter.lines <- sampleClean(paste(path, twitter, sep=""), 67500)
# blogs.lines <- sampleClean(paste(path, blogs, sep=""), 22500)
# news.lines <- sampleClean(paste(path, news, sep=""), 22500)
# tokenizer(twitter.lines, "twitter")
# tokenizer(blogs.lines, "blogs")
# tokenizer(news.lines, "news")
# rm(blogs.lines, news.lines, twitter.lines)