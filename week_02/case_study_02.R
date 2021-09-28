## ----setup, include=FALSE---------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning = F, message = F, fig.width = 10, fig.height = 10)
library(tidyverse)
library(janitor)
library(dplyr)
library(TTR)


## ---------------------------------------------------------------------------------------------
# define the link to the data - you can try this in your browser too.  Note that the URL ends in .txt.
# dataurl <- "https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00014733&ds=14&dt=1"
# temp <- read_table(dataurl, 
#                    skip = 2, # skip the first two lines
#                    na = "999.90",
#                    progress = F) %>% 
#   clean_names() 
temp <- read_csv(here::here("data/cs2_station.csv")) %>% clean_names() 
head(temp)


## ---------------------------------------------------------------------------------------------
names(temp)
glimpse(temp)
summary(temp)


## ---------------------------------------------------------------------------------------------
mean_jja <- mean(temp[which(temp$j_j_a != 999.90), ]$j_j_a)

temp_jja <- temp %>% 
  dplyr::select(year, j_j_a) %>%
  rename(JJA = j_j_a) %>% 
  mutate(JJA = if_else(JJA == 999.90, mean_jja, JJA)) %>%
  mutate(avg_5year = SMA(JJA, n = 5)) 


## ---------------------------------------------------------------------------------------------
ggplot(temp_jja) +
  geom_line(aes(x = year, y = JJA, group = 1)) +
  geom_line(aes(x = year, y = avg_5year, group = 1), color = "blue", linetype = 2, lwd = 0.8) +
  geom_smooth(aes(x = year, y = JJA, group = 1), col = "red") +
  scale_x_continuous(breaks = seq(1880, 2025, 5)) +
  labs(x = "Year", y = "Mean Summer Temperature (cº)",
       title = "Mean Summaer Temperatures in Buffalo, NY",
       subtitle = "Summer includes June, July, and August \nData from the Global Historical Climate Network \nRed line is a LOESS smooth and blue line is a moving average of 5 years' temperature") +
  theme_classic() +
  theme(title = element_text(size = 13), 
        axis.text.x = element_text(angle = 90, vjust = 0.5))

