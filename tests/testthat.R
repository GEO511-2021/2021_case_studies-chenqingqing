# repo="https://raw.githubusercontent.com/AdamWilsonLabEDU/geo511_tasks_tests"
#list basic packages needed for testing 
# list.of.packages <- c("devtools", "RCurl", "here")
# new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
# if(length(new.packages)) install.packages(new.packages)
# repo <- "https://github.com/GEO511-2021/2021_case_studies-chenqingqing"

# install basic needed packages 
list.of.packages <- c("devtools", "here")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#scans R script(s) and tries to quick-load/install the packages mentioned by library or require functions.
questionr::qscan(list.files(pattern="*.R",recursive=T), load = TRUE, detail = FALSE)
# setwd(devtools::package_file())

# source(here::here("tests/testthat/test.R"))
testthat::test_dir(testthat::test_path(), 
                   stop_on_failure = TRUE, 
                   reporter = "progress")
