#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Most Populous Cities in the World"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("cities.select", "Number of cities to visualize:", 1, 2000,
                        value=1000),
            selectInput("country", "Country:", c("All"), multiple=TRUE),
            submitButton("Refresh")
        ),
        # Show a plot of the generated distribution
        mainPanel(
            h3("Cities in selected countries | Cities selected in slider"),
            textOutput("cityNumber"),
            h3("World Map:"),
            leafletOutput("worldMap")
        )
    )
))
