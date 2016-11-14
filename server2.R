library(shiny)

## My prediction algorithm
wordPred <- function(d)
{       
        enTwitter <- readLines("twitter.sample.txt")
        
        #d <- 'and'
        #c <- 'and that'
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
        #inspect(doc.corpus[1])
        
        #install.packages("RWeka")
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
        
        
}



shinyServer(
        function(input, output)
        {
                output$oid1 <- renderPrint({input$id1})
                  
                output$prediction <- renderPrint({wordPred(input$id1)})
               
        }
)