n1 <- freqReader(1, 500)
n2 <- freqReader(2, 1000)
n3 <- freqReader(3, 3000)
n4 <- freqReader(4, 800)

# Plots to visualize the data
p1 <- ggplot(data=n1, aes(x=id, y=cumsum, color=origin)) + facet_grid(origin~.) +
    geom_point(aes(alpha=0.5), show.legend=F) + xlab("N-most frequent unigrams") +
    ylab("Precent of total of unigrams") + ggtitle("Unigrams")

p2 <- ggplot(data=n2, aes(x=id, y=cumsum, color=origin)) + facet_grid(origin~.) +
    geom_point(aes(alpha=0.5), show.legend=F) + xlab("N-most frequent unigrams") +
    ylab("Precent of total of unigrams") + ggtitle("Bigrams")

p3 <- ggplot(data=n3, aes(x=id, y=cumsum, color=origin)) + facet_grid(origin~.) +
    geom_point(aes(alpha=0.5), show.legend=F) + xlab("N-most frequent unigrams") +
    ylab("Precent of total of unigrams") + ggtitle("Trigrams")

p4 <- ggplot(data=n4, aes(x=id, y=cumsum, color=origin)) + facet_grid(origin~.) +
    geom_point(aes(alpha=0.5), show.legend=F) + xlab("N-most frequent unigrams") +
    ylab("Precent of total of unigrams") + ggtitle("Fourgrams")

# multiplot(p1, p2, p3, p4, cols=2)