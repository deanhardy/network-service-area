rm(list=ls())

library(tidyverse)
library(sf)
library(leaflet)
library(leaflet.extras)

## define variables
utm <- 2150 ## NAD83 17N
bd = c(0.5,1,1.5,2,2.5,3) ## define buffer distances

loc <- data.frame(
  place = 'loc',
  longitude = -81.030066,
  latitude = 33.995306)

loc2 <- st_as_sf(loc, coords = c('longitude', 'latitude'), crs = 4326) %>%
  st_transform(utm) # change to NAD83 with units of meters

## loop buffer calculation & outpout as new data frame
df <- NULL

for(i in 1:length(bd)) {
  OUT <- st_buffer(loc2, bd[[i]] * 1609.34) %>%
    st_transform(4326) %>%
    data.frame()
  df <-rbind(OUT,df)
}

## reset geometry on loop output & reproject CRS for leaflet mapping
df2 <- st_set_geometry(df, 'geometry') %>%
  st_transform(4326) %>%
  mutate(id = bd)

leaflet() %>%
  addTiles(group = 'Open Street Map') %>%
  setView(lng = loc$longitude, lat = loc$latitude, zoom = 12) %>%
  addScaleBar('bottomright') %>%
  addPolylines(data = df2, color = 'red', label = bd, weight = 2) %>%
#  addLabelOnlyMarkers(data = df2, label = id) %>%
  addMarkers(data = loc)
