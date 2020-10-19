#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

# Application title
    titlePanel("Iris Scatter Plot"),

# Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            radioButtons("x", "Select x-axis:",
                         list("Sepal.Length" = 'a', "Sepal.Width" = 'b', "Petal.Length" = 'c', "Petal.Width" = 'd')),
            radioButtons("y", "Select y-axis:",
                         list("Sepal.Length" = 'e', "Sepal.Width" = 'f', "Petal.Length" = 'g', "Petal.Width" = 'h'))
            ),

# Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$distPlot <- renderPlot({
    if (input$x == 'a') { i <- 1 }
    if (input$x == 'b') { i <- 2 }
    if (input$x == 'c') { i <- 3 }
    if (input$x == 'd') { i <- 4 }
    if (input$y == 'e') { j <- 1 }
    if (input$y == 'f') { j <- 2 }
    if (input$y == 'g') { j <- 3 }
    if (input$y == 'h') { j <- 4 }
    x_axis <- iris[, i]
    y_axis <- iris[, j]
    plot(x_axis, y_axis, col = "blue")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
