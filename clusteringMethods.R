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

# Divisive hierarchical (top-down)
clustering.diana <- function(metric)
{
  cl.diana <- diana(x = iris, metric = metric)
  plot(cl.diana, which.plots = 2)
  result <- cutree(cl.diana, 3)
  
  return(result)
}

METRICS <- get.metrics.enum()
kmeans.result <- clustering.kmeans(nOfCenters = nCenters)
agnes.result.manhattan <- clustering.agnes(metric = METRICS$MANHATTAN)
agnes.result.euclidean <- clustering.agnes(metric = METRICS$EUCLIDEAN)
diana.result.manhattan <- clustering.diana(metric = METRICS$MANHATTAN)
diana.result.euclidean <- clustering.diana(metric = METRICS$EUCLIDEAN)

result <- iris
result <- cbind(result, kmeans = kmeans.result)
result <- cbind(result, agnes.man = agnes.result.manhattan)
result <- cbind(result, agnes.euc = agnes.result.euclidean)
result <- cbind(result, diana.man = diana.result.manhattan)
result <- cbind(result, diana.euc = diana.result.euclidean)
