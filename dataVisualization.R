library(ggplot2)

visualize.before <- function()
{
  spread <- ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width))
  spread + geom_point(aes(color=Species, shape=Species)) +
    theme_bw()+
    xlab("Sepal Length") +  ylab("Sepal Width") +
    ggtitle("Sepal Length-Width")
}

visualize.result <- function(data, dataColumn)
{
  scatter <- ggplot(data=data, aes(x = Sepal.Length, y = Sepal.Width))
  scatter + geom_point(aes(color=paste("Cluster", dataColumn), shape=19)) +
    scale_shape_identity()+
    theme_bw()+
    xlab("Sepal Length") +  ylab("Sepal Width") +
    ggtitle("Sepal Length-Width") + 
    labs(color = "Clusters")
}

visualize.clusplot <- function (data)
{
  clusplot(data, data$Kmeans, color = TRUE, shade = TRUE, lines = 0, main = "Cluster plot")
}