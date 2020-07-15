#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(gdata)
source('predictor.R')

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    predictWords <- reactive({
        sentence <- input$textSubmit
        words <- predict(sentence=sentence)$Word
        words
    })
    
    currentText <- reactive({
        current <- trim(input$textSubmit)
        current
    })
    
    selectedWord <- reactive({
        word <- input$wordSelector
        word
    })
    
    observeEvent(predictWords(), {
        updateSelectInput(session=session, inputId="wordSelector",
                          choices=predictWords(), selected=NULL)
    })
    
    observeEvent(selectedWord(), {
        updateTextInput(session=session, inputId="textSubmit",
                        value=paste(currentText(), selectedWord(), sep=" "))
        
        output$fullText <- renderText({
            paste(currentText(), selectedWord(), sep=" ")
        }) 
    })

})
