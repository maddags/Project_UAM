library(rgdal)
library(ggplot2)
library(dplyr)
library(readxl)
library(writexl)

## url : https://datadoctorblog.com/2021/01/27/R-Vis-korea-map/

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

# 읍면동 풀주소 데이터 합치기
join_data <- left_join(df_code_address,map_list, by = "EMD_CD")
join_data <- join_data[,-3]

# join_data 결측값 채워넣기
data_list <- c(1885,1943,2116,2469,4005,4493,4494,4495,4496,4497,4498,4499,4500)
data_name <- c()
data_sido <- c()
for(i in c(1:13)){
  address_list <- strsplit(join_data$법정동명[data_list], split = " ")[[i]]
  while(length(address_list) > 1){
    address_list <- address_list[-1]
  }
  data_name <- c(data_name,address_list)
  data_sido <- floor(as.numeric(join_data$EMD_CD[data_list])/1000000)
}
join_data$SIDO[data_list] <- data_sido
join_data$EMD_KOR_NM[data_list] <- data_name
join_data$법정동명[1497] <- "세종특별자치시 산울동"
join_data$법정동명[1498] <- "세종특별자치시 해밀동"
join_data$법정동명[1499] <- "세종특별자치시 합강동"
join_data$법정동명[1500] <- "세종특별자치시 집현동"
join_data[is.na(join_data),]


# 공역 데이터 추가
gongyuk <- read.csv("./공역-법정동.csv")
gongyuk$법정동 <- floor(gongyuk$법정동/100)
names(gongyuk)[3] <- c("EMD_CD")
gongyuk$EMD_CD <- as.character(gongyuk$EMD_CD)
join_data_2 <- full_join(join_data,gongyuk, by = "EMD_CD")
duplicated_data <- join_data_2[duplicated(join_data_2$EMD_CD),] # 중복된 데이터

