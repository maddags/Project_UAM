library(rgdal)
library(ggplot2)
library(dplyr)
library(readxl)
library(writexl)
library(stringr)

map = readOGR("./EMD_202101/TL_SCCO_EMD.shp")
code_address = read_excel("./읍면동법적코드.xlsx")

map_list <- map@data
head(map_list)
map_list[,"SIDO"] = as.numeric(substr(map_list$EMD_CD,start=1,stop= 2))
str(map_list)
head(map_list)


#읍면동 데이터만 남기기
df_code_address <- as.data.frame(code_address)
str(df_code_address$법정동코드)
df_code_address$법정동코드<-floor(df_code_address$법정동코드/100)
df_code_address <- df_code_address[,-3]
names(df_code_address)[1] <- c("EMD_CD")
head(df_code_address)
rm_data_ri <- grep("리$",df_code_address$법정동명, value = 1)
rm_data_gu <- grep("구$",df_code_address$법정동명,value = 1)
rm_data_si <- grep("시$",df_code_address$법정동명, value = 1)
rm_data_do <- grep("도$",df_code_address$법정동명, value = 1)
rm_data_gun <- grep("군$", df_code_address$법정동명, value = 1)
rm_data_special <- grep(")$", df_code_address$법정동명, value = 1)
df_code_address <- df_code_address[!(df_code_address$법정동명 %in% rm_data_si),]
df_code_address <- df_code_address[!(df_code_address$법정동명 %in% rm_data_do),]
df_code_address <- df_code_address[!(df_code_address$법정동명 %in% rm_data_gu),]
df_code_address <- df_code_address[!(df_code_address$법정동명 %in% rm_data_ri),]
df_code_address <- df_code_address[!(df_code_address$법정동명 %in% rm_data_gun),]
df_code_address <- df_code_address[!(df_code_address$법정동명 %in% rm_data_special),]
df_code_address$EMD_CD <- as.character(df_code_address$EMD_CD)
str(df_code_address)
head(df_code_address)

# 읍면동 풀주소 데이터 합치기
join_data_EN <- left_join(df_code_address,map_list, by = "EMD_CD")


# join_data_EN 결측값 채워넣기
data_list <- c(1885,1943,2116,2469,4005,4493,4494,4495,4496,4497,4498,4499,4500)
data_name <- c()
data_sido <- c()
for(i in c(1:13)){
  address <- strsplit(join_data_EN$법정동명[data_list], split = " ")[[i]]
  while(length(address) > 1){
    address <- address[-1]
  }
  data_name <- c(data_name,address)
  data_sido <- floor(as.numeric(join_data_EN$EMD_CD[data_list])/1000000)
}
join_data_EN$SIDO[data_list] <- data_sido
join_data_EN$EMD_KOR_NM[data_list] <- data_name
join_data_EN$법정동명[1497] <- "세종특별자치시 산울동"
join_data_EN$법정동명[1498] <- "세종특별자치시 해밀동"
join_data_EN$법정동명[1499] <- "세종특별자치시 합강동"
join_data_EN$법정동명[1500] <- "세종특별자치시 집현동"
join_data_EN[is.na(join_data_EN),]
join_data_EN$EMD_ENG_NM[1885] <- "Baegot-dong"
join_data_EN$EMD_ENG_NM[1943] <- "Namsa-eup"
join_data_EN$EMD_ENG_NM[2116] <- "Saesol-dong"
join_data_EN$EMD_ENG_NM[2469] <- "Yeonggwimi-myeon"
join_data_EN$EMD_ENG_NM[4005] <- "Munmudaewang-myeon"
join_data_EN$EMD_ENG_NM[4493] <- "Yongji-dong"
join_data_EN$EMD_ENG_NM[4494] <- "Yongho-dong"
join_data_EN$EMD_ENG_NM[4495] <- "Sinwol-dong"
join_data_EN$EMD_ENG_NM[4496] <- "Daewon-dong"
join_data_EN$EMD_ENG_NM[4497] <- "Dudae-dong"
join_data_EN$EMD_ENG_NM[4498] <- "Samdong-dong"
join_data_EN$EMD_ENG_NM[4499] <- "Deokjeong-dong"
join_data_EN$EMD_ENG_NM[4500] <- "Toechon-dong"
join_data_EN[is.na(join_data_EN),]


