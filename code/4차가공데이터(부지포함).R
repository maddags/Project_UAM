library(readxl)
library(writexl)
library(dplyr)

# 면적 15,000m^2 이상 여부 데이터 추가하기
third_data <- read_excel("./3차가공데이터_수정+기차역추가.xlsx")
buji <- read.csv("./15k_area_2.csv") %>% as.data.frame()
buji <- buji[,c(1,4)]

# third_data, buji 데이터 합치기기
fourth_data <- left_join(third_data,buji, by = "EMD_CD")
View(fourth_data[is.na(fourth_data$면적15k이),])

# NA값 제거(map_list에 없는 부분)
fourth_data_copy <- fourth_data[!is.na(fourth_data$면적15k이),]
sum(is.na(fourth_data_copy$면적15k이))
colnames(fourth_data_copy)[c(15,16)] <- c("기차역(ktx역포함)여부","면적15k이상건물여부")
colnames(fourth_data_copy)

write_xlsx(fourth_data_copy,"4차가공데이터.xlsx")
