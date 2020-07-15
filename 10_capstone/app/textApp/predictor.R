require('data.table')
require('tm')
require('gdata')
require('slam')
require('stringr')
require('R.utils')

# Loading the models
load('./data/startwords.bin')
load('./data/freq1.bin')
freq1 <- freq
load('./data/freq2.bin')
freq2 <- freq
load('./data/freq3.bin')
freq3 <- freq
load('./data/freq4.bin')
freq4 <- freq
load('./data/freq5.bin')
freq5 <- freq
load('./data/freq6.bin')
freq6 <- freq
rm(freq)


# Counts of frequencies used in Good-Turing smooth
counts1 <- c(unique(freq1[order(freq1, decreasing = F)]), max(freq1))
counts2 <- c(unique(freq2[order(freq2, decreasing = F)]), max(freq2))
counts3 <- c(unique(freq3[order(freq3, decreasing = F)]), max(freq3))
counts4 <- c(unique(freq4[order(freq4, decreasing = F)]), max(freq4))
counts5 <- c(unique(freq5[order(freq5, decreasing = F)]), max(freq5))
counts6 <- c(unique(freq6[order(freq6, decreasing = F)]), max(freq6))

# Probability of single n-gram - P(Wi)
singleProb <- function (sentence) {
    # Get last 6 words of sentence
    words <- tail(strsplit(tolower(trim(sentence)), split = ' ')[[1]], 6)
    
    # If there is no words just returns 0
    if (length(words) == 0) return (0)
    
    # Get the correspondent n-gram vector
    ngram_vector <- eval(parse(text = paste("freq", length(words), sep = "")))
    # Paste the words to form a sentence
    textnum <- paste(words[1:length(words)], collapse = " ")
    # Get the frequency of the exact n-gram
    ngram_freq <- ngram_vector[textnum]
    
    # In case the n-gram doesn't exists, ngram_freq is the in ngram frequency
    if (is.na(ngram_freq[[1]])) {
        ngram_freq <- min(ngram_vector)
    }
    
    # Get the correspondent count vector
    count_vector <- eval(parse(text = paste("counts", length(words), sep = "")))
    
    # Get the index in which freq and count corresponds
    ind <- which(count_vector == ngram_freq)[1]
    
    # Calculates the probability of said n-gram
    ngram_prob <- (ngram_freq + 1) * count_vector[ind] / count_vector[ind+1]
    prob <- ngram_prob / sum(ngram_vector)
    return(prob)
}

# Log Joint Probability - P(Wi|Wi-1,Wi-2,...,Wi-n+1)
jointProb <- function (sentence) {
    # Get last 6 words of sentence
    words <- tail(strsplit(tolower(trim(sentence)), split = ' ')[[1]], 6)
    # Initialize prob values
    prob <- 0
    
    for (i in 1:(length(words)-1)) {
        # Paste words according to index
        words_l <- paste(words[i:length(words)], collapse = " ")
        words_s <- paste(words[i:(length(words)-1)], collapse = " ")
        # Sum to the probability value
        prob <- prob + log(singleProb(words_l) / singleProb(words_s))
    }
    return(prob)
}

# Gets suggestion based on n-gram models
createSuggestion <- function(words, N=5){
    # If the word number is higher than 5 just takes 5
    n <- min(length(words), 5)
    suggestion <- character()
    
    # Loop from highest to lowest n-gram models to find words
    for(i in n:1){
        # Get the i-th last words
        last_words <- tail(words, i)
        # Creates a regex to find the words in a n-gram collection
        expression <- paste("^", paste(tolower(trim(last_words)), collapse=" "),
                            "[,; ]", sep="")
        # Import the i+1 n-gram collection
        ngram <- eval(parse(text = paste("freq", (i+1), sep="")))
        # Get the n-gram matching the regex and their frequencies
        ngram <- ngram[grep(expression, names(ngram))]
        # Filter to only N highest words
        ngram <- head(ngram[order(ngram, decreasing = T)], N)
        # Return the term additional word (suggestion)
        ngram <- unlist(lapply(names(ngram), function (sugg) {
            strsplit(sugg, split=" ")[[1]][i+1]
        }))
        
        if (length(ngram) > 0) {suggestion <- unique(c(suggestion, ngram))}
        if (length(suggestion) > N) {return(suggestion[1:N])}
    }
    return(suggestion)
}

# Return a table with the predicted words and the probability
predict <- function(sentence, N=5) {
    sentence <- trim(tolower(sentence))
    
    # If dots, interrogation and exclamation signs assume a new sentence must continue
    if (str_sub(sentence, start= -1) == '.' || str_sub(sentence, start= -1) == "?"||
        str_sub(sentence, start= -1) == "!") {sentence <- ""} 
    
    # Replace commas
    sentence <- gsub(sentence, pattern = "[,]", replacement = "")  
    
    # In case sentence is empty sample 5 of the most 50 frequent starting words
    if (sentence == "") {
        predicted_words <- data.table(Word = capitalize(startwords$Word),
                             prob = log(startwords$Freq / sum(startwords$Freq)))
        predicted_words <- predicted_words[sample(.N, N)]
        return(predicted_words[order(predicted_words$prob, decreasing = T)])
    }
    
    words <- strsplit(sentence, split = " ")[[1]]
    # Use the method to get suggestion words
    predicted_words <- createSuggestion(words, N)
    # If there is no suggestion, returns the most probable unigrams
    if (length(predicted_words) == 0) {
        predicted_words <- names(head(freq1[order(freq1, decreasing = T)], N))
    }
    
    # Get the probability of the suggested words
    predicted_words <- data.table(Word = unlist(predicted_words))
    predicted_words[, prob := jointProb(paste(sentence, Word, sep = " ")), by = Word]
    return(predicted_words[order(predicted_words$prob, decreasing = T)])
}