# Parallel Computing with R

Write a parallel for loop

## Tasks

- Download spatial data from the U.S. Census
- Write a parallel foreach() loop to generate a point representing each person in each census polygon (block/tract)
- Set the output of the foreach() funtion to return a spatial (sf) object
- Make a ‘dot map’ of the racial distribution in Buffalo, NY.

## Background

The census data do not include specific addresses (the finest spatial information is the census block), so it’s common to see chloropleths representing the aggregate statistics of the underlying polygon. This is accurate, but not so personal. Folks at the University of Virginia developed a simple yet effective visualization approach, called the ‘Racial Dot Map’ which conveys a simple idea - one dot equals one person. Here’s how it looks for Buffalo, NY.

The idea is really simple. One just randomly generates a point for each person of each racial identity within each polygon.
