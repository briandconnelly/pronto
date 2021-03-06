% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pronto_parse.R
\name{pronto_parse}
\alias{pronto_parse}
\title{Parse a response from a query to the Pronto API}
\usage{
pronto_parse(req)
}
\arguments{
\item{req}{The results of a \code{\link{pronto_GET}} command}
}
\value{
A list containing information about the state of all Pronto stations
}
\description{
Parse a response from a query to the Pronto API
}
\examples{
r <- pronto_GET()
pronto_parse(r)

}
\seealso{
Data format description: \url{http://www.prontocycleshare.com/assets/pdf/JSON.pdf}
}

