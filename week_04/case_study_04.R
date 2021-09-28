## ----setup, include=FALSE------------------------------------------------------------------------
knitr::opts_chunk$set(echo = T, warning = F, message = F)
library(dplyr)
library(nycflights13)


## ------------------------------------------------------------------------------------------------
glimpse(flights)
names(flights)


## ------------------------------------------------------------------------------------------------
df_sub <- flights %>% 
  dplyr::select(tailnum, flight, origin, dest, distance) %>% # select only needed columns 
  unique() %>% # remove duplicated columns 
  arrange(desc(distance)) %>% # arrange the distance 
  slice(1) %>%  # get the farest distance 
  left_join(., airports, c("dest" = "faa")) # join airpots to find the full airpot name

# solution 1
farthest_airport <- df_sub %>% pull(name)
farthest_airport

# solution 2
farthest_airport <- df_sub %>% 
  select(name) %>% 
  as.character()
farthest_airport

