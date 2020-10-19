#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(gridExtra)

shinyUI(fluidPage(titlePanel("Iris Dataset"), sidebarLayout(sidebarPanel(radioButtons("p", "Select column of iris dataset:", list("Sepal.Length" = 'a', "Sepal.Width" = 'b', "Petal.Length" = 'c', "Petal.Width" = 'd')), sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30)), mainPanel(plotOutput("distPlot")))))
# Define UI for application that draws a histogram
ui <- fluidPage(

# Application title
    titlePanel("Distribution of Length and Width of Petal and Sepal based on Species"),

# Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput('Species',
          'Select Species',
          as.character(unique(iris$Species))
          )
      ),

# Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot", width = "950", height = "600")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  data <- reactive({ iris[iris$Species == input$Species,] })

  output$distPlot <- renderPlot({

    #Plot 1: Distribution of Sepal Length 
    g1 <- ggplot(data(), aes(Sepal.Length))
    g1 <- g1 + geom_histogram(binwidth = .5, fill = "green", color = "black", alpha = .2)
    g1 <- g1 + geom_vline(aes(xintercept = mean(data()$Sepal.Length)), colour = "red", size = 2, alpha = .6)
    g1 <- g1 + labs(x = "Sepal Length")
    g1 <- g1 + labs(y = "Frequency")
    g1 <- g1 + labs(title = paste("Distribution of  Sepal Length, mu =", round(mean(data()$Sepal.Length), 2)))

    #Plot 2: Distribution of Sepal Width
    g2 <- ggplot(data(), aes(Sepal.Width))
    g2 <- g2 + geom_histogram(binwidth = .5, fill = "green", color = "black", alpha = .2)
    g2 <- g2 + geom_vline(aes(xintercept = mean(data()$Sepal.Width)), colour = "red", size = 2, alpha = .6)
    g2 <- g2 + labs(x = "Sepal Width")
    g2 <- g2 + labs(y = "Frequency")
    g2 <- g2 + labs(title = paste("Distribution of Sepal Width, mu =", round(mean(data()$Sepal.Width), 2)))

    #Plot 3: Distribution of Petal Length
    g3 <- ggplot(data(), aes(Petal.Length))
    g3 <- g3 + geom_histogram(binwidth = .5, fill = "yellow", color = "black", alpha = .2)
    g3 <- g3 + geom_vline(aes(xintercept = mean(data()$Petal.Length)), colour = "red", size = 2, alpha = .6)
    g3 <- g3 + labs(x = "Petal Length")
    g3 <- g3 + labs(y = "Frequency")
    g3 <- g3 + labs(title = paste("Distribution of  Petal Length, mu =", round(mean(data()$Petal.Length), 2)))

    #Plot 4: Distribution of Petal Width
    g4 <- ggplot(data(), aes(Petal.Width))
    g4 <- g4 + geom_histogram(binwidth = .5, fill = "yellow", color = "black", alpha = .2)
    g4 <- g4 + geom_vline(aes(xintercept = mean(data()$Petal.Width)), colour = "red", size = 2, alpha = .6)
    g4 <- g4 + labs(x = "Petal Width")
    g4 <- g4 + labs(y = "Frequency")
    g4 <- g4 + labs(title = paste("Distribution of Petal Width, mu =", round(mean(data()$Petal.Width), 2)))

    #Plotting 4 graphs
    grid.arrange(g1, g2, g3, g4, nrow = 2, ncol = 2)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
