# Already inside server

library(shinydashboard)
library(shiny)
output$pageStub <- renderUI(fluidPage(
   headerPanel("Hello Shiny"),
   # Application title
   titlePanel("How to create reactive shiny Radio button Widget"),
   skin="red",
  
   # Sidebar with a slider input for number of bins
         sidebarLayout(
           sidebarPanel(
             menuItem("Dashboard", tabName="dashboard", icon=icon("dashboard")),
              menuSubItem("Dashboard Finance", tabName="Finance"),
              menuSubItem("Dashboard Sales", tabName="Sales"),
             menuItem("Detailed Analysis", badgeLabel="New",badgeColor = "green"),
             menuItem("Raw Data"),
             textInput("projcode", "Enter the project code"),
             textInput("projName", "Enter the project Name"),
             textInput("tech","Technology you are using?"),
             radioButtons("loc", "What is your location", choices=c("Off-site", "On-site")),
             sliderInput("ndayspent", "No. of days spent", 1,100,value=c(10,20), step=5),
             selectInput("dept", "What is your department", choices=c("Marketing", "Finance", "Sales", "IT"), multiple=T),
             selectInput("ngear", "Select the gear number", c("Cylinders"="cyl",
                                                              "Transmission"="am",
                                                              "Gears"="gear"))
             ),
           
           # Show a plot of the generated distribution
           mainPanel(
             tabsetPanel(type="tab",
                      tabPanel("Data", tableOutput("mtcars")),
                      tabPanel("Summary", verbatimTextOutput("summ")),
                      tabPanel("Plot", plotOutput("plot"))),
             textOutput("project_code"),
             textOutput("project_name"),
             textOutput("technology_used"),
             textOutput("location"),
             textOutput("no_of_days_spent"),
             textOutput("department"),
             fluidRow(column(width=5,
                      infoBox("Sales", 1, 100000,icon=icon("thumbs-up")),
                      infoBox("Conversion %", paste0('20%'), icon=icon("warning")),
                      infoBox("approvedSales"))),
             fluidRow(valueBox(15*500,"Budget for 15 Days", icon=icon("hourglass-3"), color="yellow"),
                      valueBox(15*200,"Item Requested by Employees", icon=icon("fire"), color="red")),
            
             dropdownMenu(type="message", messageItem(from="Finance Update", message="We are on Threshold"),
                          messageItem(from="Sales Update", message="We are on Threshold", icon=icon("bar-chart")),
                          messageItem(from="Sales Update", message="Sales meeting at 6 PM on Monday", icon=icon("handshake-o"), time="03-25-2017")),
             dropdownMenu(type="notifications",
                          notificationItem(
                            text="2 new tabs added to the dashboard",
                            icon=icon("dashboard"),
                            status="success"
                          ),
                          notificationItem(
                            text="Server is currently running at 95% load",
                            status="warning"
                          )),
             dropdownMenu(type="tasks",
                          taskItem(
                          value=80,
                          color="aqua",
                          "Shiny Dashboard Education"),
                          taskItem(
                            value=55,
                            color="red",
                            "Overall R Education"),
                          taskItem(
                            value=40,
                            color="red",
                            "Data Science Education")
                          ),
             
             fluidRow(tabBox(width=30,
                             
               tabPanel(title="Main Panel Output",
                        
                        status="primary",
                        tabItems(
                                    tabItem(tabName="dashboard",
                                           
                                               fluidRow(box(title="Histogram of Faithful",
                                                            status="primary",
                                                            solidHeader=T,
                                                            plotOutput("distPlot"))),
                                                        box(title="Controls for Dashboard",
                                                            status="warning",
                                                            solidHeader=T,
                                                            sliderInput("bins",
                                                                        "Number of bins:",
                                                                        min = 1,
                                                                        max = 50,
                                                                        value = 30),
                                                            textInput("text_input","Search Opportunities", value="123456")
                                              )),
                                      tabItem(tabName="Finance", h1("Finance Dashboard")),
                                      tabItem(tabName="Sales", h1("Sales Dashboard")))),
            
               tabPanel(title="Video: Creating",
                        status="primary",
                        HTML('<iframe width="500" height="400" src="https://www.youtube.com/embed/Gyrfsrd4zK0" frameborder="0" allowfullscreen></iframe>')),
        
               tabPanel(title="Code",
                        status="primary",
                        HTML(""),
                        includeHTML("app.html")))
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

output$approvedSales<-renderInfoBox({
  infoBox("Approval Sales", "10,000,000", icon=icon("bar-chart-o"))
})


output$itemRequested <-renderValueBox({
  valueBox(300, 
           subtitle="Item Requested by Employees", 
           icon=icon("fire"), 
           color="yellow")
})

output$project_code<-{(
  renderText(input$projcode)
)}

output$project_name<-{(
  renderText(input$projName)
)}

output$technology_used<-{(
  renderText(input$tech)
)}

output$location<-{(
  renderText(input$loc)
)}
  
output$no_of_days_spent<-{(
  renderText(input$ndayspent)
)}
  
output$department<-{(
  renderText(input$dept)
)} 
  
output$mtcars<-renderTable({mtcars})



output$summ<-renderPrint({
  summary(mtcars)
})
  


output$plot<-renderPlot({
  with(mtcars, boxplot(mpg~gear))
})