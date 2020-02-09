source("clusteringMethods.R")
source("supportMethods.R")
source("dataVisualization.R")

# Prepare
METRICS <- get.metrics.enum()

# Run algorithms
kmeans.result <- clustering.kmeans(nOfCenters = 3)
agnes.result.manhattan <- clustering.agnes(metric = METRICS$MANHATTAN, cutreeLevel = 6)
agnes.result.euclidean <- clustering.agnes(metric = METRICS$EUCLIDEAN, cutreeLevel = 6)
diana.result.manhattan <- clustering.diana(metric = METRICS$MANHATTAN)
diana.result.euclidean <- clustering.diana(metric = METRICS$EUCLIDEAN)

# Bind results to table
result <- iris
result <- cbind(result, Kmeans = kmeans.result)
result <- cbind(result, agnes.man = agnes.result.manhattan)
result <- cbind(result, agnes.euc = agnes.result.euclidean)
result <- cbind(result, diana.man = diana.result.manhattan)
result <- cbind(result, diana.euc = diana.result.euclidean)

visualize.before(x = result$Sepal.Length, y = result$Sepal.Width, 
                 xLabel = "Sepal Length", yLabel = "Sepal Width",
                 title = "Sepal Length-Width")
visualize.result(data = result, 
                 x =result$Sepal.Length, y = result$Sepal.Width, 
                 xLabel = "Sepal Length", yLabel = "Sepal Width",
                 dataColumn = result$Kmeans,
                 title = "Sepal Length-Width")
visualize.clusplot(result, result$Kmeans)


#Clusplot for all approaches
clusplot(result, result$Kmeans, color = TRUE, shade = TRUE, lines = 0, main = "Cluster Kmeans")
clusplot(result, result$agnes.man, color = TRUE, shade = TRUE, lines = 0, main = "Cluster agnes.man")
clusplot(result, result$agnes.euc, color = TRUE, shade = TRUE, lines = 0, main = "Cluster agnes.euc")
clusplot(result, result$diana.man, color = TRUE, shade = TRUE, lines = 0, main = "Cluster diana.man")
clusplot(result, result$diana.euc, color = TRUE, shade = TRUE, lines = 0, main = "Cluster diana.euc")
