library(ggplot2)

visualize.before <- function(x, y, xLabel, yLabel, title)
{
  spread <- ggplot(data = iris, aes(x = x, y = y))
  spread + geom_point(aes(color=Species, shape=Species)) +
    theme_bw()+
    theme(legend.position = "bottom") +
    xlab(xLabel) +  ylab(yLabel) +
    ggtitle(title)
}

visualize.result <- function(data, x, y, xLabel, yLabel, dataColumn, title)
{
  scatter <- ggplot(data=data, aes(x = x, y = y))
  scatter + geom_point(aes(color=paste("Cluster", dataColumn), shape=19)) +
    scale_shape_identity()+
    theme_bw()+
    theme(legend.position = "bottom") +
    xlab(xLabel) +  ylab(yLabel) +
    ggtitle(title) + 
    labs(color = "Clusters")
}

visualize.clusplot <- function (data, dataColumn)
{
  clusplot(data, dataColumn, color = TRUE, shade = TRUE, lines = 0, main = "Cluster plot")
}

#theme(legend.position = "bottom") +