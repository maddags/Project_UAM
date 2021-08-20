library(readxl)
library(raster)
library(rgdal)
library(ggplot2)

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

# 군집분석
## 공역 지역 제거
airpath_data <- mm_normal_data[mm_normal_data$비행불가능여부 == 0,]
str(airpath_data)

## 시도별 군집화
### 경상북도
Gyeongbuk <- airpath_data[airpath_data$SIDO == 47,]
Gyeongbuk_kmeans <- Gyeongbuk[,c(8:16)]
Gyeongbuk_result <- kmeans(Gyeongbuk_kmeans, centers = 5, iter.max = 10000)
Gyeongbuk$해당군집 <- Gyeongbuk_result$cluster
Gyeongbuk$해당군집 <- as.character(Gyeongbuk$해당군집)

### 경상남도
Gyeongnam <- airpath_data[airpath_data$SIDO == 48,]
Gyeongnam_kmeans <- Gyeongnam[,c(8:16)]
Gyeongnam_result <- kmeans(Gyeongnam_kmeans, centers = 4, iter.max = 10000)
Gyeongnam$해당군집 <- Gyeongnam_result$cluster
Gyeongnam$해당군집 <- as.character(Gyeongnam$해당군집)

### 전라남도
Jeonman <- airpath_data[airpath_data$SIDO == 46,]
Jeonman_kmeans <- Jeonman[,c(8:16)]
Jeonman_result <- kmeans(Jeonman_kmeans, centers = 4, iter.max = 10000)
Jeonman$해당군집 <- Jeonman_result$cluster
Jeonman$해당군집 <- as.character(Jeonman$해당군집)

### 전라북도
Jeonbuk <- airpath_data[airpath_data$SIDO == 45,]
Jeonbuk_kmeans <- Jeonbuk[,c(8:16)]
Jeonbuk_result <- kmeans(Jeonbuk_kmeans, centers = 4, iter.max = 10000)
Jeonbuk$해당군집 <- Jeonbuk_result$cluster
Jeonbuk$해당군집 <- as.character(Jeonbuk$해당군집)

### 충청남도
Chungnam <- airpath_data[airpath_data$SIDO == 45,]
Chungnam_kmeans <- Chungnam[,c(8:16)]
Chungnam_result <- kmeans(Chungnam_kmeans, centers = 10, iter.max = 10000)
Chungnam$해당군집 <- Chungnam_result$cluster
Chungnam$해당군집 <- as.character(Chungnam$해당군집)

### 충청북도
Chungbuk <- airpath_data[airpath_data$SIDO == 44,]
Chungbuk_kmeans <- Chungbuk[,c(8:16)]
Chungbuk_result <- kmeans(Chungbuk_kmeans, centers = 5, iter.max = 10000)
Chungbuk$해당군집 <- Chungbuk_result$cluster
Chungbuk$해당군집 <- as.character(Chungbuk$해당군집)

### 경기도
Gyeonggi <- airpath_data[airpath_data$SIDO == 41,]
Gyeonggi_kmeans <- Gyeonggi[,c(8:16)]
Gyeonggi_result <- kmeans(Gyeonggi_kmeans, centers = 4, iter.max = 10000)
Gyeonggi$해당군집 <- Gyeonggi_result$cluster
Gyeonggi$해당군집 <- as.character(Gyeonggi$해당군집)


### 서울특별시



# 시각화 할 데이터 만들기
## 원래 알던 위,경도 값으로 전환
map <- spTransform(map, CRS("+proj=longlat")) 
korea <- fortify(map)
korea

# merge_data <- merge(korea,mm_normal_data, by ="id")
merge_gyeongbuk_data <- merge(korea,Gyeongbuk, by = "id")
merge_gyeongnam_data <- merge(korea,Gyeongnam, by = "id")
merge_jeonman_data <- merge(korea,Jeonman, by = "id")
merge_jeonbuk_data <- merge(korea,Jeonbuk, by = "id")
merge_chungnam_data <- merge(korea,Chungnam, by = "id")
merge_chungbuk_data <- merge(korea,Chungbuk, by = "id")
merge_Gyeonggi_data <- merge(korea,Gyeonggi, by = "id")

ggplot(data = merge_gyeongbuk_data, aes(x = long, y = lat,group = group, color =해당군집)) +
  geom_polygon(fill = "#FFFFFF")

ggplot(data = merge_gyeongnam_data, aes(x = long, y = lat,group = group, color =해당군집)) +
  geom_polygon(fill = "#FFFFFF")

ggplot(data = merge_jeonman_data, aes(x = long, y = lat,group = group, color =해당군집)) +
  geom_polygon(fill = "#FFFFFF")

ggplot(data = merge_jeonbuk_data, aes(x = long, y = lat,group = group, color =해당군집)) +
  geom_polygon(fill = "#FFFFFF")

ggplot(data = merge_chungnam_data, aes(x = long, y = lat,group = group, color =해당군집)) +
  geom_polygon(fill = "#FFFFFF")

ggplot(data = merge_chungbuk_data, aes(x = long, y = lat,group = group, color =해당군집)) +
  geom_polygon(fill = "#FFFFFF")

ggplot(data = merge_Gyeonggi_data, aes(x = long, y = lat,group = group, color =해당군집)) +
  geom_polygon(fill = "#FFFFFF")
