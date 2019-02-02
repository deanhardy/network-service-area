rm(list=ls())

library(tidyverse)
library(tidycensus)
library(tigris)
library(sf)
library(tmap)

ST <- 'SC'
LOC <- 'Richland'
utm <- 2150 ## NAD83 17N
bf = 3

ews <- data.frame(
  place = 'ews',
  longitude = -81.030066,
  latitude = 33.995306)

ews2 <- st_as_sf(ews, coords = c('longitude', 'latitude'), crs = 4326) %>%
  st_transform(utm) # change to NAD83

ews_b <- st_buffer(ews2, bf * 1609.34) %>%
  st_transform(4326)

# rd <- roads(ST, LOC) %>%
#   st_as_sf() %>%
#   st_transform(utm)
# 
# tm_shape(ews_b) + 
#   tm_borders(col = 'red') + 
# tm_shape(ews) + 
#   tm_dots(col = 'red', size = 0.5) +
# tm_shape(rd) + 
#   tm_lines(col = 'RTTYP')

library(leaflet)
library(leaflet.extras)

df <- st_transform(ews_b, 4326)

leaflet() %>%
  addTiles(group = 'Open Street Map') %>%
  setView(lng = ews$longitude, lat = ews$latitude, zoom = 12) %>%
  addScaleBar('bottomright') %>%
  addPolygons(data = df) %>%
  addMarkers(data = ews)
