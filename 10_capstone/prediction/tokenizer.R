library(LaF)
library(tm)
library(RWeka)
library(data.table)
library(stringr)
library(gdata)
library(slam)
library(NLP)

# Reading the files
path <- "../Data/final/en_US/"

blogs <- "en_US.blogs.txt"
news <- "en_US.news.txt"
twitter <- "en_US.twitter.txt"

# Create the ngram indicated in the parameter given a lines vector
tokenizer <- function(linesVector, ngram=1, filename=""){
    vcorpus <- VCorpus(VectorSource(linesVector), readerControl = list(language = "en"))
    tdm <- NA
    if (ngram > 1){
        ngramTokenizer <- function(x) unlist(lapply(ngrams(words(x), ngram), paste,
                                                     collapse = " "), use.names = FALSE)
        tdm <- TermDocumentMatrix(vcorpus, control = list(removePunctuation = FALSE,
                                                           tokenize = ngramTokenizer, bounds = list(global = c(2,Inf))))
        tdm <- tdm[grep('^[a-zA-Z,.?!; \']+$', tdm$dimnames$Term), ]
    } else {
        tdm <- TermDocumentMatrix(vcorpus, control = list(removePunctuation = FALSE,
                                wordLengths = c(1, 30), bounds = list(global = c(10,Inf))))
        tdm <- tdm[grep('^[a-zA-Z\']+$', tdm$dimnames$Term), ]
    }
    
    freq <- sort(row_sums(tdm, 2, na.rm=TRUE, FUN = sum), decreasing=TRUE)
    
    save(freq, file = paste('./data/freq',ngram,filename,'.bin', sep=""))
    
    print(paste("The ngram =", ngram, "was successfully created", sep=" "))
    
}

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
