#' GET information using the Pronto API
#'
#' \code{pronto_GET} issues queries to the Pronto API. At the moment, only
#' station data can be retrieved.
#'
#' @seealso Data stream: \url{https://secure.prontocycleshare.com/data/stations.json}
#' @return A list containing the response to the API call
#' @export
#'
#' @examples
#' raw <- pronto_GET()
#'
pronto_GET <- function() {
    httr::GET(url = "https://secure.prontocycleshare.com/data/stations.json")
}
