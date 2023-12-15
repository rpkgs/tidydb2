#' @import R6
#' @importFrom duckdb duckdb duckdb_shutdown
#' @export
dbase <- R6Class("duckdb_base", list(
  db = NULL,
  table = NULL,
  type = "duckdb",
  con = NULL,
  tbl = NULL,
  initialize = function(db = NULL, table = NULL, type = c("duckdb", "sqlite")) {
    dbinfo <- get_dbInfo("duckdb")[[1]] # 默认是第一个
    if (is.null(db)) db <- dbinfo$db
    self$db <- db

    # 从文件后缀能够猜出变量类型
    type <- match.arg(type)
    self$type <- type

    if (type == "duckdb") {
      self$con <- dbConnect(duckdb(), dbdir = self$db, read_only = TRUE)
    } else if (type == "sqlite") {
      self$con <- dbConnect(duckdb(), dbdir = self$db, read_only = TRUE)
    }

    if (is.null(table)) table <- dbinfo$table[1] %||% DBI::dbListTables(self$con)[1]
    self$table <- table
    self$tbl <- tbl(self$con, self$table)
  },
  print = function(...) {
    cat(sprintf("db   : %s\n", self$db))
    cat(sprintf("table: %s\n", self$table))
    print(self$tbl)
  },
  finalize = function() {
    message("close datadb ...")
    self$close(force = TRUE)
  },
  close = function(force = FALSE) {
    if (!force) {
      DBI::dbDisconnect(self$con, shutdown = TRUE)
    } else {
      duckdb::duckdb_shutdown(duckdb())
    }
  },
  read_data = function(site_id = 50349L, verbose = TRUE) {
    suppressWarnings({
      t <- system.time({
        d <- self$tbl |>
          filter(site == site_id) |>
          collect()
      })
      if (verbose) print(t)
      d
    })
  }
  ## add a write table options
))