## join_data_2 결측값 처리
### 띄어쓰기 안된 데이터 띄어쓰기 하기
library(reticulate)
install_miniconda()
remotes::install_github("haven-jeon/KoSpacing",force = TRUE)
library(KoSpacing)
# 맨 처음에만 set_env()할것
#set_env()
address_list <- c()
for(i in c(1:length(duplicated_data$X.1))){
  address_list <- c(address_list,spacing(duplicated_data$X.1[i]))
}
address_list
address_list[36] <- "세종특별자치시 고운동"
address_list[37] <- "세종특별자치시 금남면"
address_list[38] <- "세종특별자치시 나성동"
address_list[39] <- "세종특별자치시 다정동"
address_list[40] <- "세종특별자치시 대평동"
address_list[41] <- "세종특별자치시 도담동"
address_list[42] <- "세종특별자치시 반곡동"
address_list[43] <- "세종특별자치시 보람동"
address_list[44] <- "세종특별자치시 부강면"
address_list[45] <- "세종특별자치시 산울동"
address_list[46] <- "세종특별자치시 새롬동"
address_list[47] <- "세종특별자치시 소담동"
address_list[48] <- "세종특별자치시 소정면"
address_list[49] <- "세종특별자치시 아름동"
address_list[50] <- "세종특별자치시 어진동"
address_list[51] <- "세종특별자치시 연기면"
address_list[52] <- "세종특별자치시 연동면"
address_list[53] <- "세종특별자치시 연서면"
address_list[54] <- "세종특별자치시 장군면"
address_list[55] <- "세종특별자치시 전동면"
address_list[56] <- "세종특별자치시 전의면"
address_list[57] <- "세종특별자치시 조치원읍"
address_list[58] <- "세종특별자치시 종촌동"
address_list[59] <- "세종특별자치시 집현동"
address_list[60] <- "세종특별자치시 한솔동"
address_list[61] <- "세종특별자치시 합강동"
address_list[62] <- "세종특별자치시 해밀동"
address_list[63] <- "경기도 수원시 권선구 곡반정동"
address_list[79] <- "경기도 수원시 영통구 매탄동"
address_list[89] <- "경기도 수원시 장안구 율전동"
address_list[105] <- "경기도 수원시 팔달구 매향동"
address_list[110] <- "경기도 수원시 팔달구 인계동"
address_list[136] <- "경기도 성남시 수정구 단대동"
address_list[141] <- "경기도 성남시 수정구 상적동"
address_list[159] <- "경기도 성남시 중원구 하대원동"
address_list[163] <- "경기도 안양시 만안구 박달동"
address_list[164] <- "경기도 안양시 만안구 석수동"
address_list[165] <- "경기도 안양시 만안구 안양동"
address_list[169] <- "경기도 안산시 단원구 대부동동"
address_list[176] <- "경기도 안산시 단원구 와동"
address_list[182] <- "경기도 안산시 상록구 건건동"
address_list[186] <- "경기도 안산시 상록구 사사동"
address_list[187] <- "경기도 안산시 상록구 성포동"
address_list[193] <- "경기도 안산시 상록구 장상동"
address_list[194] <- "경기도 안산시 상록구 장하동"
address_list[200] <- "경기도 고양시 덕양구 내유동"
address_list[204] <- "경기도 고양시 덕양구 도내동"
address_list[210] <- "경기도 고양시 덕양구 성사동"
address_list[221] <- "경기도 고양시 덕양구 행주내동"
address_list[222] <- "경기도 고양시 덕양구 행주외동"
address_list[223] <- "경기도 고양시 덕양구 향동동"
address_list[234] <- "경기도 고양시 일산동구 성석동"
address_list[257] <- "경기도 용인시 기흥구 상갈동"
address_list[265] <- "경기도 용인시 기흥구 청덕동"
address_list[270] <- "경기도 용인시 수지구 성복동"
address_list[283] <- "경기도 용인시 처인구 역북동"
address_list[290] <- "경기도 용인시 처인구 호동"
address_list[292] <- "경기도 파주시 당하동"
address_list[314] <- "충청북도 청주시 상당구 남문로1가"
address_list[315] <- "충청북도 청주시 상당구 남문로2가"
address_list[351] <- "충청북도 청주시 서원구 성화동"
address_list[373] <- "충청북도 청주시 흥덕구 가경동"
address_list[429] <- "충청북도 충주시 용탄동"
address_list[434] <- "충청남도 천안시 동남구 동면"
address_list[436] <- "충청남도 천안시 동남구 문화동"
address_list[454] <- "충청남도 천안시 동남구 청당동"
address_list[455] <- "충청남도 천안시 동남구 청수동"
address_list[468] <- "충청남도 천안시 서북구 와촌동"
address_list[476] <- "전라북도 전주시 덕진구 덕진동1가"
address_list[477] <- "전라북도 전주시 덕진구 덕진동2가"
address_list[484] <- "전라북도 전주시 덕진구 송천동1가"
address_list[485] <- "전라북도 전주시 덕진구 송천동2가"
address_list[487] <- "전라북도 전주시 덕진구 여의동2가"
address_list[496] <- "전라북도 전주시 덕진구 전미동1가"
address_list[497] <- "전라북도 전주시 덕진구 전미동2가"
address_list[500] <- "전라북도 전주시 덕진구 팔복동1가"
address_list[501] <- "전라북도 전주시 덕진구 팔복동2가"
address_list[502] <- "전라북도 전주시 덕진구 팔복동3가"
address_list[503] <- "전라북도 전주시 덕진구 팔복동4가"
address_list[504] <- "전라북도 전주시 덕진구 호성동1가"
address_list[506] <- "전라북도 전주시 덕진구 호성동3가"
address_list[508] <- "전라북도 전주시 완산구 경원동1가"
address_list[509] <- "전라북도 전주시 완산구 경원동2가"
address_list[510] <- "전라북도 전주시 완산구 경원동3가"
address_list[521] <- "전라북도 전주시 완산구 삼천동1가"
address_list[522] <- "전라북도 전주시 완산구 삼천동2가"
address_list[529] <- "전라북도 전주시 완산구 서완산동1가"
address_list[536] <- "전라북도 전주시 완산구 중노송동"
address_list[537] <- "전라북도 전주시 완산구 중앙동1가"
address_list[538] <- "전라북도 전주시 완산구 중앙동2가"
address_list[539] <- "전라북도 전주시 완산구 중앙동3가"
address_list[540] <- "전라북도 전주시 완산구 중앙동4가"
address_list[541] <- "전라북도 전주시 완산구 중인동"
address_list[542] <- "전라북도 전주시 완산구 중화산동1가"
address_list[543] <- "전라북도 전주시 완산구 중화산동2가"
address_list[548] <- "전라북도 전주시 완산구 풍남동1가"
address_list[550] <- "전라북도 전주시 완산구 풍남동3가"
address_list[553] <- "전라북도 전주시 완산구 효자동3가"
address_list[555] <- "경상북도 포항시 남구 대도동"
address_list[556] <- "경상북도 포항시 남구 대송면"
address_list[567] <- "경상북도 포항시 남구 인덕동"
address_list[572] <- "경상북도 포항시 남구 청림동"
address_list[601] <- "경상북도 포항시 북구 청하면"
address_list[604] <- "경상북도 포항시 북구 항구동"
address_list[614] <- "경상남도 창원시 마산합포구 대성동1가"
address_list[633] <- "경상남도 창원시 마산합포구 신포동1가"
address_list[634] <- "경상남도 창원시 마산합포구 신포동2가"
address_list[648] <- "경상남도 창원시 마산합포구 자산동"
address_list[649] <- "경상남도 창원시 마산합포구 장군동1가"
address_list[650] <- "경상남도 창원시 마산합포구 장군동2가"
address_list[651] <- "경상남도 창원시 마산합포구 장군동3가"
address_list[654] <- "경상남도 창원시 마산합포구 중성동"
address_list[655] <- "경상남도 창원시 마산합포구 중앙동1가"
address_list[656] <- "경상남도 창원시 마산합포구 중앙동2가"
address_list[657] <- "경상남도 창원시 마산합포구 중앙동3가"
address_list[662] <- "경상남도 창원시 마산합포구 창포동1가"
address_list[663] <- "경상남도 창원시 마산합포구 창포동2가"
address_list[664] <- "경상남도 창원시 마산합포구 창포동3가"
address_list[665] <- "경상남도 창원시 마산합포구 청계동"
address_list[676] <- "경상남도 창원시 마산회원구 석전동"
address_list[682] <- "경상남도 창원시 성산구 가음정동"
address_list[716] <- "경상남도 창원시 성산구 적현동"
address_list[722] <- "경상남도 창원시 의창구 내리동"
address_list[723] <- "경상남도 창원시 의창구 대산면"
address_list[747] <- "경상남도 창원시 진해구 가주동"
address_list[760] <- "경상남도 창원시 진해구 도만동"
address_list[761] <- "경상남도 창원시 진해구 도청동"
address_list[763] <- "경상남도 창원시 진해구 두동"
address_list[769] <- "경상남도 창원시 진해구 비봉동"
address_list[772] <- "경상남도 창원시 진해구 성내동"
address_list[774] <- "경상남도 창원시 진해구 속천동"
address_list[789] <- "경상남도 창원시 진해구 익선동"
address_list[791] <- "경상남도 창원시 진해구 인의동"
address_list[792] <- "경상남도 창원시 진해구 자은동"
address_list[798] <- "경상남도 창원시 진해구 중평동"
address_list[800] <- "경상남도 창원시 진해구 청안동"
address_list[814] <- "경상남도 김해시 장유동"
address_list

