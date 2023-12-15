library(dplyr)
library(duckdb)
# dbinfo$hourly_2020_2022

db = dbase$new()
d <- db$read_data(site == 50246L) # first time about 20s, 16s可以读进来所有数据
d <- db$read_data(site == 50246L) # 0.6s
# db$close(force=TRUE)

f = "z:/DATA/China/ChinaRunoff_latest/ChinaWater_latest/back_up/ChinaWater_river (20200603H22-20210116H14).db"
db <- dbase$new(f)
db$read_table()
