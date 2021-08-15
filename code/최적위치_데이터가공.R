library(dplyr)
library(MASS)

data <- read.csv("./2015년_버스노선별_정류장별_시간대별_승하차_인원_정보.csv")
data <- as.data.frame(data)

data$use_mon.value

data %>% group_by(use_mon) %>% summarise(n = n()) 

