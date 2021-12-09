## Beware the Canadians!

Working with Spatial Data and the sf package

### Background

Up to this point, we have dealt with data that fits into the tidy format without much effort. Spatial data has many complicating factors that have made handling spatial data in R complicated. Big strides are being made to make spatial data tidy in R.

### Objective

You woke up in the middle of the night terrified of the Canadians after a bad dream. You decide you need to set up military bases to defend the Canada-NY border. After you tweet your plans, you realize you have no plan. What will you do next?

Generate a polygon that includes all land in NY that is within 10km of the Canadian border (not including the great lakes).
Calculate it’s area in km^2. How much land will you need to defend from the Canadians?

### Tasks

- Reproject spatial data using `st_transform()`
- Perform spatial operations on spatial data (e.g. `intersection` and `buffering`)
- Generate a polygon that includes all land in NY that is within 10km of the Canadian border and calculate the area
- Save your script as a `.R` or `.Rmd` in your course repository
