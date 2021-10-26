## One Script, Many Products

RMarkdown to create dynamic research outputs. Publishing to `github/word/html/etc`

### Tasks

- Build a RMarkdown document that downloads a dataset, produces one graph and one table, and exports to four different formats (HTML, GitHub Markdown, Word, Powerpoint).

### Background

You are working on a team that needs to provide regular updates about a dataset that is regularly updated. Currently, an employee does the following steps once per week:

  - Goes to a website with the source data
  - Downloads the data as a text file
  - Opens a graphing program and clicking through a set of procedures to make a particular set of graphs
  - Saves the updated data in several formats including:
      - Powerpoint presentation
      - Website hosted on the team website
      - Word document that is included in company reports
      - A PDF document for downloading/printing

This takes the employee about 3 hours every week. You are a new member of the team and you confidently declare you could automate the procedure using R and RMarkdown (and that you could complete the automation in less than three hours!). The team looks at you with wide eyes. You realize you better get working.

### Specifying multiple outputs with RMarkdown

You can specify that RMarkdown should produce multiple outputs using the following syntax in the YAML header:

```
output:
  html_document: default
  github_document: default
  powerpoint_presentation: default
  word_document: default
```

You can read more about the YAML header and all the options [here](https://bookdown.org/yihui/rmarkdown/html-document.html). Note that you can specify many options for each output format to change the theme, structure, etc.

However, if you click the “Knit” button in RStudio, it will only make one output. To ‘render’ all of them, you have to use a command like this in the R Console.

```
rmarkdown::render("path/to/file.Rmd",output_format = "all")
```

### Data

You will be working with the data available [here](https://gml.noaa.gov/ccgg/trends/data.html). You can read it in using `read_table()` but you will have to look at the text file and specify how many lines to skip.

### Outputs

Your objective is to automatically produce various outputs like MS Word, PPTX, and HTML.

The document should:
  
  - Download the data (including correctly importing it)
  - Make one timeseries plot (ggplot of CO2~time)
  - Make one table. This table can summarize anything you want (top 5 years? Mean CO2 every decade?)
