install.packages("geosphere")
install.packages("Imap")
install.packages("ape")

### library
library(geosphere)
library(igraph)
library(Imap)
library(openxlsx)
library(ape)
library(writexl)

### 데이터셋
row_data <- read.xlsx("수도권 헬기장 위치 데이터.xlsx")
View(row_data)
lat <- row_data$위도
lon <- row_data$경도


### 데이터가공 - 거리데이터 만들기 
### Imap::gdist() : 타원 거리 계산 함수

dist_list <- list()

for(i in 1:nrow(row_data)) {
  dist_list[[i]] <- gdist(lon.1 = lon[i],
                        lat.1 = lat[i],
                        lon.2 = lon,
                        lat.2 = lat,
                        units = "km")
                        #a = 6378137.0,
                        #b = 6356752.3124)
}

dist_list

dist_data <- sapply(dist_list, unlist)
colnames(dist_data) <- c(1:24)
rownames(dist_data) <- c(1:24)
#colnames(dist_data) <- row_data$위치
#rownames(dist_data) <- row_data$위치
dist_data


### 다익스트라 거리공식
min_dist_data <- graph.adjacency(dist_data)
min_dist_data
par(mar = c(1,1,1,1))
plot(min_dist_data)
dijkstar_dist_data <- shortest.paths(min_dist_data, algorithm = "dijkstra") 
dijkstar_dist_data

map_data <- ape::mst(dist_data)

dijkstar_dist_data_df <-as.data.frame(dijkstar_dist_data)
dist_data_df <- as.data.frame(dist_data)
write_xlsx(dist_data_df, path ="./헬기장지평거리.xlsx")
write_xlsx(dijkstar_dist_data_df, path ="./헬기장다익스트라거리.xlsx")


