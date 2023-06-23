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
      sliderInput("baseline", "Initial Measure Size (MM)", min=3, max=160, value=20.5),
      sliderInput("tdiff_month", "Time (Month)", min=1, max=12, value=10)

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
  load("model.RData")
  
  plot_dat = reactive(data_frame(tdiff_month=1:12, 
                                 yhat = rms::Predict(mod, tdiff_month=1:12, baseline = input$baseline)$yhat,
                                 upper = rms::Predict(mod, tdiff_month=1:12, baseline = input$baseline)$upper,
                                 lower = rms::Predict(mod, tdiff_month=1:12, baseline = input$baseline)$lower
                                   ))
 
  
  output$coolplot = renderPlot(ggplot(plot_dat(), aes(x=tdiff_month, y=yhat)) + 
                                 geom_line() +
                                 geom_ribbon(data = plot_dat(), aes(ymin=lower, ymax=upper), alpha=0.1) + 
                                 geom_vline(xintercept= input$tdiff_month, linetype = "dashed", colour = "red") + 
                                 labs(x = "Time (Month)", y = "Predicted Size"))
  
  output$result <- renderTable({
    resultTable <- data.frame(
      Result = "Estimated Cyst Size (MM)",
      Size = paste(round(rms::Predict(mod, tdiff_month = input$tdiff_month, baseline = input$baseline)$yhat, 3),",", "(", 
                   round(rms::Predict(mod, tdiff_month = input$tdiff_month, baseline = input$baseline)$lower, 3), "," , 
                   round(rms::Predict(mod, tdiff_month = input$tdiff_month, baseline = input$baseline)$upper, 3), ")" ,
                   sep="")
    )
  }, digits=2)
  
  
})




# Run the application 
shinyApp(ui = ui, server = server)
