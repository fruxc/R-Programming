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
    titlePanel("Iris Dataset Distribution"),

# Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            radioButtons("p", "Select column of iris dataset:",
                list("Sepal.Length" = 'a', "Sepal.Width" = 'b', "Petal.Length" = 'c', "Petal.Width" = 'd')
            ),
            sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30)),

# Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$distPlot <- renderPlot({
    if (input$p == 'a') { i <- 1 }
    if (input$p == 'b') { i <- 2 }
    if (input$p == 'c') { i <- 3 }
    if (input$p == 'd') { i <- 4 }
    x <- iris[, i]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = 'lightblue', border = 'black')
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
