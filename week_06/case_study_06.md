Case Study 06: Find hottest country on each continent
================
Qingqing Chen
12 October, 2021

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

<div id="sozpdjihiy" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#sozpdjihiy .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#sozpdjihiy .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#sozpdjihiy .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#sozpdjihiy .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#sozpdjihiy .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#sozpdjihiy .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#sozpdjihiy .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#sozpdjihiy .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#sozpdjihiy .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#sozpdjihiy .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#sozpdjihiy .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#sozpdjihiy .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#sozpdjihiy .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#sozpdjihiy .gt_from_md > :first-child {
  margin-top: 0;
}

#sozpdjihiy .gt_from_md > :last-child {
  margin-bottom: 0;
}

#sozpdjihiy .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#sozpdjihiy .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#sozpdjihiy .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#sozpdjihiy .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#sozpdjihiy .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#sozpdjihiy .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#sozpdjihiy .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#sozpdjihiy .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#sozpdjihiy .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#sozpdjihiy .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#sozpdjihiy .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#sozpdjihiy .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#sozpdjihiy .gt_left {
  text-align: left;
}

#sozpdjihiy .gt_center {
  text-align: center;
}

#sozpdjihiy .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#sozpdjihiy .gt_font_normal {
  font-weight: normal;
}

#sozpdjihiy .gt_font_bold {
  font-weight: bold;
}

#sozpdjihiy .gt_font_italic {
  font-style: italic;
}

#sozpdjihiy .gt_super {
  font-size: 65%;
}

#sozpdjihiy .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="3" class="gt_heading gt_title gt_font_normal gt_bottom_border" style>The hottest country in each continent</th>
    </tr>
    
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Continent</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Maximum Temperature (C)</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">North America</td>
<td class="gt_row gt_left">United States</td>
<td class="gt_row gt_right">44.8</td></tr>
    <tr><td class="gt_row gt_left">South America</td>
<td class="gt_row gt_left">Argentina</td>
<td class="gt_row gt_right">36.5</td></tr>
    <tr><td class="gt_row gt_left">Seven seas (open ocean)</td>
<td class="gt_row gt_left">French Southern and Antarctic Lands</td>
<td class="gt_row gt_right">11.8</td></tr>
    <tr><td class="gt_row gt_left">Africa</td>
<td class="gt_row gt_left">Algeria</td>
<td class="gt_row gt_right">48.9</td></tr>
    <tr><td class="gt_row gt_left">Asia</td>
<td class="gt_row gt_left">Iran</td>
<td class="gt_row gt_right">46.7</td></tr>
    <tr><td class="gt_row gt_left">Europe</td>
<td class="gt_row gt_left">Spain</td>
<td class="gt_row gt_right">36.1</td></tr>
    <tr><td class="gt_row gt_left">Oceania</td>
<td class="gt_row gt_left">Australia</td>
<td class="gt_row gt_right">41.8</td></tr>
  </tbody>
  <tfoot class="gt_sourcenotes">
    <tr>
      <td class="gt_sourcenote" colspan="3">Source: WorldClim</td>
    </tr>
  </tfoot>
  
</table>
</div>
