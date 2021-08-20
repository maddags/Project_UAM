### library
library(geosphere)
library(igraph)
library(Imap)
library(readxl)
library(ape)
library(writexl)


fiveth_data <- read_excel("./5차가공데이터.xlsx")

# 읍면동 중심위치와 가까운 터미널 거리 구하기
terminal <- read_excel("./터미널좌표.xlsx")
terminal <- terminal[,-1]
terminal_dist <- c()
for(i in c(1:length(fiveth_data$long.long))){
  data <- c()
  data <- gdist(lon.1 = fiveth_data$long.long[i],
                lat.1 = fiveth_data$lat.lat[i],
                lon.2 = terminal$위도,
                lat.2 = terminal$경도,
                units = "km")
  terminal_dist <- c(terminal_dist, min(data))
}
terminal_dist


# 읍면동 중심위치와 가까운 기차역 거리 구하기
train_station_data <- read_excel("./기차역좌표.xlsx")
train_station_data <- train_station_data[,-1]
train_station_dist <- c()

for(i in c(1:length(fiveth_data$long.long))){
  train_data <- c()
  train_data <- gdist(lon.1 = fiveth_data$long.long[i],
                lat.1 = fiveth_data$lat.lat[i],
                lon.2 = train_station_data$위도,
                lat.2 = train_station_data$경도,
                units = "km")
  train_station_dist <- c(train_station_dist,min(train_data))
}


# 읍면동 중심위치와 가까운 공항 거리 구하기
airport_data <- read.csv("./공항위치.csv")
colnames(airport_data) <- c("공항","경도","위도")
airport_data <- airport_data[,-1]
airport_dist <- c()

for(i in c(1:length(fiveth_data$long.long))){
  airport <- c()
  airport <- data <- gdist(lon.1 = fiveth_data$long.long[i],
                           lat.1 = fiveth_data$lat.lat[i],
                           lon.2 = airport_data$위도,
                           lat.2 = airport_data$경도,
                           units = "km")
  airport_dist <- c(airport_dist,min(airport))
}

# 3개 거리 합치기
distance <- data.frame(terminal_dist,train_station_dist,airport_dist)
colnames(distance) <- c("터미널과의거리","기차역과의거리","공항과의거리")
write_xlsx(distance,"교통수단(3개)과의거리.xlsx")

# 5차가공데이터와 합치기기
sixth_data <- data.frame(fiveth_data,distance)
names(sixth_data)[18] <- "long"
names(sixth_data)[19] <- "lat"
write_xlsx(sixth_data,"6차가공데이터.xlsx")
