#' @export 
edit_db_config <- function() {
  f = normalizePath("~/.db.yml")
  usethis::edit_file(f)
}
