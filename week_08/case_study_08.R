## ----setup, include=FALSE----------------------------------------------------
knitr::opts_chunk$set(echo = T, warning = F, message = F)
library(tidyverse)
library(kableExtra)


## ----------------------------------------------------------------------------
url <- "ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_annmean_mlo.txt"
df <- read.table(url, col.names = c("year", "mean", "unc"))


## ----fig.width=10, fig.height=8----------------------------------------------
#Use ggplot to plot a time series of CO2 levels through time
min_year <- df$year %>% min()
max_year <- df$year %>% max()
df %>% 
  mutate(sd = sd(mean)) %>% 
  as_tibble() %>% 
  ggplot(., aes(x = year, y = mean)) +
  geom_line(color = "black", lwd = 0.7) +
  geom_point(size = 1.5, color = "red") +
  scale_x_continuous(breaks = seq(min_year, max_year, 5)) +
  theme_bw() +
  labs(x = "Year", y = "Mean", 
       title= "Trends in Atmospheric Carbon Dioxide")


## ----------------------------------------------------------------------------
# statistical summary
summ <- df %>% 
  slice(-1) %>% 
  mutate(Years = case_when(
    year %in% seq(1960, 1969) ~ "1960 - 1969", 
    year %in% seq(1970, 1979) ~ "1970 - 1979", 
    year %in% seq(1980, 1989) ~ "1980 - 1989", 
    year %in% seq(1990, 1999) ~ "1990 - 1999", 
    year %in% seq(2000, 2009) ~ "2000 - 2009", 
    year %in% seq(2010, 2019) ~ "2010 - 2019", 
    year %in% seq(2020, 2029) ~ "2020 -  "
  )) %>% 
  group_by(Years) %>% 
  dplyr::summarise(Mean = mean(mean), 
                   S.D. = sd(mean), 
                   Min = min(mean), 
                   Max = max(mean)) 


## ----------------------------------------------------------------------------
# suitable for github doc output
knitr::kable(summ)
# %>% as_image(width = 10, file = "table.png")


## ----eval=T------------------------------------------------------------------
# suitable for html output 
kbl(summ,
  caption = "Mean Mauna Loa CO2 every decade", 
  format = "html", table.attr = "style='width:50%;'") %>%
  kableExtra::kable_styling(bootstrap_options = "striped",
  position = "float_right") 


## ----echo=F------------------------------------------------------------------
description <- tibble(
  Description = "Data from March 1958 through April 1974 have been obtained by C. David Keeling of the Scripps Institution of Oceanography (SIO) and were obtained from the Scripps website (scrippsco2.ucsd.edu). The estimated uncertainty in the annual mean is the standard deviation of the differences of annual mean values determined independently by NOAA/ESRL and the Scripps Institution of Oceanography. In general, the data presented for the last year are subject to change, depending on recalibration of the reference gas mixtures used, and other quality control procedures. Occasionally, earlier years may also be changed for the same reasons. Usually these changes are minor. CO2 expressed as a mole fraction in dry air, micromol/mol, abbreviated as ppm."
)
# gt::gt(description)


## ----------------------------------------------------------------------------
# suitable for html output
DT::datatable(summ, 
                caption = 'Mean Mauna Loa CO2 every decade', 
                rownames = F,
                filter = 'top')


## ----eval=F------------------------------------------------------------------
## rmarkdown::render("week_08/case_study_08.Rmd", output_format = "all")

