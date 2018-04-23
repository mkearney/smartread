
<!-- README.md is generated from README.Rmd. Please edit that file -->
smartread
=========

The goal of smartread is to provide a single function API for reading in data from common file types.

Installation
------------

You can install the development version of **{smartread}** from [Github](https://github.com/mkearney/smartread) with:

``` r
## install from github
devtools::install_github("mkearney/smartread")
```

Example
-------

This is a basic example which shows you how to use `read_smart()`

``` r
## basic example dat
exdat <- datasets::mtcars

## save as multiple different file types
saveRDS(exdat, "exdat.rds")
save(exdat, file = "exdat.rda")
write.csv(exdat, "exdat.csv")

## now read and view the .rds file
head(c1 <- read_smart("exdat.rds"))
#>                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#> Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

## now read and view the .csv file
head(c2 <- read_smart("exdat.csv"))
#> Warning: Missing column names filled in: 'X1' [1]
#> # A tibble: 6 x 12
#>   X1       mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
#>   <chr>  <dbl> <int> <dbl> <int> <dbl> <dbl> <dbl> <int> <int> <int> <int>
#> 1 Mazda…  21.0     6  160.   110  3.90  2.62  16.5     0     1     4     4
#> 2 Mazda…  21.0     6  160.   110  3.90  2.88  17.0     0     1     4     4
#> 3 Datsu…  22.8     4  108.    93  3.85  2.32  18.6     1     1     4     1
#> 4 Horne…  21.4     6  258.   110  3.08  3.22  19.4     1     0     3     1
#> 5 Horne…  18.7     8  360.   175  3.15  3.44  17.0     0     0     3     2
#> 6 Valia…  18.1     6  225.   105  2.76  3.46  20.2     1     0     3     1

## now read and view the .rda file
head(c3 <- read_smart("exdat.rda"))
#>                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#> Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```
