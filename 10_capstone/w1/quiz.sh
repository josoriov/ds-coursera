# 1. File size
ls -alh

# 2. Line number
wc -l en_US.twitter.txt

# 3. Longest line in txt files
wc -L *.txt

# 4. Occurences of love and hate
grep "love" en_US.twitter.txt | wc -l
grep "hate" en_US.twitter.txt | wc -l

# 5. Finding the tweet
grep -anr "biostats" en_US.twitter.txt

# 6. Number of lines with phrase
grep -ai "A computer once beat me at chess, but it was no match for me at kickboxing" en_US.twitter.txt | wc -l
