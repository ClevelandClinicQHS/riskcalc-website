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
library(dplyr)



# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("Serous Cystadenoma Size Expansion Over Time"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("previous", "Cyst size on PRIOR scan (mm)", min=3, max=160, value=20.5),
      sliderInput("time", "Time since PRIOR scan (months)", min=1, max=60, value=10)

    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tableOutput('result'),
      plotOutput("coolplot")
    )
  )
))




# Define server logic required to draw a histogram and results table
server <- shinyServer(function(input, output) {
  
  
  library(rms)
  load("new_model.RData")
  
  plot_dat = reactive(data_frame(time=1:60, 
                                 yhat = rms::Predict(mod, time=1:60, previous = input$previous)$yhat,
                                 upper = rms::Predict(mod, time=1:60, previous = input$previous)$upper,
                                 lower = rms::Predict(mod, time=1:60, previous = input$previous)$lower
                                   ))
 
  
  output$coolplot = renderPlot(ggplot(plot_dat(), aes(x=time, y=yhat)) + 
                                 geom_line() +
                                 geom_ribbon(data = plot_dat(), aes(ymin=lower, ymax=upper), alpha=0.1) + 
                                 geom_vline(xintercept= input$time, linetype = "dashed", colour = "red") + 
                                 labs(x = "Time (Month)", y = "Predicted Size"))
  
  output$result <- renderTable({
    resultTable <- data.frame(
      Result = "Estimated Cyst Size (MM)",
      Size = paste(round(rms::Predict(mod, time = input$time, previous = input$previous)$yhat, 3),",", "(", 
                   round(rms::Predict(mod, time = input$time, previous = input$previous)$lower, 3), "," , 
                   round(rms::Predict(mod, time = input$time, previous = input$previous)$upper, 3), ")" ,
                   sep="")
    )
  }, digits=2)
  
  
})




# Run the application 
shinyApp(ui = ui, server = server)
