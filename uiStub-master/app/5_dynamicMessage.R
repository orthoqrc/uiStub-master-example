# Already inside server
output$pageStub <- renderUI(fluidPage(
  headerPanel("Hello Shiny"),
   # Application title
   titlePanel("Enabling Menu Items"),
   
   # Sidebar with a slider input for number of bins
         sidebarLayout(
           sidebarPanel(
             sliderInput("bins",
                         "Number of bins:",
                         min = 1,
                         max = 50,
                         value = 30),
             menuItem("Dashboard", tabName="dashboard", icon=icon("dashboard")),
             menuSubItem("Dashboard Finance", tabName="Finance"),
             menuSubItem("Dashboard Sales", tabName="Sales"),
             menuItem("Detailed Analysis"),
             menuItem("Raw Data")
           ),
           
           # Show a plot of the generated distribution
           mainPanel(
             dropdownMenuOutput("msgOutput"),
             
             fluidRow(tabBox(width=30,
               tabPanel(title="Main Panel Output",
                        dropdownMenuOutput("msgOutput"),
                        status="primary",
                        tabItems(
                                      tabItem(tabName="dashboard",
                                               fluidRow(box(plotOutput("distPlot")))),
                                      tabItem(tabName="Finance", h1("Finance Dashboard")),
                                      tabItem(tabName="Sales", h1("Sales Dashboard")))),
            
               tabPanel(title="Video: Creating",
                        status="primary",
                        HTML('<iframe width="500" height="400" src="https://www.youtube.com/embed/Gyrfsrd4zK0" frameborder="0" allowfullscreen></iframe>')),
        
               tabPanel(title="Code",
                        status="primary",
                        HTML("")))
             ))
             
           )
         )
      # Show a plot of the generated distribution
   )


output$distPlot <- renderPlot({
   # generate bins based on input$bins from ui.R
   x    <- faithful[, 2]
   bins <- seq(min(x), max(x), length.out = input$bins + 1)

   # draw the histogram with the specified number of bins
   hist(x, breaks = bins, col = 'darkgray', border = 'white')
})


output$msgOutput<-renderMenu({
  msgs<-apply(read.csv("messages.csv"), 1,function(row){
    messageItem(from=row[["from"]], message=row[["message"]])
  })
  dropdownMenu(type="message", messageItem(from="Finance Update", message="We are on Threshold"),
               messageItem(from="Sales Update", message="We are on Threshold", icon=icon("bar-chart")),
               messageItem(from="Sales Update", message="Sales meeting at 6 PM on Monday", icon=icon("handshake-o"), time="03-25-2017"))
  dropdownMenu(type="messages", .list=msgs)
})









