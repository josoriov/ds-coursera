#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(gdata)
source('predictor.R')

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Predictive Text APP"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h2("Instructions"),
            p("On the main panel you could find a text input based on a model using n-grams from the HC Corpora."),
            p("Use your mouse or the arrows to select the next word you would like to use, as you type new suggestions will appear")
        ),
        # Show a plot of the generated distribution
        mainPanel(
            textInput("textSubmit", "Write your text here", value = "",
                      width = NULL),
            selectizeInput(
                'wordSelector', 'Predicted next words', choices=startwords$Word[1:5],
                options = list(
                    placeholder = 'Please select an option below',
                    onInitialize = I('function() { this.setValue(""); }')
                )
            ),
            
            h2("Your current full text is:"),
            h3(textOutput("fullText"))
        )
    )
))
