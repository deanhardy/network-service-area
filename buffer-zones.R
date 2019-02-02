rm(list=ls())

library(tidyverse)
library(tidycensus)
library(tigris)
library(sf)
library(tmap)

ST <- 'SC'
LOC <- 'Richland'
utm <- 2150 ## NAD83 17N

ews <- data.frame(
  place = 'ews',
  longitude = -81.030066,
  latitude = 33.995306)

ews <- st_as_sf(ews, coords = c('longitude', 'latitude'), crs = 4326) %>%
  st_transform(utm) # change to NAD83

ews_b <- st_buffer(ews, 1 * 1609.34) %>%
  st_transform(4326)
  
rd <- roads(ST, LOC) %>%
  st_as_sf() %>%
  st_transform(utm)

tm_shape(ews_b) + 
  tm_polygons() + 
tm_shape(ews) + 
  tm_dots() +
tm_shape(rd) + 
  tm_lines()
