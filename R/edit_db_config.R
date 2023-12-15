#' @export 
edit_db_config <- function() {
  f = normalizePath("~/.db.yml")
  usethis::edit_file(f)
}

#' get_dbInfo
#'
#' Get DataBase info from `~/.db.yml`. You need to write config first, see
#' `vignette("database_config")` for details.
#'
#' @importFrom purrr `%||%`
#' @export
get_dbInfo <- function(name = NULL) {
  f = normalizePath("~/.db.yml")
  if (file.exists(f)) {
    config <- yaml::read_yaml(f)
    name <- name %||% names(config)[1]
    if (name == "all") config else config[[name]]
  } else {
    message("[warn] write db config first by `edit_db_config()`!")
    NULL
  }
}
