test_that("timeinfo works", {
  info = timeinfo()
  names = c("year", "month", "day", "hour", "timestr", "timenum")
  # expect_true(isTRUE(all.equal(names, colnames(info)))) 
  expect_equal(names, colnames(info))
  expect_true(nrow(info) == 1)
  
  t1 = time_round(make_datetime(2022, 12, 1, 1, 3))
  t2 = time_round(make_datetime(2022, 12, 1, 1))
  expect_equal(t1, t2)
})
