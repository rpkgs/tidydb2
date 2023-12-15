ok <- function(...) {
  cat(green(...), sep = "\n")
}

fprintf <- function(fmt, ...) {
  cat(sprintf(fmt, ...))
}

is_empty <- function(x) {
  is.null(x) || (is.data.frame(x) && nrow(x) == 0) || length(x) == 0
}

`%||%` <- function(x, y) {
  if (is.null(x)) {
    y
  } else {
    x
  }
}

is_duckdb <- function(f) {
  ext <- tools::file_ext(f)
  ext == "duckdb"
}

is_sqlite <- function(f) {
  ext <- tools::file_ext(f)
  ext %in% c("db", "sqlite")
}
