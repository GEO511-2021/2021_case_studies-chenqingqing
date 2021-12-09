## ----setup, include=FALSE----------------------------------------------------
knitr::opts_chunk$set(echo = T, warning = F, message = F)
library(tidyverse)
library(sf)
library(ggmap)
library(rnoaa)
library(spData)


## ----------------------------------------------------------------------------
data(world)
data(us_states)


## ----------------------------------------------------------------------------
# Download zipped data from noaa with storm track information
dataurl <- "https://www.ncei.noaa.gov/data/international-best-track-archive-for-climate-stewardship-ibtracs/v04r00/access/shapefile/IBTrACS.NA.list.v04r00.points.zip"
tdir <- tempdir()
download.file(dataurl, destfile = file.path(tdir,"temp.zip"))
unzip(file.path(tdir,"temp.zip"), exdir = tdir)
list.files(tdir)
storm_data <- read_sf(list.files(tdir, pattern=".shp", full.names = T))
names(storm_data)
head(storm_data[1:3, 1:3])


## ----fig.width=10, fig.height=12---------------------------------------------
#Filter to storms 1950-present
storms <- storm_data %>% 
  filter(year >= 1950) %>% 
  mutate_if(is.numeric, function(x) ifelse(x == -999.0, NA, x)) %>% 
  mutate(decade = (floor(year/10)*10)) 

region <- st_bbox(storm_data)

ggplot() +
  geom_sf(data = world) +
  stat_bin2d(data = storms, aes(y = st_coordinates(storms)[,2], x = st_coordinates(storms)[,1]), bins = 100) + 
  facet_wrap(~decade) +
  scale_fill_distiller(palette="YlOrRd", 
                       trans="log", 
                       direction=-1, 
                       breaks = c(1,10,100,1000)) + 
  coord_sf(ylim=region[c(2,4)], xlim=region[c(1,3)]) +
  labs(x = "Longitude", y = "Latitude")


## ----------------------------------------------------------------------------
states <- us_states %>% 
  st_transform(crs = st_crs(storms)) %>% 
  rename(state = NAME)

storm_states <- st_join(storms, states, join = st_intersects, left = F)

top5_states <- storm_states %>% 
  st_set_geometry(NULL) %>% 
  group_by(state) %>% 
  dplyr::summarize(storms = length(unique(NAME))) %>% 
  arrange(desc(storms)) %>% 
  slice(1:5)

top5_states

