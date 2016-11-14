
# unzip(zipfile="Coursera-SwiftKey.zip")
setwd("~/Desktop/R Workspace/DataSci MileStone Project/final/en_US")

enTwitter <- readLines("en_US.Twitter.txt")
sampleSize <- 5000
twitter.sample <- enTwitter[rbinom(sampleSize, length(enTwitter),0.5)]
write(twitter.sample,"./twitter.sample.txt")
d <- 'and'
c <- 'and that'
length(enTwitter)
head(enTwitter)
twitter.d <- grep(d,enTwitter)
length(twitter.d)
twitter <- enTwitter[twitter.d]
length(twitter)
head(twitter)

library(tm)
doc.vec <- VectorSource(twitter)
doc.corpus <- Corpus(doc.vec)
summary(doc.corpus)
doc.corpus <- tm_map(doc.corpus, tolower)
doc.corpus <- tm_map(doc.corpus, removePunctuation)
doc.corpus <- tm_map(doc.corpus, removeNumbers)
#doc.corpus <- tm_map(doc.corpus, removeWords,stopwords("english"))
#install.packages("SnowballC")
library(SnowballC)

#doc.corpus <- tm_map(doc.corpus,stemDocument)
doc.corpus <- tm_map(doc.corpus,stripWhitespace)
doc.corpus <- tm_map(doc.corpus,PlainTextDocument)
#inspect(doc.corpus[1])

corpus1 <- gsub("\\s+", " ", gsub("\n|\t", " ", doc.corpus))
corpus1.wrds <- as.vector(unlist(strsplit(strip(corpus1), " ")))
length(corpus1.wrds)
corpus1.Freq <- data.frame(table(corpus1.wrds))
corpus1.Freq$corpus1.wrds  <- as.character(corpus1.Freq$corpus1.wrds)
corpus1.Freq <- corpus1.Freq[order(-corpus1.Freq$Freq), ]
rownames(corpus1.Freq) <- 1:nrow(corpus1.Freq)
key.terms <- corpus1.Freq[corpus1.Freq$Freq>5000, 'corpus1.wrds'] #key words to match on corpus 1
key.terms
hist(corpus1.Freq$Freq[corpus1.Freq$Freq>5000])
summary(corpus1.Freq)

#install.packages("RWeka")a
options(mc.cores=1)
library(RWeka)
BigramTokenizer <- function(x) {RWeka::NGramTokenizer(x,RWeka::Weka_control(min =2, max =2))}
tdm <- TermDocumentMatrix(doc.corpus, control = list(tokenize = BigramTokenizer))
#inspect(tdm[1:3,1:10])
#inspect(tdm[rownames(tdm) == c,1:10])
p <- paste("^",d," ",sep="")
index <- grep(p,rownames(tdm))
temp <- inspect(tdm[index,])
freqMat <- data.frame(apply(temp,1,sum))
words <- rownames(freqMat)[which.max(freqMat[,1])]
wordPred <- gsub(p,'',words)
