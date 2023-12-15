ok <- function(...) {
  cat(green(...), sep = "\n")
}

fprintf <- function(fmt, ...) {
  cat(sprintf(fmt, ...))
}
