library(shiny)
shinyUI(pageWithSidebar(
        headerPanel("Word Prediction"),
        
        sidebarPanel(
               # h2('Word Prediction System'),
                h4('Please enter your text below'),
                # h2('h2 text'),
                # h3('h3 text'),
                #h4('h4 text'),
                textInput(inputId="id1",label="text"),
               
                submitButton('Submit')
        ),
        mainPanel(
                h3('Word Prediction System'),
                ##  code('some code'),
             
                ##h3('I apolygize that this may take 15 seconds'),
                verbatimTextOutput("prediction"),
                p('This is the result')
        )
))



# library(manipulate)
# myHist <- function(mu){
#         library(datasets)
#         data(galton)
#         hist(galton$child,col="blue",breaks=100)
#         lines(c(mu,mu),c(0,150),col="red",lwd=5)
#         mse <- mean((galton$child - mu)^2)
#         text(63,150, paste("mu=", mu))
#         text(63, 140, paste("MSE = ", round(mse,2)))
# }
# manipulate(myHist(mu), mu = slider(62,74, step=0.5))