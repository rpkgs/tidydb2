#' @import magrittr
#' @importFrom methods new
#' @importFrom utils str
#' 
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL

.onLoad <- function(libname, pkgname) {
  if (getRversion() >= "2.15.1") {
    utils::globalVariables(
      c(".", ".SD", ".N")
    )
  }
}

# library(dbplyr)
# library(DBI)
# library(RMySQL)
# library(crayon)
# library(dplyr)

# library(Ipaper)
# library(data.table)
# library(tidymet)
# library(tidydb2) # pak::pkg_install(c("rpkgs/tidydb2", "rpkgs/tidymet"))
