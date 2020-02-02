source("clusteringMethods.R")
source("supportMethods.R")
source("dataVisualization.R")

# Prepare
METRICS <- get.metrics.enum()

# Run algorithms
kmeans.result <- clustering.kmeans(nOfCenters = nCenters)
agnes.result.manhattan <- clustering.agnes(metric = METRICS$MANHATTAN)
agnes.result.euclidean <- clustering.agnes(metric = METRICS$EUCLIDEAN)
diana.result.manhattan <- clustering.diana(metric = METRICS$MANHATTAN)
diana.result.euclidean <- clustering.diana(metric = METRICS$EUCLIDEAN)

# Bind results to table
result <- iris
result <- cbind(result, Kmeans = kmeans.result)
result <- cbind(result, agnes.man = agnes.result.manhattan)
result <- cbind(result, agnes.euc = agnes.result.euclidean)
result <- cbind(result, diana.man = diana.result.manhattan)
result <- cbind(result, diana.euc = diana.result.euclidean)

#visualize.new(result, result$Kmeans)

visualize.before()
visualize.result(data = result, dataColumn = result$Kmeans)
visualize.clusplot(result)








