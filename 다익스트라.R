# 필요한 패키지
install.packages("igraph")
install.packages("gcookbook")
# Network 분석/ 시각화 패키지
library(gcookbook)
library(igraph)

a = c(0,2,4,NA,NA,NA,NA)
b = c(2,0,2,NA,NA,NA,NA)
c = c(4,2,0,2,NA,NA,NA)
d = c(NA,NA,2,5,2,4,6)
e = c(NA,NA,NA,2,0,2,4)
f = c(NA,NA,NA,4,2,0,2)
g = c(NA,NA,NA,6,4,2,0)


data <- matrix(c(a,b,c,d,e,f,g), nrow = 7, byrow = T )
colnames(data) <- c("a","b","c","d","e","f","g")
rownames(data) <- c("a","b","c","d","e","f","g")
data[is.na(data)] <- 0
data

dist1 <- graph.adjacency(data, weighted = TRUE)
dist1


s.paths <- shortest.paths(dist1, algorithm = "dijkstra")
data
dist1
s.paths
plot(dist1)


######
#print_all(data) : 루트 볼 때
print_all(dist1)
