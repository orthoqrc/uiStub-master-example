library(shiny)
library(shinydashboard)



output$pageStub <- renderUI(fluidPage(
  # Application title
  titlePanel("Creating Layout of Dashboard for Shiny Dashboard"),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      menuItem("Dashboard"),
        menuSubItem("Dashboard Finance"),
        menuSubItem("Dashboard Sales"),
      menuItem("Detailed Analysis"),
      menuItem("Raw Data")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      fluidRow(tabBox(
        tabPanel(title="Main Panel Output",
                 status="primary",
                 dashboardBody()),
        tabPanel(title="Video",
                status="primary",
                HTML('<iframe width="500" height="400" src="https://www.youtube.com/embed/Gyrfsrd4zK0" frameborder="0" allowfullscreen></iframe>')),
        tabPanel(title="Code",
                 status="primary",
                 HTML(""))
      ))
      
    )
  )
))

output$histogram<-output$distPlot <- renderPlot({
  # generate bins based on input$bins from ui.R
  x    <- faithful[, 2]
  bins <- seq(min(x), max(x), length.out = input$bins + 1)
  
  # draw the histogram with the specified number of bins
  hist(x, breaks = bins, col = 'darkgray', border = 'white')
})

