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

Plotting system information
---------------------------

Let's make a map of current bike availability across the city using [ggmap](https://github.com/dkahle/ggmap).

*coming soon!*

Disclaimer
==========

Neither this package nor its contributer(s) are affiliated with Pronto.
