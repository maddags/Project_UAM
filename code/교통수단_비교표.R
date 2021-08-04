library(openxlsx)
library(ggplot2)


data <- read.xlsx("./교통수단.xlsx")
View(data)

colnames(data) <- c("종류","서울역","서울역_소요시간","서울역_비용",
                    "강남역","강남역_소요시간","강남역_비용",
                    "여의도역","여의도역_소요시간","여의도역_비용")

ggplot(data,mapping = aes(x=reorder(종류,서울역_비용), y = 서울역_비용,fill = 서울역_소요시간)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(x = "교통수단", y = expression("비용"["(원)"])) +
  ggtitle("서울역-인천공항") +
  theme(plot.title = element_text(size = 13, face = "bold",hjust = 0.5, color = "black"))+
  theme(legend.position = c(0.1,0.8)) +
  geom_text(aes(label = 서울역_비용), vjust = -0.2, size = 4) +
  scale_fill_gradient(low = "grey" , high ="black")
  

ggplot(data,mapping = aes(x=reorder(종류,강남역_비용), y = 강남역_비용, fill = 강남역_소요시간)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(x = "교통수단", y = expression("비용"["(원)"])) +
  ggtitle("강남역-인천공항") +
  theme(plot.title = element_text(size = 13, face = "bold",hjust = 0.5, color = "black"))+
  theme(legend.position = c(0.1,0.8)) +
  geom_text(aes(label = 강남역_비용), vjust = -0.2, size = 4) +
  scale_fill_gradient(low = "grey" , high ="black")


ggplot(data,mapping = aes(x=reorder(종류,여의도역_비용), y = 여의도역_비용, fill = 여의도역_소요시간)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(x = "교통수단", y = expression("비용"["(원)"])) +
  ggtitle("여의도역-인천공항") +
  theme(plot.title = element_text(size = 13, face = "bold",hjust = 0.5, color = "black"))+
  theme(legend.position = c(0.1,0.8)) +
  geom_text(aes(label = 여의도역_비용), vjust = -0.2, size = 4) +
  scale_fill_gradient(low = "grey" , high ="black")



