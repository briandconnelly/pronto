<!-- README.md is generated from README.Rmd. Please edit that file -->
pronto
======

pronto is a simple R package for interacting with data from from Seattle's [Pronto](http://www.prontocycleshare.com) cycle sharing system.

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

stations <- pronto_stations()
#> No encoding supplied: defaulting to UTF-8.
```

Mapping Available Bikes
-----------------------

Let's make a map of current bike availability across the city using [ggmap](https://github.com/dkahle/ggmap).

``` r
library(pronto)
library(ggplot2)
library(ggmap)

s <- pronto_stations()
#> No encoding supplied: defaulting to UTF-8.

map <- get_googlemap("seattle", zoom = 12, color = "bw", maptype = "roadmap")
#> Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=seattle&zoom=12&size=640x640&scale=2&maptype=roadmap&sensor=false
#> Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=seattle&sensor=false
p <- ggmap(map) +
    geom_point(data=s$stations, aes(x=lo, y=la, size=ba, color=ba), alpha=0.6) +
    scale_size_area(guide=FALSE) +
    scale_color_continuous(name = "Bikes Available") +
    theme_minimal() +
    theme(axis.text = element_blank()) +
    theme(axis.title = element_blank()) +
    theme(legend.title = element_text(size = rel(0.8))) +
    theme(legend.text = element_text(size = rel(0.6)))
p
```

![](README-ExampleStationMap-1.png)<!-- -->

Disclaimer
==========

Neither this package nor its contributer(s) are affiliated with Pronto.
