library(cluster)

nCenters = 6
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
