# library(dbplyr)
# library(DBI)
# library(RMySQL)
# library(crayon)
# library(dplyr)

# library(Ipaper)
# library(data.table)
# library(tidymet)
# library(tidydb) # pak::pkg_install(c("rpkgs/tidydb", "rpkgs/tidymet"))

#' @import DBI dplyr crayon
#' @importMethodsFrom DBI dbSendQuery
#' @importMethodsFrom RMySQL dbSendQuery
setMethod("dbSendQuery", c("MySQLConnection", "character"),
  # import S4 method from RMySQL
  function(conn, statement, ...) {
    RMySQL:::checkValid(conn)

    rsId <- .Call( RMySQL:::RS_MySQL_exec, conn@Id, as.character(statement))
    new("MySQLResult", Id = rsId)
  }
)

#' get_dbInfo
#' 
#' Get DataBase info from `~/.db.yml`. You need to write config first, see 
#' `vignette("database_config")` for details.
#' 
#' @importFrom purrr `%||%`
#' @export
get_dbInfo <- function(name = NULL) {
  config = yaml::read_yaml("~/.db.yml")
  name = name %||% names(config)[1]
  if(name == "all") config else config[[name]]
}

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

#' @export
db_info <- function(con) {
  str(dbGetInfo(con))
}

# copy_to(con, st_met2481)
# `copy_to` not work for mysql
#' @export 
tbl_copy <- function(con, tbl, tbl_name = NULL, overwrite = TRUE, row.names=FALSE, ...) {
  if (is.null(tbl_name)) tbl_name = deparse(substitute(tbl))
  t = system.time({
    DBI::dbWriteTable(con, tbl_name, tbl, 
      overwrite = overwrite, row.names = row.names, ...)
  })
  print(t)

  cmd_encode = sprintf(
    "ALTER TABLE %s CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;", tbl_name)
  DBI::dbExecute(con, cmd_encode)
}

#' @export 
db_append <- function(con, tbl, values) {
  dbWriteTable(con, tbl, values, append = TRUE)
}

#' @export 
dbRemoveTables_like <- function(con, pattern="dbplyr", del=TRUE) {
  tbls_bad = dbListTables(con) %>% .[grep(pattern, .)]
  # print(tbls_bad)  
  if (del) {
    for (tbl_bad in tbls_bad) dbRemoveTable(con, tbl_bad)
  }
  tbls_bad
}


#' @export 
import_table_large <- function(con, df, table, chunksize=1e6) {
  n = nrow(df)
  # chunksize = 1e6
  chunks = ceiling(n/chunksize)
  fprintf("chunks = %d\n", chunks)

  for (i in 1:chunks) {
    fout = sprintf("%s_chunk%02d", table, i)
    ok(fprintf("running %s \n", fout))

    i_beg = (i-1)*chunksize + 1
    i_end = pmin(i*chunksize, n)
    d = df[i_beg:i_end, ]

    t = system.time({
      # if (i == 1) {
        copy_to(con, d, fout, overwrite = TRUE, temporary = FALSE)
      # } else {
      #   copy_to(con, d, table, append = TRUE, temporary = FALSE)
      # }
    })
    print(t)
  }
}