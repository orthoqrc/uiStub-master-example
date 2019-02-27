# home page

output$pageStub <- renderUI(tagList(
   fluidRow(
      column(5,
         HTML('<h4>* The Multiple Page design was adopted from <a href="https://github.com/open-meta/uiStub">uiStub on Github</a></h4>')
      )
   ),
   fluidRow(
      column(5,
        HTML('<h4>* The Shiny Tutorial was from <a href="https://www.youtube.com/watch?v=1MHX1s5bb6w&index=1&list=PLYUFHoLnVxnSrc_tcaXx85CN6J68EAtaR" >Data Science Tutorials on YouTube</a>
             </h4>')
   )
)))



