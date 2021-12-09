## ----setup, include=FALSE-------------------------------------------------
knitr::opts_chunk$set(echo = T, warning = F, message = F)
library(tidyverse)
library(reprex)
library(sf)
library(spData)


## -------------------------------------------------------------------------
data(world)


## -------------------------------------------------------------------------
world %>%
  ggplot(., aes(gdpPercap, fill = continent)) +
  geom_density(alpha=0.5, color=F) +
  theme(legend.position = "bottom") +
  labs(fill = "Continent", x = "GDP per captita", y = "Density")


## ----eval = F-------------------------------------------------------------
## library(spData)
## library(ggplot2)
## data(world)
## ggplot(world, aes(x = gdpPercap, y = continent, color = continent)) +
##   geom_density(alpha=0.5,color=F)
## reprex(venue="gh")

