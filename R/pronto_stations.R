#' Get current information for Pronto stations

#' \code{pronto_stations} returns current information for Pronto Cycle Share
#' stations. The result is a list containing the following fields:
#'
#' \itemize{
#'     \item \code{timestamp} Station information upload timestamp (ms)
#'     \item \code{stations} A data frame containing information for every station in the system
#'     \item \code{schemeSuspended} Whether or not operations are suspended at all stations
#' }
#'
#' @return A list containing information about the state of all Pronto stations
#' @seealso Data format description: \url{http://www.prontocycleshare.com/assets/pdf/JSON.pdf}
#' @export
#'
#' @examples
#' station_info <- pronto_stations()
#'
pronto_stations <- function() {
    pronto_parse(pronto_GET(), simplifyDataFrame = TRUE)
}
