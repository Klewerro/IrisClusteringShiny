library(cluster)
source("supportMethods.R")

nCenters = 3
irisData <- iris[,1:4]

clustering.kmeans <- function(nOfCenters) 
{
  clusterIRIS <- kmeans(irisData, centers = nOfCenters)
  return(clusterIRIS$cluster)
}

# HIERARHIC CLUSTERING

# Agglomerative (bottom-up)
clustering.agnes <- function(metric)
{
  cl.agnes <- agnes(x = iris, metric = metric, method = "single")
  plot(cl.agnes, which.plots = 2)
  result <- cutree(cl.agnes, 3)
  
  return(result)
}

METRICS <- get.metrics.enum()
kmeans.result <- clustering.kmeans(nOfCenters = nCenters)
agnes.result.manhattan <- clustering.agnes(metric = METRICS$MANHATTAN)
agnes.result.euclidean <- clustering.agnes(metric = METRICS$EUCLIDEAN)

result <- iris
result <- cbind(result, kmeans = kmeans.result)
result <- cbind(result, agnes.man = agnes.result.manhattan)
result <- cbind(result, agnes.euc = agnes.result.euclidean)
