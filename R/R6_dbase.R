#' dbase
#' @import R6
#' @importFrom duckdb duckdb duckdb_shutdown
#' @export
dbase <- R6Class("duckdb_base", list(
  db = NULL,
  table = NULL,
  # type = "duckdb",
  con = NULL,
  tbl = NULL,
  initialize = function(db = NULL, table = NULL) {
    dbinfo <- get_dbInfo("duckdb")[[1]] # 默认是第一个
    if (is.null(db)) db <- dbinfo$db
    self$db <- db

    # type <- match.arg(type)
    # self$type <- type
    type = tools::file_ext(db)
    if (type == "duckdb") {
      self$con <- dbConnect(duckdb::duckdb(), dbdir = self$db, read_only = TRUE)
    } else if (type %in% c("db", "sqlite")) {
      self$con <- dbConnect(RSQLite::SQLite(), self$db)
    }
    self$open_table(table)
  },
  open_table = function(table) {
    if (is.null(table)) table <- DBI::dbListTables(self$con)[1]
    self$table <- table
    self$tbl <- tbl(self$con, self$table)
  },
  print = function(...) {
    fun = \(x) cat(green(x))
    fun(sprintf("[db   ]: %s\n", self$db))
    fun(sprintf("[size ]: %.1f Mb\n", file.size(self$db)/1e6))

    tables = DBI::dbListTables(db$con)
    fun(sprintf("[Opened Table]: %s\n", self$table))
    fun(sprintf("[ALL   Tables]: %s\n", paste(tables, collapse = ", ")))
    print(self$tbl)
  },
  finalize = function() {
    message("close datadb ...")
    self$close(force = TRUE)
  },
  close = function(force = FALSE) {
    # if (!force) {
      DBI::dbDisconnect(self$con, shutdown = TRUE)
    # } else {
    #   duckdb::duckdb_shutdown(duckdb())
    # }
  },

  read_tables = function(tables = NULL) {
    if (is.null(tables)) tables = DBI::dbListTables(db$con)
    tables %<>% set_names(., .)
    lapply(tables, \(table) collect(tbl(self$con, table)))
  },

  read_table = function(table = NULL) {
    if (!is.null(table)) self$open_table(table)
    self$read_data()
  },

  read_data = function(..., verbose = TRUE) {
    exprs <- rlang::enquos(...)

    suppressWarnings({
      t <- system.time({
        d <- filter(self$tbl, !!!exprs) |> collect()
      })
      if (verbose) print(t)
      d
    })
  }
  ## add a write table options
))
