## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = T, warning = F, message = F)
library(dplyr)
library(tidyverse)
library(gt)
library(ggplot2)
library(raster)
library(sp)
library(sf)
library(spData)
library(tmap)


## -----------------------------------------------------------------------------
#load 'world' data from spData package
data(world) 
tmax_monthly <- getData(name = "worldclim", var="tmax", res=10)


## -----------------------------------------------------------------------------
sp_world <- world %>% 
  filter(continent != "Antarctica") %>% 
  as(.,"Spatial")


## -----------------------------------------------------------------------------
# overview
plot(tmax_monthly) 


## -----------------------------------------------------------------------------
gain(tmax_monthly) <- 1/10
tmax_annual <- max(tmax_monthly)
names(tmax_annual) <- "tmax"


## -----------------------------------------------------------------------------
# extract the max temp 
sf_tmax <- raster::extract(tmax_annual, sp_world, fun = max, na.rm = T, small = T, sp = T) %>% 
  st_as_sf()


## -----------------------------------------------------------------------------
# method 1
ggplot(sf_tmax) +
  geom_sf(aes(fill = tmax)) + 
  scale_fill_viridis_c(name="Annual\nMaximum\nTemperature (C)") + 
  theme_minimal() + 
  theme(legend.position = 'bottom') 

# method 2
tm_shape(sf_tmax) +
  tm_polygons(col = "tmax", 
              style = "cont",
              palette = "viridis", 
              n = 7, 
              title = 'Annual Maximum Temperature(C)') +
  tm_layout(legend.outside = F, 
            legend.text.size = 0.6, 
            legend.title.size = 0.75, 
            frame = F)


## -----------------------------------------------------------------------------
sf_tmax %>% 
  st_set_geometry(NULL) %>% 
  group_by(continent) %>% 
  dplyr::select(continent, name_long, tmax) %>% 
  top_n(1) %>% 
  ungroup() %>% 
  gt() %>% 
  cols_label(
    continent = "Continent", 
    name_long = "Country", 
    tmax = "Maximum Temperature (C)"
  ) %>% 
  tab_header(
    title = "The hottest country in each continent", 
  ) %>% 
  tab_source_note(
    source_note = "Source: WorldClim"
  )

