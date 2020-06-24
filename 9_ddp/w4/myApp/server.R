#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table)
library(leaflet)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20 > 0, 0)
    model1 <- lm(hp ~ mpg, data=mtcars)
    model2 <- lm(hp ~ mpgsp + mpg, data=mtcars)
    
    dataProcessing1 <- reactive({
        citiesInput <- input$cities.select
        cols.keep <- c("city_ascii", "lat", "lng", "country", "population")
        dat <- fread("worldcities.csv", select=cols.keep)
        dat$population <- dat$population/1e6
        dat <- dat[order(-population)]
        dat <- dat[1:citiesInput,]
        dat$popup <- paste(dat$city_ascii, "<br> Country:", dat$country,
                           "<br> Population:", as.character(round(dat$population, 3)),
                           "Millions", sep=" ")
        dat
    })
    dataProcessing2 <- reactive({
        countriesList <- input$country
        dat <- dataProcessing1()
        if(length(countriesList) > 0) {
            dat <- subset(dat, country %in% countriesList)
        }
        dat
        
    })
    countryNames <- reactive({
        dat <- dataProcessing1()
        countries <- sort(unique(dat$country))
        countries
    })
    
    cityNumber <- reactive({
        dat <- dataProcessing2()
        num <- nrow(dat)
        num
    })


    output$worldMap <- renderLeaflet({
        dat <- dataProcessing2()
        countries <- countryNames()
        my_map <- leaflet() %>%
            addTiles() %>%
            addMarkers(lat=dat$lat, lng=dat$lng, popup=dat$popup,
                       clusterOptions=markerClusterOptions())
    })
    
    output$countries <- renderText({
        countryNames()
    })
    
    output$cityNumber <- renderText({
        paste(as.character(cityNumber()), as.character(input$cities.select),
              sep=" | ")
    })
    observeEvent(countryNames(), {
        updateSelectInput(session = session, inputId = "country",
                          choices = countryNames())
    })

})
