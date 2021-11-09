## ----setup, include=FALSE----------------------------------------------------
knitr::opts_chunk$set(echo = T, warning = F, message = F)
library(raster)
library(rasterVis)
library(rgdal)
library(ggmap)
library(tidyverse)
library(knitr)

# New Packages
library(ncdf4) # to import data from netcdf format


## ----------------------------------------------------------------------------
# Create a folder to hold the downloaded data
dir.create("data", showWarnings = F) #create a folder to hold the data

lulc_url <- "https://github.com/adammwilson/DataScienceData/blob/master/inst/extdata/appeears/MCD12Q1.051_aid0001.nc?raw=true"
lst_url <- "https://github.com/adammwilson/DataScienceData/blob/master/inst/extdata/appeears/MOD11A2.006_aid0001.nc?raw=true"

# download them
download.file(lulc_url,destfile = "data/MCD12Q1.051_aid0001.nc", mode = "wb")
download.file(lst_url,destfile = "data/MOD11A2.006_aid0001.nc", mode = "wb")

# load data 
lulc <- stack("data/MCD12Q1.051_aid0001.nc",varname="Land_Cover_Type_1")
lst <- stack("data/MOD11A2.006_aid0001.nc",varname="LST_Day_1km")


## ----------------------------------------------------------------------------
plot(lulc)


## ----------------------------------------------------------------------------
# pick one year to work with 
lulc <- lulc[[13]]
plot(lulc)


## ----------------------------------------------------------------------------
# Assign land cover clases from MODIS website
Land_Cover_Type_1 <-  c(
    Water = 0, 
    `Evergreen Needleleaf forest` = 1, 
    `Evergreen Broadleaf forest` = 2,
    `Deciduous Needleleaf forest` = 3, 
    `Deciduous Broadleaf forest` = 4,
    `Mixed forest` = 5, 
    `Closed shrublands` = 6,
    `Open shrublands` = 7,
    `Woody savannas` = 8, 
    Savannas = 9,
    Grasslands = 10,
    `Permanent wetlands` = 11, 
    Croplands = 12,
    `Urban & built-up` = 13,
    `Cropland/Natural vegetation mosaic` = 14, 
    `Snow & ice` = 15,
    `Barren/Sparsely vegetated` = 16, 
    Unclassified = 254,
    NoDataFill = 255)


## ----------------------------------------------------------------------------
lcd <- data.frame(
  ID = Land_Cover_Type_1,
  landcover = names(Land_Cover_Type_1),
  col = c("#000080","#008000","#00FF00", "#99CC00","#99FF99", "#339966", "#993366", "#FFCC99", "#CCFFCC", "#FFCC00", "#FF9900", "#006699", "#FFFF00", "#FF0000", "#999966", "#FFFFFF", "#808080", "#000000", "#000000"),
  stringsAsFactors = F)
# colors from https://lpdaac.usgs.gov/about/news_archive/modisterra_land_cover_types_yearly_l3_global_005deg_cmg_mod12c1
kable(head(lcd))


## ----------------------------------------------------------------------------
# Convert LULC raster into a ‘factor’ (categorical) raster. 
# This requires building the Raster Attribute Table (RAT). 
# convert to raster (easy)
lulc <- as.factor(lulc)

# update the RAT with a left join
levels(lulc) <- left_join(levels(lulc)[[1]], lcd, by = "ID")

# plot it
gplot(lulc) +
  geom_raster(aes(fill = as.factor(value))) +
  scale_fill_manual(values = levels(lulc)[[1]]$col,
                    labels = levels(lulc)[[1]]$landcover,
                    name = "Landcover Type") +
  coord_equal() +
  theme(legend.position = "bottom")+
  guides(fill = guide_legend(ncol = 5, nrow = 3, byrow = TRUE))


## ----------------------------------------------------------------------------
plot(lst[[1:12]])


## ----------------------------------------------------------------------------
# offs(): Gain and offset of values on file
offs(lst) <-  -273.15
plot(lst[[1:10]])


## ----------------------------------------------------------------------------
# The default layer names of the LST file include the date as follows
names(lst)[1:5]

# Convert those values to a proper R Date format by dropping the “X” and using as.Date()
tdates <- names(lst) %>%
  gsub(pattern = "X", replacement = "", .) %>% 
  as.Date("%Y.%m.%d")

names(lst) <- 1:nlayers(lst)
lst <- setZ(lst, tdates) # Get or set z-values


## ----------------------------------------------------------------------------
lw <- SpatialPoints(data.frame(x = -78.791547, y = 43.007211))
projection(lw) <- "+proj=longlat"
lw <- lw %>% spTransform(CRSobj = crs(lst))
lw_data <- raster::extract(lst, lw, buffer = 1000, fun = mean, na.rm = T) %>%
  t() %>% 
  as.data.frame() %>% 
  rownames_to_column(var = "id") %>% 
  as_tibble() %>% 
  rename(Temperature = V1) %>% 
  mutate(Date = getZ(lst))

lw_data %>% 
  ggplot(., aes(x = Date, y = Temperature)) + 
  geom_point() +
  geom_line(color = "blue") +
  geom_smooth(n = 300, span = 0.01) +
  theme_bw()


## ----------------------------------------------------------------------------
tmonth <- as.numeric(format(getZ(lst),"%m"))
lst_month <- stackApply(lst, tmonth, fun = mean)
names(lst_month) <-  month.name

# plot(lst_month)
gplot(lst_month) + 
  geom_tile(aes(fill = value)) +
  facet_wrap(~ variable) +
  scale_fill_gradient(low = 'blue', high = 'orange') +
  # coord_equal() +
  coord_sf(datum = NA) 


## ----------------------------------------------------------------------------
cellStats(lst_month, mean) %>% 
  as.data.frame() %>% 
  rename(Mean = ".") %>% 
  kable()

