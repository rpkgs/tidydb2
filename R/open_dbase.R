#' Con database connection
#' 
#' @examples 
#' \dontrun{
#' dbinfo = get_dbInfo() # see which db to read
#' open_mysql()
#' open_mariadb()
#' }
#' 
#' @export 
#' @import DBI
open_mysql <- function(dbname=1, dbinfo=NULL) {
  dbinfo = dbinfo %||% get_dbInfo()
  
  if (is.numeric(dbname)) dbname = dbinfo$dbname[dbname]  
  bold(Ipaper::ok(sprintf("[info] opening db: %s", dbname)))

  dev = RMySQL::MySQL()
  # dev = odbc::odbc()
  # odbc::odbcListDrivers()
  port = 3306
  if (!is.null(dbinfo$port)) port = dbinfo$port

  con <- dbConnect(dev, 
    # driver = "MySQL ODBC 8.1 ANSI Driver",
    host=dbinfo$host, port = port,
    user=dbinfo$user, 
    password=as.character(dbinfo$pwd), 
    dbname = dbname)
  return(con)
}

#' @rdname open_mysql
#' @export 
open_mariadb <- function(dbname=1, dbinfo=NULL) {
  dbinfo = dbinfo %||% get_dbInfo()
  
  if (is.numeric(dbname)) dbname = dbinfo$dbname[dbname]  
  bold(ok(sprintf("[info] opening db: %s", dbname)))

  # dev = odbc::odbc()
  # odbc::odbcListDrivers()
  dev = RMariaDB::MariaDB()
  port = 3306
  if (!is.null(dbinfo$port)) port = dbinfo$port

  con <- dbConnect(dev, 
    load_data_local_infile = TRUE,
    host=dbinfo$host, port = port,
    user=dbinfo$user, 
    password=as.character(dbinfo$pwd), 
    database = dbname, 
    dbname = dbname)
  
  str(dbGetInfo(con))
  return(con)
}
