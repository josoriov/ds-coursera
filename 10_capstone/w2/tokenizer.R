library(LaF)
library(tm)
library(RWeka)
library(data.table)
library(stringr)
library(gdata)
library(slam)
library(NLP)
library(dplyr)

# Make the tokenizer a big function an apply the function on each data not all.lines
tokenizer <- function(linesVector, filename="corpus"){
    #Functions for the creation of NGrams
    BigramTokenizer <- function(x) unlist(lapply(ngrams(words(x), 2), paste,
                                                 collapse = " "), use.names = FALSE)
    TrigramTokenizer <- function(x) unlist(lapply(ngrams(words(x), 3), paste,
                                                  collapse = " "), use.names = FALSE)
    FourgramTokenizer <- function(x) unlist(lapply(ngrams(words(x), 4), paste,
                                                   collapse = " "), use.names = FALSE)
    # Creating a corpus from the data
    vcorpus <- VCorpus(VectorSource(linesVector), readerControl = list(language = "en"))
    
    # TDM processing
    tdm1 = TermDocumentMatrix(vcorpus, control = list(removePunctuation = FALSE,
                                                      wordLengths = c(1, 30), bounds = list(global = c(10,Inf))))
    tdm2 <- TermDocumentMatrix(vcorpus, control = list(removePunctuation = FALSE,
                                                       tokenize = BigramTokenizer, bounds = list(global = c(2,Inf))))
    tdm3 <- TermDocumentMatrix(vcorpus, control = list(removePunctuation = FALSE,
                                                       tokenize = TrigramTokenizer, bounds = list(global = c(2,Inf))))
    tdm4 <- TermDocumentMatrix(vcorpus, control = list(removePunctuation = FALSE,
                                                       tokenize = FourgramTokenizer, bounds = list(global = c(2,Inf))))
    
    #Filter NGrams with text, spaces and the (') symbol
    tdm1 = tdm1[grep('^[a-zA-Z\']+$', tdm1$dimnames$Term), ]
    tdm2 = tdm2[grep('^[a-zA-Z,.?!; \']+$', tdm2$dimnames$Term), ]
    tdm3 = tdm3[grep('^[a-zA-Z,.?!; \']+$', tdm3$dimnames$Term), ]
    tdm4 = tdm4[grep('^[a-zA-Z,.?!; \']+$', tdm4$dimnames$Term), ]
    
    #Aggregate terms by frequency. row_sums from slam
    freq1 = sort(row_sums(tdm1, 2, na.rm=TRUE, FUN = sum), decreasing=TRUE)
    freq2 = sort(row_sums(tdm2, 2, na.rm=TRUE, FUN = sum), decreasing=TRUE)
    freq3 = sort(row_sums(tdm3, 2, na.rm=TRUE, FUN = sum), decreasing=TRUE)
    freq4 = sort(row_sums(tdm4, 2, na.rm=TRUE, FUN = sum), decreasing=TRUE)
    
    
    #Save the NGram frequency data frames
    saveRDS(freq1, file = paste('./data/',filename,'.freq1.Rda', sep=""))
    saveRDS(freq2, file = paste('./data/',filename,'.freq2.Rda', sep=""))
    saveRDS(freq3, file = paste('./data/',filename,'.freq3.Rda', sep=""))
    saveRDS(freq4, file = paste('./data/',filename,'.freq4.Rda', sep=""))
    
    return(paste("Files for",filename,"successfully created in folder", sep=" "))
    
}
    