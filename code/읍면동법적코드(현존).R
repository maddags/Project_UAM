library(readxl)
library(writexl)

data <- read_excel("./법정동코드 전체자료.xlsx")

new_data <- data[data$폐지여부 == "존재",]
new_data


write_xlsx(new_data,"읍면동법적코드.xlsx")