# 공역 데이터 변수 추가
gongyuk <- read.csv("./공역-법정동.csv")
load(file = "C:\\Users\\madda/Documents\\청년 데이터 캠프\\project\\UAM\\address_list.RData")
gongyuk$법정동 <- floor(gongyuk$법정동/100)
names(gongyuk)[3] <- c("EMD_CD")
gongyuk$EMD_CD <- as.character(gongyuk$EMD_CD)
join_data_EN_2 <- full_join(join_data_EN,gongyuk, by = "EMD_CD")
duplicated_data <- join_data_EN_2[duplicated(join_data_EN_2$EMD_CD),] # 중복된 데이터

### 변수 x.1의 NA값 채워넣기 
duplicated_data$법정동명 <- address_list
for(i in c(1:length(join_data_EN_2$법정동명))){
  if(is.na(join_data_EN_2$X.1)[i] == TRUE){
    join_data_EN_2$X.1[i] <- join_data_EN_2$법정동명[i]
  }
}
duplicated_data <- duplicated_data[,c(2,8)]




### 변수 비행불가능여부 NA값 채워넣기
airspace <- inner_join(join_data_EN_2,duplicated_data, by = "법정동명")
airspace <- airspace[,-c(6,8)]
duplicated_airspace <- airspace[duplicated(airspace$EMD_CD),] # test2의 중복으로 있는 데이터
airspace <- airspace[-as.numeric(rownames(duplicated_airspace)),]
join_data_EN_2 <- join_data_EN_2[-as.numeric(rownames(duplicated_data)),]
join_data_EN_2[join_data_EN_2$법정동명 %in% airspace$법정동명,]$비행불가능여부 <- airspace$비행불가능여부.y
join_data_EN_2[is.na(join_data_EN_2$비행불가능여부),] 
join_data_EN_3 <- join_data_EN_2[,-c(6,7)]
write_xlsx(join_data_EN_3,"join_data_EN_3.xlsx")
### 여기 비행불가능여부 na값 채워넣기


# 터미널유무 변수 추가
bus_station <- read.csv("./터미널법정동.csv")
bus_station_copy <- bus_station[,-c(1,2,3)]
head(bus_station_copy)
str(bus_station_copy)
bus_station_copy$코드 <- floor(bus_station_copy$코드/100)
names(bus_station_copy)[1] <- "EMD_CD"
bus_station_copy$EMD_CD <- as.character(bus_station_copy$EMD_CD)
bus_join_data <- left_join(join_data_EN_3, bus_station_copy, by ="EMD_CD")
write_xlsx(bus_join_data,"bus_join_data.xlsx")
bus_join_data <- read_excel("./bus_join_data.xlsx") %>% as.data.frame()
bus_join_data<-bus_join_data[!(duplicated(bus_join_data$법정동명)),]
bus_join_data$터미널유무[is.na(bus_join_data$터미널유무)] <- 0 
View(bus_join_data)
sum(is.na(bus_join_data$터미널유무))
sum(duplicated(bus_join_data))
write_xlsx(bus_join_data,"공항여부_터미널여부_미완성.xlsx")

## 최종건축면적 데이터 변수 추가
buji <- read.csv("./최종건축면적-법정동.csv")
buji_copy <- buji[,-c(2,3,4,6,7,9:16)]
names(buji_copy)[2] <- c("EMD_CD")
names(buji_copy)[3] <- c("건축면적")
buji_copy$EMD_CD <- floor(buji_copy$EMD_CD/100)

### 15000^2 이상 면적 건물 여부 변수 만들기
buji_copy$면적15k여부 <- NA
buji_copy$건축면적 <- as.numeric(buji_copy$건축면적)
str(buji_copy)
for(i in c(1:length(buji_copy$건축면적))){
  ifelse(is.na(buji_copy$건축면적[i]) == TRUE,buji_copy$면적15k여부[i] <- NA,
         ifelse(buji_copy$건축면적[i] >= 15000,buji_copy$면적15k여부[i] <- 1,buji_copy$면적15k여부[i] <- 0))
}
head(buji_copy)

### 읍면동별 건물수 변수 만들기
building_list <- buji_copy$EMD_CD[!(duplicated(buji_copy$EMD_CD))]
building_counting <- c()
for(i in c(1:length(building_list))){
  data_count <- length(which(buji_copy$EMD_CD == building_list[i]))
  building_counting <- c(building_counting,data_count)
}
building <- data.frame(EMD_CD = building_list,
                       건물수 = building_counting)
buji_new_variable_data <- left_join(buji_copy, building, by ="EMD_CD") 
str(buji_new_variable_data)
buji_new_variable_data$EMD_CD <- as.character(buji_new_variable_data$EMD_CD)
buji_new_variable_data$건축면적[is.na(buji_new_variable_data$건축면적)] <- "x"
buji_new_variable_data$면적15k여부[is.na(buji_new_variable_data$면적15k여부)] <- 9
join_data_EN_4 <- left_join(bus_join_data,buji_new_variable_data, by = "EMD_CD")

