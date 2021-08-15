library(rgdal)
library(ggplot2)
library(dplyr)
library(readxl)
library(writexl)

map_list <- map@data
head(map_list)

map_list[,"id"] = (1:nrow(map_list)) - 1
map_list[,"SIDO"] = as.numeric(substr(map_list$EMD_CD,start=1,stop= 2))

head(map_list)


map_info = fortify(map)
map_info

summary(map_info)


ggplot(data = map_info, aes(x = long, y = lat, group = group, color = id)) +
  geom_polygon(fill = "#FFFFFF") +
  theme(legend.position = "none")



table(map_info$id)