### 변수 x.1의 NA값 채워넣기 
duplicated_data$법정동명 <- address_list
for(i in c(1:length(join_data_2$법정동명))){
  if(is.na(join_data_2$X.1)[i] == TRUE){
    join_data_2$X.1[i] <- join_data_2$법정동명[i]
  }
}

### 변수 비행불가능여부 NA값 채워넣기
test2 <- inner_join(join_data_2,duplicated_data, by = "법정동명")
test2 <- test2[,c(1,2,3,4,7,11,13)]
test3 <- test2[duplicated(test2$EMD_CD),] # test2의 중복으로 있는 데이터
test4 <- test2[-as.numeric(rownames(test3)),]
join_data_2 <- join_data_2[-as.numeric(rownames(duplicated_data)),]
join_data_2[join_data_2$법정동명 %in% test4$법정동명,]$비행불가능여부 <- test4$비행불가능여부.y
join_data_2[is.na(join_data_2$비행불가능여부),] 
join_data_3 <- join_data_2[,-c(5,6)]
write_xlsx(join_data_3,"검토.xlsx")

# 터미널유무 데이터
bus_station <- read.csv("./터미널법정동.csv")
bus_station_copy <- bus_station[,-c(1,2,3)]
head(bus_station_copy)
str(bus_station_copy)
bus_station_copy$코드 <- floor(bus_station_copy$코드/100)
names(bus_station_copy)[1] <- "EMD_CD"
bus_station_copy$EMD_CD <- as.character(bus_station_copy$EMD_CD)
bus_join_data <- left_join(join_data_3, bus_station_copy, by ="EMD_CD")
write_xlsx(bus_join_data,"bus_join_data.xlsx")
bus_join_data <- read_excel("./bus_join_data.xlsx") %>% as.data.frame()
bus_join_data<-bus_join_data[!(duplicated(bus_join_data$법정동명)),]
bus_join_data$터미널유무[is.na(bus_join_data$터미널유무)] <- 0 


