## Find hottest country on each continent

Use sf and raster to quantify maximum temperature for each country and then identify the hottest one on each continent.


### Background

The raster data format is commonly used for environmental datasets such as elevation, climate, soil, and land cover. We commonly need to extract the data from raster objects using simple features (vector objects). For example if you had a set of points you collected using a GPS and wanted to know the mean annual temperature at each point, you might extract the data from each location in a raster-based map of temperature.

In this case study we’ll work with a timeseries of temperature data from [WorldClim](https://worldclim.org/). These are near-global rasters of various climatic variables available at several resolutions. For convenience, we’ll work with the very coarse data (0.5 degree, which is about 50km), but much finer data are available (~1km).

### Objective

Identify the hottest country on each continent (not counting Antarctica) by intersecting a set of polygons with a raster image and calculating the maximum raster value in each polygon. 

### Tasks

- Calculate annual maximum temperatures from a monthly spatio-temporal dataset
- Remove Antarctica from the world dataset
- Summarize raster values within polygons
- Generate a summary figure and table.
- Save your script as a `.R` or `.Rmd` in your course repository








