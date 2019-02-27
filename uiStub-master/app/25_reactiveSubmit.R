# Already inside server

library(shinydashboard)
library(shiny)
output$pageStub <- renderUI(fluidPage(
   # headerPanel("Hello Shiny"),
   # Application title
   titlePanel("How to hold reactivity using Submit button?"),
   skin="red",
  
   # Sidebar with a slider input for number of bins
         sidebarLayout(
           sidebarPanel(
             selectInput("ngear", "Select the gear number", c("Cylinders"="cyl",
                                                              "Transmission"="am",
                                                              "Gears"="gear")),
             submitButton("Update!")
             ),
           
           # Show a plot of the generated distribution
           mainPanel(
             
             tabsetPanel(type="tab",
                         # tabPanel("Help",tags$img(src="rstudio.png"),
                         #          tags$video(src="testVideo.mp4", width="500px",
                         #                     height="350px",
                         #                     type="video/mp4",
                         #                     controls="controls"),
                         #          HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/Ka2pWqXS1WA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')),
                      tabPanel("Data", tableOutput("mtcars"), downloadButton("downloadData", "Download Data")),
                      tabPanel("Summary", verbatimTextOutput("summ")),
                      tabPanel("Plot", plotOutput("plot"), downloadButton("downloadPlot", "Download Plot"))),
            
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

##### Reactive Functions 

mtreact<-reactive({
  mtcars[,c("mpg", input$ngear)]
})
output$mtcars<-renderTable({
  mtreact()
  })

output$summ<-renderPrint({
  summary(mtreact())
})
  
output$plot<-renderPlot({
  with(mtreact(), boxplot(mpg~mtreact()[,2]))
})


##### Add video and images


#### 23. Download Data and Plot

output$downloadData<-downloadHandler(
  filename=function(){
    paste("mtcars","csv", sep=".")
  },
  content=function(file){
    write.csv(mtreact(), file)
  }
)

output$downloadPlot<-downloadHandler(
  filename=function(){
    paste("mtcars-plot", "png", sep=".")
  },
  content=function(file){
    png(file)
    with(mtreact(), boxplot(mpg~mtreact()[,2]))
    dev.off()
    
  })


#### 24. Upload File

output$input_file<-renderTable({
  file_to_read=input$file
  if(is.null(file_to_read)){
    return()
  }
  read.table(file_to_read$datapath, sep=input$sep, header=input$header)
})



#### 25. Hold reactivity using submit button