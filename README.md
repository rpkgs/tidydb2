
# tidydb2

<!-- badges: start -->

[![R-CMD-check](https://github.com/rpkgs/tidydb2/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rpkgs/tidydb2/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/rpkgs/tidydb2/branch/master/graph/badge.svg)](https://app.codecov.io/gh/rpkgs/tidydb2)
<!-- [![CRAN](http://www.r-pkg.org/badges/version/tidydb2)](https://cran.r-project.org/package=tidydb2) -->
<!-- [![total](http://cranlogs.r-pkg.org/badges/grand-total/tidydb2)](https://www.rpackages.io/package/tidydb2) -->
<!-- [![monthly](http://cranlogs.r-pkg.org/badges/tidydb2)](https://www.rpackages.io/package/tidydb2) -->
<!-- badges: end -->

## Goals

> 更便捷的访问数据库

建立气象数据库，一行命令查询数据。

## TODO

-   [ ] 读取数据的性能测试

-   [ ] 添加写入数据的函数

## Installation

``` r
remotes::install_github("rpkgs/tidydb2")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(tidydb2)
library(dplyr)
# 
# Attaching package: 'dplyr'
# The following objects are masked from 'package:stats':
# 
#     filter, lag
# The following objects are masked from 'package:base':
# 
#     intersect, setdiff, setequal, union
library(Ipaper)
# Loading required package: magrittr
# Registered S3 method overwritten by 'Ipaper':
#   method           from      
#   print.data.table data.table

## hourly气象数据
dbinfo <- get_dbInfo("duckdb")
f <- dbinfo$hourly_2020_2022$db
db <- dbase$new(f)
db
# [db   ]: z:/DATA/China/ChinaMet_hourly_mete2000/data/China_Mete2000_hourly_full_2020-2022_tidy.duckdb
# [size ]: 4133.5 Mb
# [Opened Table]: China_Mete2000_hourly_full_2020-2022
# [ALL   Tables]: China_Mete2000_hourly_full_2020-2022
# # Source:   table<China_Mete2000_hourly_full_2020-2022> [?? x 20]
# # Database: DuckDB v0.9.2 [hydro@Windows 10 x64:R 4.3.2/z:/DATA/China/ChinaMet_hourly_mete2000/data/China_Mete2000_hourly_full_2020-2022_tidy.duckdb]
#    date                 site PRE_1h   PRS PRS_Max PRS_Min PRS_Sea   RHU RHU_Min
#    <dttm>              <int>  <dbl> <dbl>   <dbl>   <dbl>   <dbl> <dbl>   <dbl>
#  1 2020-01-01 00:00:00 45011     NA   NA      NA      NA    1028.    NA      NA
#  2 2020-01-01 00:00:00 50136      0  971.    971.    970.   1032.    68      67
#  3 2020-01-01 00:00:00 50137      0  989.    989.    988.   1030.    70      67
#  4 2020-01-01 00:00:00 50246      0  977.    977.    977.   1027.    53      47
#  5 2020-01-01 00:00:00 50247      0  960.    960.    960.   1032.    68      68
#  6 2020-01-01 00:00:00 50349      0  960.    960.    959.   1027     44      43
#  7 2020-01-01 00:00:00 50353      0  999.    999.    998.   1024.    68      68
#  8 2020-01-01 00:00:00 50425      0  959.    959.    958.   1041.    69      68
#  9 2020-01-01 00:00:00 50431      0  940.    940.    939.   1040.    68      67
# 10 2020-01-01 00:00:00 50434      0  937     937     937.   1039.    67      67
# # ℹ more rows
# # ℹ 11 more variables: TEM <dbl>, TEM_Max <dbl>, TEM_Min <dbl>, tigan <dbl>,
# #   WIN_D_Avg_2mi <dbl>, WIN_D_INST_Max <dbl>, WIN_D_S_Max <dbl>,
# #   WIN_S_Avg_2mi <dbl>, WIN_S_Inst_Max <dbl>, WIN_S_Max <dbl>, windpower <dbl>

site0 = 50246L
date0 <- make_datetime(2022, 1, 1, 0)

# 0.1s可以读回数据, 这里应该是UTC时间
system.time(
  d <- db$tbl |>
    filter(site == site0, date > date0) |>
    select(date, PRS, TEM, RHU, tigan) |>
    collect()
)
#    user  system elapsed 
#    0.64    0.30    3.03

print(d)
# # A tibble: 8,759 × 5
#    date                  PRS   TEM   RHU tigan
#    <dttm>              <dbl> <dbl> <dbl> <dbl>
#  1 2022-01-01 01:00:00  978  -31.1    71 -36.3
#  2 2022-01-01 02:00:00  977. -29.9    70 -35.0
#  3 2022-01-01 03:00:00  976. -28.6    69 -33.6
#  4 2022-01-01 04:00:00  975. -26.6    66 -31.5
#  5 2022-01-01 05:00:00  974. -25.7    63 -30.6
#  6 2022-01-01 06:00:00  973. -24.7    61 -29.5
#  7 2022-01-01 07:00:00  973. -24.4    61 -29.2
#  8 2022-01-01 08:00:00  973. -24.8    63 -29.6
#  9 2022-01-01 09:00:00  972. -25.1    65 -29.9
# 10 2022-01-01 10:00:00  972. -25.2    72 -29.8
# # ℹ 8,749 more rows
db$close()
```
