## ----setup, include=FALSE----------------------------------------------------------
knitr::opts_chunk$set(echo = T, warning = F, message = F)
library(dplyr)
library(tidyverse)
library(spData)
library(sf)
library(units)
library(tmap)


## ----------------------------------------------------------------------------------
#load 'world' data from spData package
data(world)  
# load 'states' boundaries from spData package
data(us_states)


## ----------------------------------------------------------------------------------
#quick view 
plot(world[1]) 
plot(us_states[1])


## ----------------------------------------------------------------------------------
# check world crs 
st_crs(world)


## ----------------------------------------------------------------------------------
canada_buffer <-  world %>% 
  st_transform(crs = "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs") %>% 
  filter(name_long == "Canada") %>% 
  # st_centroid() %>% 
  st_buffer(dist = 10000)

ny <-  us_states %>% 
  st_transform(crs = "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs") %>% 
  filter(NAME == "New York")

intersection <- st_intersection(canada_buffer, ny)


## ----------------------------------------------------------------------------------
# method 1
tm_shape(ny) +
  tm_borders() +
  tm_shape(intersection) +
  tm_polygons(col = "red")


## ----------------------------------------------------------------------------------
# method 2
ggplot() +
  geom_sf(data = ny) +
  geom_sf(data = intersection, fill = "red")


## ----------------------------------------------------------------------------------
intersection %>% 
  st_area() %>% 
  set_units(km^2)

