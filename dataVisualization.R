library(ggplot2)

spread <- ggplot(data=iris, aes(x = Sepal.Length, y = Sepal.Width))
spread + geom_point(aes(color=Species, shape=Species)) +
  theme_bw()+
  xlab("Sepal Length") +  ylab("Sepal Width") +
  ggtitle("Sepal Length-Width")