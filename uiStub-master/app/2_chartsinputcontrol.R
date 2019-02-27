# Already inside server
output$pageStub <- renderUI(fluidPage(

   # Application title
   titlePanel("Creating Charts and Input Control"),

   # Sidebar with a slider input for number of bins
         sidebarLayout(
           sidebarPanel(
             sliderInput("bins",
                         "Number of bins:",
                         min = 1,
                         max = 50,
                         value = 30),
             menuItem("Dashboard"),
             menuSubItem("Dashboard Finance"),
             menuSubItem("Dashboard Sales"),
             menuItem("Detailed Analysis"),
             menuItem("Raw Data")
           ),
           
           # Show a plot of the generated distribution
           mainPanel(
             fluidRow(tabBox(width=30,
             
               tabPanel(title="Main Panel Output",
                        status="primary",
                        dashboardBody(plotOutput("distPlot"))
                        ),
               tabPanel(title="Video",
                        status="primary",
                        HTML('<iframe width="500" height="400" src="https://www.youtube.com/embed/Gyrfsrd4zK0" frameborder="0" allowfullscreen></iframe>')),
               tabPanel(title="Code",
                        status="primary",
                        HTML(""))
             )
             
           )
         )
      )

      # Show a plot of the generated distribution
      ))
   


output$distPlot <- renderPlot({
   # generate bins based on input$bins from ui.R
   x    <- faithful[, 2]
   bins <- seq(min(x), max(x), length.out = input$bins + 1)

   # draw the histogram with the specified number of bins
   hist(x, breaks = bins, col = 'darkgray', border = 'white')
})