## 최종건축면적 데이터 추가
buji <- read.csv("./최종건축면적-법정동.csv")
buji_copy <- buji[,-c(2,3,4,6,7,9:16)]
names(buji_copy)[2] <- c("EMD_CD")
names(buji_copy)[3] <- c("건축면적")
buji_copy$EMD_CD <- floor(buji_copy$EMD_CD/100)
buji_copy$EMD_CD <- as.character(buji_copy$EMD_CD)
buji_copy[is.na(buji_copy),]
View(buji_copy)
join_data_4 <- left_join(bus_join_data,buji_copy, by = "EMD_CD")
join_data_4$종류[is.na(join_data_4$종류)] <- "없음"
join_data_4$건축면적[is.na(join_data_4$건축면적)] <- 0
# write_xlsx(join_data_4,"검토.xlsx")
#length(join_data_4$법정동명) - sum(duplicated(join_data_4$법정동명))



# 교통혼잡,인구수 데이터 합치기
trans <- read_excel("./2018 리뉴얼.xlsx")
trans <- as.data.frame(trans)
trans_copy <- trans[,-c(1,12)]
trans_copy$행정주소 <- paste(trans_copy$`도/광역시/시`,trans_copy$시군구,trans_copy$읍면동,
                   rep = " ")
trans_copy <- trans_copy[,-c(1,2,3)]
trans_copy <- trans_copy[,c(8,1:7)]
trans_copy
write_xlsx(trans_copy,"trans_copy.xlsx")

# 행정코드와 법정코드 합치기
trans_copy <-  read_excel("./trans_copy.xlsx") %>% as.data.frame(trans_copy)
# join_data_4, copy_relation_data 합치기
copy_relation_data <- read_excel("./copy_relation_data.xlsx") %>% as.data.frame()
final_data <- left_join(copy_relation_data, join_data_4, by ="법정동명")
final_data <- final_data[,-11]
names(final_data)[8] <- "EMD_CD"
final_data_2 <- left_join(final_data, trans_copy, by ="행정주소")
final_data_2 <- final_data_2[,-c(11,23)]
write_xlsx(final_data_2,"1차가공완료데이터.xlsx")