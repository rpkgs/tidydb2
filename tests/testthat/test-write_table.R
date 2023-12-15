test_write_table <- function(f = "hello.db") {
  db <- dbase$new(f)

  db$write_table(mtcars, "mtcars", overwrite = TRUE)
  db$write_table(mtcars, "mtcars", append = TRUE)
  d = db$read_table("mtcars")
  expect_equal(nrow(d), 2 * nrow(mtcars))

  db$close()
  file.remove(f)
}

test_that("write_table works", {  
  test_write_table("hello.db")
  test_write_table("hello.duckdb")
})
