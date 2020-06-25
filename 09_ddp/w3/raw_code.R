# url_data <- "https://simplemaps.com/data/world-cities"
library(data.table)
library(plotly)
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

# specify map projection/options
g <- list(
    scope = "world",
    showland = TRUE,
    landcolor = toRGB("grey83"),
    subunitcolor = toRGB("white"),
    countrycolor = toRGB("white"),
    showlakes = TRUE,
    lakecolor = toRGB("white"),
    showsubunits = TRUE,
    showcountries = TRUE
)

# Creating the map
my_map <- plot_geo(dat, lat=~lat, lon=~lng) %>%
    add_markers(text=dat$popup, color=dat$population) %>%
    colorbar(title = "Population in Millions<br>") %>%
    layout(title = '500 Cities', geo=g)
