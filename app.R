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

# UI
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    sidebarLayout(
        sidebarPanel(
            selectInput("xattribute", "First attribute (x)", c("Sepal Length", "Sepal Width", "Petal Length", "Petal Width")),
            selectInput("yattribute", "Second attribute", c("Sepal Length", "Sepal Width", "Petal Length", "Petal Width")),
            actionButton("button", "Clusterize")
        ),

        mainPanel(
           plotOutput("distPlot"),
           tableOutput("tableData")
        )
    )
)

# Server logic
server <- function(input, output) {
    
    resultKMeans <- eventReactive(input$button, {
        result <- iris
        kmeans.result <- clustering.kmeans(nOfCenters = nCenters)
        result <- cbind(result, Kmeans = kmeans.result)
        return(result)
    })
    
    output$tableData <- renderTable(resultKMeans())
}

# Run the application 
shinyApp(ui = ui, server = server)
