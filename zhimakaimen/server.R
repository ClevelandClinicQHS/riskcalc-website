library(shiny)


# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
    
 source("keyGen.R")

 output$mykey <-  renderText({
            
      mykey <- if(input$iskey) keyGen(key = input$passwd) else  
        keyGen(index = input$passwd ) 
      
        mykey
}
      )
   
  
}
)
