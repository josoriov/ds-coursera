filepath <- "../Data/final/en_US/en_US.twitter.txt"

numLines <- function(path) {
    f <- file(path, open="rb")
    nlines <- 0L
    while (length(chunk <- readBin(f, "raw", 65536)) > 0) {
        nlines <- nlines + sum(chunk == as.raw(10L))
    }
    close(f) 
    return(nlines)
}
