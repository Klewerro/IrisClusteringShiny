silhouette.avg.kmeans <- function() 
{
  results <- c(0,0,0,0,0,0,0,0,0)
  sum <- 0
  for (i in 2:11) 
  {
    irisData <- iris[,1:4]
    clusterIRIS <- kmeans(irisData, centers = i)
    
    klastry <- clusterIRIS$cluster
    ss <- silhouette(klastry, dist(irisData))
    average <- mean(ss[,3])
    
    results[i - 1] <- average 
    sum <-sum + average 
  }
  
  averageKmeans <- sum / 10
  return(averageKmeans)
}

silhouette.kmeans <- function(nOfClusters) 
{
  irisData <- iris[,1:4]
  clusterIRIS <- kmeans(irisData, centers = nOfClusters)
  
  klastry <- clusterIRIS$cluster
  ss <- silhouette(klastry, dist(irisData))
  average <- mean(ss[,3])
  
}


results <- c(0,0,0,0,0,0,0,0,0)
sum <- 0
for (i in 2:11) 
{
  irisData <- iris[,1:4]
  clusterIRIS <- kmeans(irisData, centers = i)
  
  klastry <- clusterIRIS$cluster
  ss <- silhouette(klastry, dist(irisData))
  average <- mean(ss[,3])
  
  results[i - 1] <- average 
  sum <-sum + average 
}
averageKmeans <- sum / 10
silhouette.kmeans.array <- results
plot(silhouette.kmeans.array)
title("silhouette kmeans")

sum <- 0
for (i in 2:11) 
{
  cl.agnes <- agnes(x = iris, metric = "euclidean", method = "single")
  klastry <- cutree(cl.agnes, i)
  ss <- silhouette(klastry, dist(irisData))
  average <- mean(ss[,3])
  
  results[i - 1] <- average 
  sum <-sum + average 
}
averageAgnes <- sum / 10
plot(results)
title("silhouette agnes euclidean")

sum <- 0
for (i in 2:11) 
{
  cl.agnes <- agnes(x = iris, metric = "manhattan", method = "single")
  klastry <- cutree(cl.agnes, i)
  ss <- silhouette(klastry, dist(irisData))
  average <- mean(ss[,3])
  
  results[i - 1] <- average 
  sum <-sum + average 
}
averageAgnesManhattan <- sum / 10
plot(results)
title("silhouette agnes manhattan")

sum <- 0
for (i in 2:11) 
{
  cl.diana <- diana(x = iris, metric = "euclidean")
  klastry <- cutree(cl.diana, i)
  ss <- silhouette(klastry, dist(irisData))
  average <- mean(ss[,3])
  
  results[i - 1] <- average 
  sum <-sum + average 
}
averageDiana <- sum / 10
plot(results)
title("silhouette diana euclidean")

sum <- 0
for (i in 2:11) 
{
  cl.diana <- diana(x = iris, metric = "manhattan")
  klastry <- cutree(cl.diana, i)
  ss <- silhouette(klastry, dist(irisData))
  average <- mean(ss[,3])
  
  results[i - 1] <- average 
  sum <-sum + average 
}
averageDianaManhattan <- sum / 10
plot(results)
title("silhouette diana manhattan")

averageFrame <- data.frame(averageKmeans, averageAgnes, averageAgnesManhattan, averageDiana, averageDianaManhattan)
names(averageFrame) <- c("kmeans", "agnes", "agnes.man", "diana", "diana.man")
