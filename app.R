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

init <- function() {
    result <- iris
    kmeans.result <- clustering.kmeans(nOfCenters = nCenters)
    result <- cbind(result, Kmeans = kmeans.result)
}

generate.title <- function(x, y) {
    return(paste(x, "-", y))
}


# UI
ui <- fluidPage(
    
    # Application title
    titlePanel("Iris clustering"),

    sidebarLayout(
        sidebarPanel(
            selectInput("xattributeSelect", 
                        "First attribute (x)", 
                        selectItems.vector),
            selectInput("yattributeSelect", "Second attribute", 
                        selectItems.vector, 
                        selected = selectItems.vector[2]),
            actionButton("button", "Clusterize")
        ),

        mainPanel(
           plotOutput("plotBefore"),
           plotOutput("plotAfter"),
           tableOutput("tableData")
        )
    )
)

# Server logic
server <- function(input, output) {
    # At start
    init()
    
    
    # EVENTS

    
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
        
        #visualize.before(x = result$Sepal.Length, y = result$Sepal.Width, 
        #                 xLabel = input$xattributeSelect, yLabel = input$yattributeSelect,
        #                 title = generate.title(input$xattributeSelect, input$yattributeSelect))
        
        visualize.result(data = result, 
                         x = xs, y = ys,
                         xLabel = selectedX, yLabel = selectedY,
                         dataColumn = result$Kmeans,
                         title = generate.title(selectedX, selectedY))
    })
    
    output$tableData <- renderTable(result, 
                                    rownames = TRUE, 
                                    colnames = TRUE)

}

# Run the application 
shinyApp(ui = ui, server = server)
