#' Con database connection
#'
#' @examples
#' \dontrun{
#' dbinfo <- get_dbInfo() # see which db to read
#' open_mysql()
#' open_mariadb()
#' }
#'
#' @export
#' @import DBI
open_mysql <- function(dbname = 1, dbinfo = NULL) {
  dbinfo <- dbinfo %||% get_dbInfo()

  if (is.numeric(dbname)) dbname <- dbinfo$dbname[dbname]
  bold(Ipaper::ok(sprintf("[info] opening db: %s", dbname)))

  dev <- RMySQL::MySQL()
  # dev = odbc::odbc()
  # odbc::odbcListDrivers()
  port <- 3306
  if (!is.null(dbinfo$port)) port <- dbinfo$port

  con <- dbConnect(dev,
    # driver = "MySQL ODBC 8.1 ANSI Driver",
    host = dbinfo$host, port = port,
    user = dbinfo$user,
    password = as.character(dbinfo$pwd),
    dbname = dbname
  )
  return(con)
}


#' @import DBI dplyr crayon
#' @importMethodsFrom DBI dbSendQuery
#' @importMethodsFrom RMySQL dbSendQuery
setMethod(
  "dbSendQuery", c("MySQLConnection", "character"),
  # import S4 method from RMySQL
  function(conn, statement, ...) {
    RMySQL:::checkValid(conn)

    rsId <- .Call(RMySQL:::RS_MySQL_exec, conn@Id, as.character(statement))
    new("MySQLResult", Id = rsId)
  }
)
