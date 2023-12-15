library(dplyr)
library(duckdb)
# dbinfo$hourly_2020_2022

db = dbase$new()
d = db$read_data()       # first time about 20s, 16s可以读进来所有数据
d <- db$read_data(50246) # 0.6s
# db$close(force=TRUE)
