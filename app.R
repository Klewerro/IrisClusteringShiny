#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

source("clusteringMethods.R")
source("supportMethods.R")
source("dataVisualization.R")


selectItems.vector <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")
plotHeight <- 700

generate.title <- function(x, y, afterClustering = FALSE) {
    if (!afterClustering) {
        return(paste(x, "-", y, "(Before clustering)"))
    }
    
    return(paste(x, "-", y, "(After clustering)"))
}


# UI
ui <- fluidPage(
    
    # Application title
    
    titlePanel("Iris clustering"),
    fluidRow(
        column(4, sliderInput("nOfClustersSlider", 
                              "Number of clusters",
                              min = 1,
                              max = 12,
                              value = 3)),
        column(4, selectInput("xattributeSelect", 
                              "First attribute (x)", 
                              selectItems.vector)),
        column(4, selectInput("yattributeSelect", "Second attribute (y)", 
                              selectItems.vector, 
                              selected = selectItems.vector[2]))
    ),
    
    hr(),
    
    tabsetPanel(
        tabPanel("Comparison plot", fluidRow(
                     column(6, plotOutput("plotBefore", height = plotHeight)),
                     column(6, plotOutput("plotAfter", height = plotHeight)),
                     
        )),
        tabPanel("Cluster plot", plotOutput("plotClusterVisualization", height = plotHeight)),
        tabPanel("Table data", tableOutput("tableData"), align = "center")
    )

)

# Server logic
server <- function(input, output) {
    # At start
    result <- iris
    kmeans.result <- clustering.kmeans(nOfCenters = 3)
    result <- cbind(result, Kmeans = kmeans.result)
    
    
    # OUTPUTS
    output$plotBefore <- renderPlot({
        selectedX <- input$xattributeSelect
        selectedY <- input$yattributeSelect
        xs <- result[, selectedX]
        ys <- result[, selectedY]
        
        if (selectedX == selectedY) {
            showNotification("Axes must be unique", 
                             type = "error", 
                             duration = 3)
            return()
        }
        
        visualize.before(x = xs, y = ys, 
                         xLabel = selectedX, yLabel = selectedY,
                         title = generate.title(selectedX, selectedY))
    })
    
    output$plotAfter <- renderPlot({
        result$Kmeans <- clustering.kmeans(nOfCenters = input$nOfClustersSlider)
        
        selectedX <- input$xattributeSelect
        selectedY <- input$yattributeSelect
        xs <- result[, selectedX]
        ys <- result[, selectedY]
        
        if (selectedX == selectedY) {
            return()
        }
        
        visualize.result(data = result, 
                         x = xs, y = ys,
                         xLabel = selectedX, yLabel = selectedY,
                         dataColumn = result$Kmeans,
                         title = generate.title(selectedX, selectedY, afterClustering = TRUE))
        
    })
    
    output$plotClusterVisualization <- renderPlot({
        result$Kmeans <- clustering.kmeans(nOfCenters = input$nOfClustersSlider)
        visualize.clusplot(result)
    })
    
    output$tableData <- renderTable(resultReactive(), 
                                    rownames = TRUE, 
                                    colnames = TRUE)
    
    
    # EVENTS
    resultReactive <- eventReactive(input$nOfClustersSlider, {
        result$Kmeans <- clustering.kmeans(nOfCenters = input$nOfClustersSlider)
        return(result)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
