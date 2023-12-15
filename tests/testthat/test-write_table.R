test_write_table <- function(f = "hello.db") {
  db <- dbase$new(f)

  db$write_table(mtcars, "mtcars", overwrite = TRUE)
  db$write_table(mtcars, "mtcars", append = TRUE)
  d = db$read_table("mtcars")
  expect_equal(nrow(d), 2 * nrow(mtcars))
  print(db)

  l = list(a = mtcars, b = mtcars)
  db$write_tables(l)

  l2 = db$read_tables()
  expect_equal(names(l2), c("a", "b", "mtcars"))

  on.exit({
    db$close()
    file.remove(f)
  })
}


test_that("write_table works", {
  test_write_table("hello2.db")
  test_write_table("hello.duckdb")
})
