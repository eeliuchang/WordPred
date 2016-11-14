# unzip the file, need to install packages of Rutils
unzip(zipfile="Coursera-SwiftKey.zip")
setwd("~/Desktop/R Workspace/DataSci MileStone Project/final/en_US")
# 
# enBlog <- readLines("en_US.blogs.txt")
# enNews <- readLines("en_US.news.txt")
enTwitter <- readLines("en_US.twitter.txt")

# a <- 'I have seen this question answered in other languages but not in R.
# [Specifically for R text mining] I have a set of frequent phrases that is obtained from a Corpus. 
# Now I would like to search for the number of times these phrases have appeared in another corpus.
# Is there a way to do this in TM package? (Or another related package)
# For example, say I have an array of phrases, "tags" obtained from CorpusA. And another Corpus, CorpusB, of 
# couple thousand sub texts. I want to find out how many times each phrase in tags have appeared in CorpusB.
# As always, I appreciate all your help!'



library(tm)
# library(qdap)
# library(R.utils)
# countLines("en_US.blogs.txt")
# countLines("en_US.news.txt")
# countLines("en_US.twitter.txt")

summary(enBlog) #check what went in
a=enBlog
summary(a)
a <- Corpus(VectorSource(a))
a <- tm_map(a, tolower)
a<- tm_map(a, removePunctuation)
a <- tm_map(a, removeNumbers)


corpus1 <- gsub("\\s+", " ", gsub("\n|\t", " ", a[1:20000]))

corpus1.wrds <- as.vector(unlist(strsplit(strip(corpus1), " ")))
length(corpus1.wrds)
corpus1.Freq <- data.frame(table(corpus1.wrds))
corpus1.Freq$corpus1.wrds  <- as.character(corpus1.Freq$corpus1.wrds)
corpus1.Freq <- corpus1.Freq[order(-corpus1.Freq$Freq), ]
rownames(corpus1.Freq) <- 1:nrow(corpus1.Freq)
key.terms <- corpus1.Freq[corpus1.Freq$Freq>5000, 'corpus1.wrds'] #key words to match on corpus 2
key.terms
hist(corpus1.Freq$Freq[corpus1.Freq$Freq>5000])
summary(corpus1.Freq)
