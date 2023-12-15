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
db_removeTablesLike <- function(con, pattern="dbplyr", del=TRUE) {
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
