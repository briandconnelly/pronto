#' Parse a response from a query to the Pronto API
#'
#' @param req The results of a \code{\link{pronto_GET}} command
#'
#' @return A list containing information about the state of all Pronto stations
#' @seealso Data format description: \url{http://www.prontocycleshare.com/assets/pdf/JSON.pdf}
#' @export
#'
#' @examples
#' r <- pronto_GET()
#' pronto_parse(r)
#'
pronto_parse <- function(req) {
    if (httr::status_code(req) != 200) {
        stop("HTTP failure: ", req$status_code, "\n", call. = FALSE)
    }

    text <- httr::content(req, as = "text")
    if (identical(text, "")) stop("No output to parse", call. = FALSE)
    jsonlite::fromJSON(text, simplifyVector = FALSE)
}
