#' Database class for duckdb and sqlite
#'
#' @field db a character string specifying a database name.
#' @field table a character string specifying a table name.
#' @field con a database connection object.
#' @field tbl a `dplyr::tbl` object.
#'
#' @param db a character string specifying a database name.
#' @param table a character string specifying a table name.
#' @param tables a character vector specifying table names.
#'
#' @param ... ignored
#' @param overwrite a logical specifying whether to overwrite an existing table or not. Its default is FALSE.
#' @param append a logical specifying whether to append to an existing table in the DBMS. Its default is FALSE.
#'
#' @import R6
#' @export
dbase <- R6Class("dbase", list(
  db = NULL,
  table = NULL,
  con = NULL,
  tbl = NULL,

  #' @return NULL
  initialize = function(db = NULL, table = NULL, ...) {
    # type <- match.arg(type)
    # self$type <- type
    self$open_db(db, table, ...)
  },

  #' @return NULL
  print = function(...) {
    fun <- \(x) cat(green(x))
    fun(sprintf("[db   ]: %s\n", self$db))
    fun(sprintf("[size ]: %.1f Mb\n", file.size(self$db) / 1e6))

    tables <- DBI::dbListTables(self$con)
    fun(sprintf("[Opened Table]: %s\n", self$table))
    fun(sprintf("[ALL   Tables]: %s\n", paste(tables, collapse = ", ")))
    print(self$tbl)
  },

  #' create a db if not exits
  #' @param ... others to be passed to `duckdb::duckdb` or `RSQLite::SQLite`, or `dbConnect`
  open_db = function(db = NULL, table = NULL, ...) {
    dbinfo <- get_dbInfo("duckdb")[[1]] # 默认是第一个
    if (is.null(db)) db <- dbinfo$db
    self$db <- db

    if (is_duckdb(self$db)) {
      con <- dbConnect(duckdb::duckdb(), dbdir = self$db, ...)
    } else if (is_sqlite(self$db)) {
      con <- dbConnect(RSQLite::SQLite(), self$db, ...)
    }

    self$con <- con
    self$open_table(table) # 可能会报错
  },

  #' @return NULL
  open_table = function(table = NULL) {
    tables = DBI::dbListTables(self$con)
    if (is_empty(tables)) {
      message("[warn] No table in current database!")
      return()
    }

    if (is.null(table)) table <- DBI::dbListTables(self$con)[1]
    self$table <- table
    self$tbl <- tbl(self$con, self$table)
  },

  #' close db
  #' @return NULL
  finalize = function() {
    message("close datadb ...")
    self$close()
  },

  #' close db
  #' @return NULL
  close = function() {
    # if not closed, then close it
    if (dbIsValid(self$con)) DBI::dbDisconnect(self$con, shutdown = TRUE)
    # duckdb::duckdb_shutdown(duckdb())
  },

  #' Read Tables
  #' @return list of `dataframe`
  read_tables = function(tables = NULL) {
    if (is.null(tables)) tables <- DBI::dbListTables(self$con)
    tables %<>% set_names(., .)
    lapply(tables, \(table) collect(tbl(self$con, table)))
  },

  #' Read Table
  #' @return `dataframe`
  read_table = function(table = NULL) {
    if (!is.null(table)) self$open_table(table)
    self$read_data()
  },

  #' @param ... `dplyr::filter` expressions
  #' @param verbose a logical specifying whether to print the time or not.
  read_data = function(..., verbose = TRUE) {
    exprs <- rlang::enquos(...)
    suppressWarnings({
      t <- system.time({
        d <- filter(self$tbl, !!!exprs) |> collect()
      })
      if (verbose) print(t)
      d
    })
  },

  #' Write Table
  #'
  #' @param value `data.frame`
  #' @param name  a character string specifying a table name. SQLite table names
  #' are not case sensitive, e.g., table names ABC and abc are considered equal.
  #' @param ... others to be passed to `dbWriteTable`
  write_table = function(value, name = NULL, overwrite = TRUE, append = FALSE, ...) {
    .name <- deparse(substitute(value))
    name %<>% `%||%`(.name)
    if (append) overwrite <- FALSE

    dbWriteTable(self$con, name, value, overwrite = overwrite, append = append, ...)
  },

  #' Write Tables
  #'
  #' @param values a list of `data.frame`
  #' @param names  a character vector specifying table names.
  #' @param ... others to be passed to `dbWriteTable`
  write_tables = function(values, names = NULL, overwrite = TRUE, append = FALSE, ...) {
    names %<>% `%||%`(names(values))
    for (i in seq_along(values)) {
      self$write_table(values[[i]], names[i], overwrite, append, ...)
    }
  }
))

# 索引问题如何解决？
