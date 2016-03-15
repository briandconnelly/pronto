#' Check whether a call to the Pronto API was successful
#'
#' \code{pronto_ok} checks whether a call to the pronto API was successful
#'
#' @param req The results of a \code{\link{pronto_GET}} command
#'
#' @return \code{TRUE} when the request succeeded and \code{FALSE} otherwise.
#' @export
#'
#' @examples
#' r <- pronto_GET()
#' pronto_ok(r)
#'
pronto_ok <- function(req) {
    httr::status_code(req) == 200
}
