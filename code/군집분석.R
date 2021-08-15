library(readxl)
library(caret)
library(writexl)

data <- read_excel("./2018년_버티포트 위치 선정 변수.xlsx")
View(data)
name <- paste(data$`도/광역시/시`,data$시군구,data$읍면동, sep ="_")
rownames(data) <- name
View(data)

# 필요한 변수만
cluster_data <- data[,c(4,5,7)]
View(cluster_data)


# 결측값 0으로 변환
cluster_data[is.na(cluster_data)] <- 0
View(cluster_data)

# 정규화
scale_data <- cluster_data
people_min <- min(scale_data$인구밀도)
people_max <- max(scale_data$인구밀도)
scale_data$인구밀도 <- scale(scale_data$인구밀도,
                              center = people_min,
                              scale = people_max)

View(scale_data)



# kmeans 군집분석
kmeans_data <- scale_data[,-1]
rownames(kmeans_data) <- name
View(kmeans_data)

result <- kmeans(kmeans_data, centers = 52, nstart = 10)
result

result$centers
result$cluster

table(result$cluster)

# 각 군집 표시
clustered_data <- scale_data
clustered_data$군집 <- result$cluster
View(clustered_data)
write_xlsx(clustered_data,"군집화.xlsx")


