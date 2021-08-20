library(readxl)
library(writexl)
library(dplyr)

relation_data <- read_excel("./행정법정동코드 연계자료.xlsx")
copy_relation_data <- relation_data[,-c(8,10,11,12)]
colnames(copy_relation_data) <- copy_relation_data[1,]
copy_relation_data <- copy_relation_data[-1,]

# 읍면동 데이터만 남기기
si_data_list <- grep("시$",copy_relation_data$`행정동(행정기관명)`, value = 1)
gu_data_list <- grep("구$",copy_relation_data$`행정동(행정기관명)`, value = 1)
gun_data_list <- grep("군$",copy_relation_data$`행정동(행정기관명)`, value = 1)

copy_relation_data <- copy_relation_data[!(copy_relation_data$`행정동(행정기관명)` %in% gu_data_list),]
copy_relation_data <- copy_relation_data[!(copy_relation_data$`행정동(행정기관명)` %in% gun_data_list),]
copy_relation_data <- copy_relation_data[!(copy_relation_data$`행정동(행정기관명)` %in% si_data_list),]
copy_relation_data$법정동코드 <- floor(as.numeric(copy_relation_data$법정동코드)/100)
copy_relation_data$행정주소 <- paste(copy_relation_data$시도,copy_relation_data$시군구,
                                 copy_relation_data$행정구역명, rep ="")
copy_relation_data$법정동명 <- paste(copy_relation_data$시도,copy_relation_data$시군구,
                                 copy_relation_data$법정동, rep ="")
names(copy_relation_data)[8] <- "EMD_CD"
write_xlsx(copy_relation_data,"copy_relation_data.xlsx")

# 터미널유무 데이터
#bus_station <- read.csv("./터미널법정동.csv")
#bus_station_copy <- bus_station[,-c(1,2,3)]
#head(bus_station_copy)
#str(bus_station_copy)
#bus_station_copy$코드 <- floor(bus_station_copy$코드/100)
#names(bus_station_copy)[1] <- "EMD_CD"


# join_data_4, copy_relation_data 합치기
copy_relation_data <- read_excel("./copy_relation_data.xlsx") %>% as.data.frame()
final_data <- left_join(copy_relation_data, join_data_4, by ="법정동명")
final_data <- final_data[,-11]
names(final_data)[8] <- "EMD_CD"
final_data_2 <- left_join(final_data, trans_copy, by ="행정주소")
final_data_2 <- final_data_2[,-c(11,23)]
write_xlsx(final_data_2,"1차가공완료데이터.xlsx")
