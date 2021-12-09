Case Study 06: Find hottest country on each continent
================
Qingqing Chen
15 October, 2021

## Load data

``` r
#load 'world' data from spData package
data(world) 
tmax_monthly <- getData(name = "worldclim", var="tmax", res=10)
```

## Prepare world data

``` r
sp_world <- world %>% 
  filter(continent != "Antarctica") %>% 
  as(.,"Spatial")
```

## Prepare climate data

``` r
# overview
plot(tmax_monthly) 
```

![](case_study_06_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

``` r
gain(tmax_monthly) <- 1/10
tmax_annual <- max(tmax_monthly)
names(tmax_annual) <- "tmax"
```

## Calculate the maximum temperature observed in each country

``` r
# extract the max temp 
sf_tmax <- raster::extract(tmax_annual, sp_world, fun = max, na.rm = T, small = T, sp = T) %>% 
  st_as_sf()
```

## Communicate the results

### Spatial distribution of the annual maximum temperature

``` r
# method 1
ggplot(sf_tmax) +
  geom_sf(aes(fill = tmax)) + 
  scale_fill_viridis_c(name="Annual\nMaximum\nTemperature (C)") + 
  theme_minimal() + 
  theme(legend.position = 'bottom') 
```

![](case_study_06_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

``` r
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
```

![](case_study_06_files/figure-gfm/unnamed-chunk-6-2.png)<!-- -->

### The hottest country in each continent

``` r
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
```

![](table1.png)
