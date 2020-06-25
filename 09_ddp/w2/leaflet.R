library(leaflet)

df <- data.frame(lat=runif(20, min=4.71, max=4.73),
                 lng=runif(20, min=74.04, max=74.06))
df$lng <- -1*df$lng
my_map <- leaflet() %>%
    addTiles() %>%
    addMarkers(lat=4.721666, lng=-74.059406, popup="Mi casita") %>%
    addMarkers(lat=df$lat, lng=df$lng, popup=as.character(1:20))