## NA값들은 애초부터 없는 건물이 없으므로 0값을 대입해준다.
### 15k면적여부-9 : 데이터 값을 모른다는 의미
### 건축면적 - x : 데이터값을 모른다는 의미
join_data_EN_4$종류[is.na(join_data_EN_4$종류)] <- "없음"
join_data_EN_4$건축면적[is.na(join_data_EN_4$건축면적)] <- 0
join_data_EN_4$면적15k여부[is.na(join_data_EN_4$면적15k여부)] <- 0
join_data_EN_4$건물수[is.na(join_data_EN_4$건물수)] <- 0
write_xlsx(join_data_EN_4,"검토.xlsx")

# 교통혼잡,인구수 데이터 변수 추가
trans <- read_excel("./2018 리뉴얼.xlsx") %>% as.data.frame()
trans_copy <- trans[,-10]
trans_copy$행정주소 <- paste(trans_copy$`도/광역시/시`,trans_copy$시군구,trans_copy$읍면동,
                         rep = " ")
trans_copy <- trans_copy[,-c(1,2,3)]
trans_copy <- trans_copy[,c(7,1:6)]
trans_copy
trans_copy[is.na(trans_copy),]
write_xlsx(trans_copy,"trans_copy.xlsx")

# 행정주소, 법정주소 연결시키기
relation_data <- read_excel("./행정법정동코드 연계자료.xlsx")
copy_relation_data <- relation_data[,-c(8,10,11,12)]
colnames(copy_relation_data) <- copy_relation_data[1,]
copy_relation_data <- copy_relation_data[-1,]

## 읍면동 데이터만 남기기
si_data_list <- grep("시$",copy_relation_data$법정동, value = 1)
gu_data_list <- grep("구$",copy_relation_data$법정동, value = 1)
gun_data_list <- grep("군$",copy_relation_data$법정동, value = 1)
ri_data_list <- grep("리$",copy_relation_data$법정동, value = 1)
do_data_list <- grep("도$",copy_relation_data$법정동, value = 1)
copy_relation_data <- copy_relation_data[!(copy_relation_data$법정동 %in% gu_data_list),]
copy_relation_data <- copy_relation_data[!(copy_relation_data$법정동 %in% gun_data_list),]
copy_relation_data <- copy_relation_data[!(copy_relation_data$법정동 %in% si_data_list),]
copy_relation_data <- copy_relation_data[!(copy_relation_data$법정동 %in% ri_data_list),]
copy_relation_data <- copy_relation_data[!(copy_relation_data$법정동 %in% do_data_list),]
copy_relation_data$법정동코드 <- floor(as.numeric(copy_relation_data$법정동코드)/100)
copy_relation_data$행정주소 <- paste(copy_relation_data$시도,copy_relation_data$시군구,
                                 copy_relation_data$행정구역명, rep ="")
copy_relation_data$법정동명 <- paste(copy_relation_data$시도,copy_relation_data$시군구,
                                 copy_relation_data$법정동, rep ="")
names(copy_relation_data)[8] <- "EMD_CD"
sum(duplicated(copy_relation_data))
write_xlsx(copy_relation_data,"copy_relation_data.xlsx")
## copy_relation_data 결측값 제거
copy_relation_data$행정구역코드[copy_relation_data$법정동 == "신수동" & copy_relation_data$시군구 == "사천시"] <- 0
copy2_relation_data <- na.omit(copy_relation_data) %>% as.data.frame()
sum(is.na(copy2_relation_data))

# join_data_4, copy_relation_data 합치기
join_data_EN_4$EMD_CD <- as.numeric(join_data_EN_4$EMD_CD)
final_data <- left_join(copy2_relation_data, join_data_EN_4, by ="EMD_CD")
final_data <- final_data[,-10]
names(final_data)[10] <- "법정동명"
write_xlsx(final_data,"final_data.xlsx")

trans_copy$행정주소 <- str_trim(trans_copy$행정주소, side = "right")
trans_copy$행정주소
final_data <- read_excel("./final_data.xlsx")
final_data_2 <- left_join(final_data, trans_copy, by ="행정주소")
write_xlsx(final_data_2,"1차가공완료데이터.xlsx")

final_data_3 <- left_join(trans_copy, final_data, by = "행정주소")
write_xlsx(final_data_3,"final_data_3.xlsx")
