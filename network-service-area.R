rm(list=ls())

library(tidyverse)
library(tidycensus)
library(sf)

## how to do this is QGIS
## https://gis.stackexchange.com/questions/44142/how-to-calculate-network-service-areas-in-qgis

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