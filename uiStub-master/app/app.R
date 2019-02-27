### uiStub
### v1.3 - Tom Weishaar - Sep 2017

### v1.1 fixes a security issue
###    for details, see: https://groups.google.com/forum/?utm_source=digest&utm_medium=email#!topic/shiny-discuss/zxoLK1kKTCw)
### v1.2 adds some tagList() functions that aren't strictly required here, but make it
###    much easier to expand this code.
### v1.3 added more informative console messages.

### Simple demo program that "moves" the ui into the server, thereby allowing the use of
###    the URL "search" protocol to create multi-page web sites. The advantage is that
###    each page can have its own file (to keep things organized) and only one file is
###    loaded into Shiny Server at a time, limiting memory usage.

### Note, the URL "path" protocol currently doesn't work, because Shiny Server currently
###    returns a "not found" error rather than passing the path to the session.

library(shiny)

# put a message in console or server log; note this happens only when the app is started!
cat("uiStub application started...\n")
ui <- uiOutput("uiStub")                                # single-output stub ui
server <- function(input, output, session) {
   cat("Session started.\n")                               # this prints when a session starts
   onSessionEnded(function() {cat("Session ended.\n\n")})  # this prints when a session ends

   # build menu; same on all pages
   output$uiStub <- renderUI(tagList(             # a single-output stub ui basically lets you
      fluidPage(theme = "style.css",                           #     move the ui into the server function
         fluidRow(
            column(12,
               HTML(
                 "<br>",
                    '<h3 style = "font-size:18px ; color: #ffffff; background-color: 	#ffe6e6;
                                  padding: 4px;"><a href="?home">Home</a></h3> ',
                 
                    '<h5><a href="?1_layout"> 1_Creating Layout of Dashboard</a></h5>',
                    '<h5><a href="?2_chartsinputcontrol"> 2_Creating Charts and Inh5ut Controls</a></h5>',
                    "<h5><a href='?3_enablingMenuItem'>3_Enabling Menu Items for their resh5ective h5ages</a></h5>",
                    "<h5><a href='?4_notification'>4_Creating Notification in Shiny</a></h5>",
                    "<h5><a href='?5_dynamicMessage'>5_Creating Dynamic Messages</a></h5>",
                    "<h5><a href='?6_notificationMenu'>6_Displaying Notification Menu</a></h5>",
                    "<h5><a href='?7_taskMenu'>7_Creating Task Menu</a></h5>",
                    "<h5><a href='?8_highlightMenu'>8_How to highlight new menu using badge</a></h5>",
                    "<h5><a href='?9_multiControl'>9_How to Add Multiple Controls on Side Bar</a></h5>",
                    "<h5><a href='?10_newBox'>10_Adding a nex box and putting controls in it</a></h5>",
                    "<h5><a href='?11_tab'>11_Adding a nex box and putting controls in it</a></h5>",
                    "<h5><a href='?12_kpi'>12_Creating KPIs or Info Boxes</a></h5>",
                    "<h5><a href='?13_valueBox'>13_Creating Value Box</a></h5>",
                    "<h5><a href='?14_columnLayout'>14_Creating Column Layout</a></h5>",
                    "<h5><a href='?15_titleColor'>15_Change page title and skin color</a></h5>",
                    "<h5><a href='?16_reactiveText'>16_Create reactive shiny Text Widget</a></h5>",
                    "<h5><a href='?17_reactiveRadio'>17_Create reactive shiny Radio Widget</a></h5>",
                    "<h5><a href='?18_reactiveSlider'>18_Create reactive Slidebar Widget</a></h5>",
                    "<h5><a href='?19_reactiveSelect'>19_Create reactive Select Input Widget</a></h5>",
                    "<h5><a href='?20_tab'>20_Create tabs</a></h5>",
                    "<h5><a href='?21_reactiveFunction'>21_Create reactive Functions</a></h5>",
                    "<h5><a href='?22_videoImage'>22_Add videos and images</a></h5>",
                    "<h5><a href='?23_downloadData'>23_Download data and plot</a></h5>",
                    "<h5><a href='?24_uploadFile'>24_Upload a file</a></h5>",
                    "<h5><a href='?25_reactiveSubmit'>25_Hold reactivity using submit button</a></h5>",
                    "<h5><a href='?26_allInclusive'>26_All Included</a></h5>"
                 
  )
               )
            ),
         uiOutput("pageStub")                     # loaded server code should render the
      )                                           #    rest of the page to this output$
   ))

   # load server code for page specified in URL
   validFiles = c("home.R",   # valid files must be hardcoded here
                  "1_layout.R",
                  "2_chartsinputcontrol.R",
                  "3_enablingMenuItem.R",
                  "4_notification.R",
                  "5_dynamicMessage.R",
                  "6_notificationMenu.R",
                  "7_taskMenu.R",
                  "8_highlightMenu.R",
                  "9_multiControl.R",
                  "10_newBox.R",
                  "11_tab.R",
                  "12_kpi.R",
                  "13_valueBox.R",
                  "14_columnLayout.R",
                  "15_titleColor.R",
                  "16_reactiveText.R",
                  "17_reactiveRadio.R",
                  "18_reactiveSlider.R",
                  "19_reactiveSelect.R",
                  "20_tab.R",
                  "21_reactiveFunction.R",
                  "22_videoImage.R",
                  "23_downloadData.R",
                  "24_uploadFile.R",
                  "25_reactiveSubmit.R",
                  "26_allInclusive.R")                     #    for security (use all lower-case
                                                        #    names to prevent Unix case problems)
   fname = isolate(session$clientData$url_search)       # isolate() deals with reactive context
   if(nchar(fname)==0) { fname = "?home" }              # blank means home page
   fname = paste0(substr(fname, 2, nchar(fname)), ".R") # remove leading "?", add ".R"

   cat(paste0("Session filename: ", fname, ".\n"))      # print the URL for this session

   if(!fname %in% validFiles){                          # is that one of our files?
      output$pageStub <- renderUI(tagList(              # 404 if no file with that name
         fluidRow(
            column(5,
               HTML("<h2>404 Not Found Error:</h2><p>That URL doesn't exist. Use the",
                    "menu above to navigate to the page you were looking for.</p>")
            )
         )
      ))
      return()    # to prevent a "file not found" error on the next line after a 404 error
   }
   source(fname, local=TRUE)                            # load and run server code for this page
}
# Run the application
shinyApp(ui = ui, server = server)
