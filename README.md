<!-- README.md is generated from README.Rmd. Please edit that file -->
pronto
======

pronto is a simple R package for interacting with data from from Seattle's [Pronto](http://www.prontocycleshare.com) cycle sharing system. Data comes from Pronto's simple [data stream](https://secure.prontocycleshare.com/data/stations.json), which is described [here](http://www.prontocycleshare.com/assets/pdf/JSON.pdf).

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

Installation
============

`pronto` is not on [CRAN](http://cran.r-project.org/), but you can use
[devtools](http://cran.r-project.org/web/packages/devtools/index.html) to
install the latest and greatest version. To do so:

``` r
if(!require("devtools")) install.packages("devtools")                       
devtools::install_github("briandconnelly/pronto")
```

Examples
========

Get current station data
------------------------

``` r
library(pronto)

s <- pronto_stations()
```

The result, `s`, is a list containing a `timestamp` for the data, whether or not the system is suspended (`schemeSuspended`), and a data frame containing information about all of the stations (`stations`).

Getting information for a single station
----------------------------------------

Although Pronto's API doesn't support querying a single station, we can easily filter the station data using [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html).

``` r
library(pronto)
library(dplyr)

s <- pronto_stations()

# Get information about the station near Fred Hutch
s_fhcrc <- s$stations %>%
    filter(id == 22)
```

Mapping Available Bikes
-----------------------

Let's make a map of current bike availability across the city using [ggmap](https://github.com/dkahle/ggmap).

``` r
library(pronto)
library(ggplot2)
library(ggmap)

s <- pronto_stations()

map <- get_map(location = c(lon=mean(s$stations$lo), lat=mean(s$stations$la)),
               zoom = 13, maptype = "terrain-lines")
p <- ggmap(map) +
    geom_point(data = s$stations,
               aes(x=lo, y=la, size=ba, color=ba), alpha = 0.6) +
    scale_size_area(guide=FALSE) +
    scale_color_continuous(name = "Bikes\nAvailable") +
    scale_alpha_continuous(guide = FALSE) +
    theme_minimal() +
    theme(axis.text = element_blank()) +
    theme(axis.title = element_blank()) +
    theme(legend.title = element_text(size = rel(0.8))) +
    theme(legend.text = element_text(size = rel(0.6)))
p
```

![](README-ExampleStationMap-1.png)<!-- -->

### An animated version

Let's spice it up. Here, we'll get the station data every 60 seconds for one hour and then create an animated map using [gganimate](https://github.com/dgrtwo/gganimate). *Note: this code will take an hour to run.*

For extra credit, we could show the time stamps in a more friendly format or interpolate the data using [tweenr](https://github.com/thomasp85/tweenr).

``` r
library(pronto)
library(dplyr)
library(ggplot2)
library(ggmap)
library(gganimate)

stationdata <- data.frame()
for (i in seq(60)) {
    s <- pronto_stations()
    s$stations$timestamp <- s$timestamp
    stationdata <- bind_rows(stationdata, s$stations)
    Sys.sleep(60)
}

map <- get_map(location = c(lon=mean(s$stations$lo), lat=mean(s$stations$la)),
               zoom = 13, maptype = "terrain-lines")
p <- ggmap(map) +
    geom_point(data = stationdata,
               aes(x=lo, y=la, size=ba, color=ba, frame = timestamp),
               alpha = 0.6) +
    scale_size_area(guide=FALSE) +
    scale_color_continuous(name = "Bikes\nAvailable") +
    scale_alpha_continuous(guide = FALSE) +
    theme_minimal() +
    theme(axis.text = element_blank()) +
    theme(axis.title = element_blank()) +
    theme(legend.title = element_text(size = rel(0.8))) +
    theme(legend.text = element_text(size = rel(0.6)))
gg_animate(p)
```

Getting information for the nearest station
-------------------------------------------

[fossil](https://cran.r-project.org/web/packages/fossil/index.html)

``` r
library(pronto)
library(fossil)
library(dplyr)
library(magrittr)

here <- list(lo=-122.329, la=47.641)

closest_station <- pronto_stations()$stations %>%
    mutate(dist_km = deg.dist(.$lo, .$la, here$lo, here$la)) %>%
    arrange(dist_km) %>%
    head(n=1)

cat(sprintf("The %s station currently has %d bike(s) available",
            closest_station$s, closest_station$ba))
#> The E Blaine St & Fairview Ave E station currently has 7 bike(s) available

if (closest_station$su) {
    cat("NOTE: Rentals are currently suspended at this station!")
}
```

Disclaimer
==========

Neither this package nor its contributer(s) are affiliated with Pronto.
