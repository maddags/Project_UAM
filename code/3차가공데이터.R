library(rgdal)
library(ggplot2)
library(dplyr)
library(readxl)
library(writexl)
library(stringr)


second_data <- read_excel("./2차가공데이터_ver2.xlsx")
sum(duplicated(second_data$EMD_CD))
sum(is.na(second_data$승용차))
sum(is.na(second_data$비행불가능여부))
sum(is.na(second_data))

View(second_data[duplicated(second_data$EMD_CD),])
third_data <- second_data[!duplicated(second_data$EMD_CD),]
sum(duplicated(third_data))
sum(is.na(third_data))
sum(is.na(third_data$비행불가능여부))
sum(is.na(third_data$승용차))

# 아예 관측을 안한 데이터 제거
third_copy_data <- third_data[third_data$행정주소 == third_data$법정동주소,]
no_reserve_data_list <-third_copy_data[is.na(third_copy_data$승용차),]
third_propressed_data <- third_data[!(third_data$EMD_CD %in% no_reserve_data_list$EMD_CD),]

# 행정주소와 법정동주소 같지 않은 데이터 제거
## 주소만 알면 값을 추가할 수 있음(third_propressed_data에다 추가하면된다)
third_no_na_data <- third_data[!is.na(third_data$승용차),]
write_xlsx(third_no_na_data,"3차가공데이터.xlsx")

