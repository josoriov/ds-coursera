# url_data <- "https://simplemaps.com/data/world-cities"
library(data.table)
library(leaflet)
library(htmlwidgets)
library(htmltools)


cols.keep <- c("city_ascii", "lat", "lng", "country", "population")
dat <- fread("worldcities.csv", select=cols.keep)

dat$population <- dat$population/1e6

dat <- dat[order(-population)]

dat <- dat[1:500,]

dat$popup <- paste(dat$city_ascii, "<br> Country:", dat$country,
                   "<br> Population:", as.character(round(dat$population, 3)),
                   "Millions", sep=" ")

tag.map.title <- tags$style(HTML("
  .leaflet-control.map-title { 
    transform: translate(-50%,20%);
    position: fixed !important;
    left: 50%;
    text-align: center;
    padding-left: 10px; 
    padding-right: 10px; 
    background: rgba(255,255,255,0.75);
    font-weight: bold;
    font-size: 28px;
  }
"))

title <- tags$div(
    tag.map.title, HTML("500 Cities (2020/06/23)")
)  

my_map <- leaflet() %>%
    addTiles() %>%
    addMarkers(lat=dat$lat, lng=dat$lng, popup=dat$popup,
               clusterOptions=markerClusterOptions()) %>%
    addControl(title, position = "topleft", className="map-title")


saveWidget(my_map, file="test.html")