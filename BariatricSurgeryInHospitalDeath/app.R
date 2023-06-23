library(shiny)


# Define UI for application
ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("Relapse of Diabetes after Bariatric Surgery"),
  headerPanel(h3("Predicts late relapse of diabetes following initial remission after bariatric surgery")),
  
  # Sidebar
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      
      
      radioButtons("SURGERY", "Surgery type", choices=c("Roux-en-Y Gastric Bypass", "Sleeve Gastrectomy"), selected="Roux-en-Y Gastric Bypass"),
      numericInput('duration.of.DM.Preop', "Preop Duration of Diabetes (years)", 
                   value=17, min=0, max=100),
      numericInput('MED.PREOP', "Preop Number of Diabetes Medications (oral and injectable drugs including insulin)", value=2, min=0, max=10),
      submitButton("Calculate")
    ),
    
    # Main panel where results will appear
    mainPanel(
     # actionButton('run', 'Run calculator'),
      tableOutput('result')      
    )
  )
))



# Define probability score
dm2nfs <- function(SURGERY, duration.of.DM.Preop, MED.PREOP){
  lp <- -1.64 - 0.67 * (SURGERY == "Roux-en-Y Gastric Bypass") + 0.076*duration.of.DM.Preop + 0.61 * MED.PREOP
  
  round((exp(lp)/(1+exp(lp)))*100, digits = 1)
}

# Define server logic required to generate score
server <- shinyServer(function(input, output) {
  
  output$result <- renderTable({
    resultTable <- data.frame(
      Result = "Late Diabete Relapse",
      Probability = paste(dm2nfs(input$SURGERY, input$duration.of.DM.Preop, input$MED.PREOP),"%",sep="")
    )
  }, digits=1)
  
})


# Run the application 
shinyApp(ui = ui, server = server)
