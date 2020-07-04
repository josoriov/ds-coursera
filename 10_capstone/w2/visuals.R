# Convert to a single function that return all the ngrams models in a single dataframe

n1 <- readRDS("./data/twitter.freq1.Rda")
n1 <- as.data.frame(n1)
n1 <- n1 %>% tibble::rownames_to_column("ngram") %>% mutate(token="1")
colnames(n1)[1:2] <- c("ngram", "freq")
n1 <- n1 %>% mutate(cumsum=cumsum(freq)/sum(freq))

n2 <- readRDS("./data/twitter.freq2.Rda")
n2 <- as.data.frame(n2)
n2 <- n2 %>% tibble::rownames_to_column("ngram") %>% mutate(token="2")
colnames(n2)[1:2] <- c("ngram", "freq")
n2 <- n2 %>% mutate(cumsum=cumsum(freq)/sum(freq))

comb <- rbind(n1, n2)




