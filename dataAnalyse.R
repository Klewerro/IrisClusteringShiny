library(NbClust)

irisData <- iris[,1:4]
totalwSS<-c()

# 1. kmeans clustering for 15 times in a loop
for (i in 1:15)
{
  clusterIRIS <- kmeans(irisData, centers=i)    
  totalwSS[i]<-clusterIRIS$tot.withinss  #sum of squares per cluster
}

plot(x=1:15,
     y=totalwSS,
     type="b",
     xlab="Number of Clusters",
     ylab="Within groups sum-of-squares")

#  For kmeans, best number of clusters is 2
#  3 clusters will have around 0.65 accuarcy
nb.kmeans <- NbClust(irisData, method = "kmeans")
