# Repository to hold class activities for GEO511

## Overview
This template repository is set up to hold the semester's case study assignments for GEO511. 

## Assignments 
The detailed steps submitted for each assignments can be found in: 

  - [week_01/case_study_01.Rmd](week_01/case_study_01.md): Your first script
  - [week_02/case_study_02.Rmd](week_02/case_study_02.md): My grandfather says summers are getting hotter
  - [week_03/case_study_03.Rmd](week_03/case_study_03.md): Wealth over time
  - [week_04/case_study_04.Rmd](week_04/case_study_04.md): Beware the Canadians!
  - [week_05/case_study_05.Rmd](week_05/case_study_05.md): Find hottest country on each continent
  - [week_06/case_study_06.Rmd](week_06/case_study_06.md): Getting Help!

## Recommendations

### Do
* only commit text files (like `*.R` or `.Rmd` scripts) and possibly very small datasets
* use `.gitignore` to ignore certain files and filetypes

### DON'T
* commit large or non-text files (like `*.ppt`) especially if they will change often (git has 100MB maximum)
* move directories/folders around after starting the course repository
* edit/move the `.git` or `tests` folder
* edit/move the other files (`DESCRIPTION`, etc.)


## Automated Testing
This repository is set up to use automated testing with GitHub actions.  Each time the repository is pushed to GitHub, it will run the tests and report on whether there were any errors.  

To test whether the code passes before you submit to GitHub, run the following lines.  You may need to install the `testthat` package.  

```
library(testthat)
test_dir(test_path(), reporter="Summary")
```

