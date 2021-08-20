# 건축면적 관련 새로운 변수
## 읍면동 건축물 개수 변수, 15000이상인 면적을 가진 읍면동
buji <- read.csv("./최종건축면적-법정동.csv")
buji_copy <- buji[,-c(2,3,4,6,7,9:16)]
names(buji_copy)[2] <- c("EMD_CD")
names(buji_copy)[3] <- c("건축면적")
buji_copy$EMD_CD <- floor(buji_copy$EMD_CD/100)
buji_copy$EMD_CD <- as.character(buji_copy$EMD_CD)
buji_copy[is.na(buji_copy),]
buji_copy$EMD_CD <- as.numeric(buji_copy$EMD_CD)
View(buji_copy)

### 15000^2 이상 면적 건물 여부
buji_copy$면적15k여부 <- NA
buji_copy$건축면적 <- as.numeric(buji_copy$건축면적)
str(buji_copy)
for(i in c(1:length(buji_copy$건축면적))){
  ifelse(is.na(buji_copy$건축면적[i]) == TRUE,buji_copy$면적15k여부[i] <- NA,
         ifelse(buji_copy$건축면적[i] >= 15000,buji_copy$면적15k여부[i] <- 1,buji_copy$면적15k여부[i] <- 0))
}

### 읍면동별 건물수
building_list <- buji_copy$EMD_CD[!(duplicated(buji_copy$EMD_CD))]
building_counting <- c()

for(i in c(1:length(building_list))){
  data_count <- length(which(buji_copy$EMD_CD == building_list[i]))
  building_counting <- c(building_counting,data_count)
}

building <- data.frame(EMD_CD = building_list,
                       건물수 = building_counting)

buji_new_variable_data <- left_join(buji_copy, building, by ="EMD_CD")  
write_xlsx(buji_new_variable_data,"검토.xlsx")
