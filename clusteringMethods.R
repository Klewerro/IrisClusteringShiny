library(cluster)

irisData <- iris[,1:4]

clustering.kmeans <- function(nOfCenters) 
{
  clusterIRIS <- kmeans(irisData, centers = nOfCenters)
  return(clusterIRIS$cluster)
}

# HIERARHIC CLUSTERING

# Agglomerative (bottom-up)
clustering.agnes <- function(metric, cutreeLevel = 3)
{
  cl.agnes <- agnes(x = iris, metric = metric, method = "single")
  plot(cl.agnes, which.plots = 2)
  result <- cutree(cl.agnes, cutreeLevel)
  
  return(result)
}

# Divisive hierarchical (top-down)
clustering.diana <- function(metric, cutreeLevel = 3)
{
  cl.diana <- diana(x = iris, metric = metric)
  plot(cl.diana, which.plots = 2)
  result <- cutree(cl.diana, cutreeLevel)
  
  return(result)
}
