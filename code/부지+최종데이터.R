library(rgdal)
library(ggplot2)
library(dplyr)
library(readxl)
library(writexl)
library(stringr)

fourth_data <- read_excel("./3차가공데이터_수정+기차역추가.xlsx")


# 최종건축면적 데이터 변수 추가
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

## 중복된 데이터 제거
buji_emart <- buji_copy[buji_copy$종류 == "이마트",]
buji_emart <- buji_emart[!duplicated(buji_emart$EMD_CD),]
buji_hp <- buji_copy[buji_copy$종류 == "홈플러스",]
buji_hp <- buji_hp[!duplicated(buji_hp$EMD_CD),]
buji_lotte <- buji_copy[buji_copy$종류 == "롯데마트",]
buji_lotte <- buji_lotte[!duplicated(buji_lotte$EMD_CD),]
buji_hyeondai <- buji_copy[buji_copy$종류 == "현대백화점",]
buji_hyeondai <- buji_hyeondai[!duplicated(buji_hyeondai$EMD_CD),]
buji_no_duplicated_data <- rbind(buji_emart,buji_hp,buji_lotte,buji_hyeondai) 
buji_no_duplicated_data[duplicated(buji_no_duplicated_data$EMD_CD),]

## 결측값 제거 : 데이터를 못 구해서 제거
buji_no_na <- buji_no_duplicated_data[!is.na(buji_no_duplicated_data$건축면적),]
write_xlsx(buji_no_na,"buji_no_na.xlsx")


# 4차 가공 데이터(3차가공데이터에 na값 조사 및 기차역변수 추가)
buji_biggest <- read_excel("./buji_biggest.xlsx")
sum(duplicated(buji_biggest))
last_data <- left_join(fourth_data, buji_biggest[,c(2,4)] , by = "EMD_CD")
last_data$면적15k여부[is.na(last_data$면적15k여부)] <- 0
write_xlsx(last_data, "last_data.xlsx")
