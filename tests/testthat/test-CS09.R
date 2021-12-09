# base_url="https://raw.githubusercontent.com/AdamWilsonLabEDU/GEO511_tests/master/"
# test_url=paste0(base_url,"test-CS02.R")
# setwd(devtools::package_file())
# 
# if(RCurl::url.exists(test_url)) source(test_url)

setwd(devtools::package_file())

#full path of test file 
base_path <- paste0(here::here(), "/week_09/")
test_file_nm <- list.files(pattern="*.Rmd", path = base_path,  recursive=T)
full_test_file_path <- paste0(base_path, test_file_nm)


#convert Rmd to R script a
ouput_file <- paste0(base_path, gsub(".Rmd", ".R", test_file_nm))
knitr::purl(input = full_test_file_path, 
            output = ouput_file)
source(ouput_file)
# testthat::test_that("File source without errors", {
#   expect_output(source(ouput_file))
# })
