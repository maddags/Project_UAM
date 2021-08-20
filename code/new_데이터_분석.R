library(readxl)
library(raster)
library(rgdal)
library(ggplot2)
library(dplyr)
library(writexl)

data <- read_excel("./4차가공데이터.xlsx")
map <- shapefile("./EMD_202101/TL_SCCO_EMD.shp")

map_list <- map@data
map_list[,"id"] <- (1:nrow(map_list)) - 1
map_list <- map_list[,c(1,4)]
map_list$EMD_CD <- as.numeric(map_list$EMD_CD)
fusion_data <- left_join(data,map_list, by = "EMD_CD")


# Max-Min 정규화함수 만들기
mm_normal <- function(x){
  (x - min(x)) / (max(x) - min(x))
}


mm_normal_data <- fusion_data
for(i in c(9,10,11,13,14)){
  mm_normal_data[i] <- mm_normal(mm_normal_data[i])
}

# 시각화 할 데이터 만들기
## 원래 알던 위,경도 값으로 전환
map <- spTransform(map, CRS("+proj=longlat")) 
korea <- fortify(map)
korea

long_max <- c()
long_min <- c()
lat_max <- c()
lat_min <- c()
for(i in c(5001:5050)){
  long_max <- c(long_max,max(korea$long[korea$id == i]))
  long_min <- c(long_min,min(korea$long[korea$id == i]))
  lat_max <- c(lat_max,max(korea$lat[korea$id == i]))
  lat_min <- c(lat_min,min(korea$lat[korea$id == i]))
  print(i)
}

long_check_max <- c()
long_check_min <- c()
lat_check_max <- c()
lat_check_min <- c()
for(i in c(0:5050)){
  long_check_max <- c(long_check_max,max(korea$long[korea$id == i]))
  long_check_min <- c(long_check_min,min(korea$long[korea$id == i]))
  lat_check_max <- c(lat_check_max,max(korea$lat[korea$id == i]))
  lat_check_min <- c(lat_check_min,min(korea$lat[korea$id == i]))
  print(i)
}

long <- data.frame(long_check_max,long_check_min)
lat <- data.frame(lat_check_max,lat_check_min)

long$long <- apply(long,1,mean)
lat$lat <- apply(lat,1,mean)

location <- data.frame(long$long,lat$lat)
location$id <- c(0:5050)

fiveth_data <- inner_join(mm_normal_data,location, by ="id")
write_xlsx(fiveth_data,"5차가공데이터.xlsx")
