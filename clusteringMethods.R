library(cluster)

nCenters = 3
irisData <- iris[,1:4]

clustering.kmeans <- function(nOfCenters) 
{
  clusterIRIS <- kmeans(irisData, centers = nOfCenters)
  return(clusterIRIS$cluster)
}

kmeans.result <- clustering.kmeans(nOfCenters = nCenters)

result <- iris
result <- cbind(result, kmeansssda = kmeans.result)