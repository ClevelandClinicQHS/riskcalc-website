library(shiny)


# Define UI for application
ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel(h1("Diabetes Relapse")),
  headerPanel(h3("Predicts the probability of in-hospital death for patients after bariatric surgery")),
  
  # Sidebar
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      h3("Risk Factors"),
      
      radioButtons("SURGERY", "Surgery type", choices=c("Bypass", "Sleeve"), selected="Bypass"),
      numericInput('duration.of.DM.Preop', "Duration of DM Preop", 
                   value=17, min=0, max=100),
      numericInput('MED.PREOP', "Number of Med Preop", value=2, min=0, max=10)
      
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
  lp <- 1.64 - 0.67 * (SURGERY == "Bypass") + 0.076*duration.of.DM.Preop + 0.61 * MED.PREOP
  
  round((exp(lp)/(1+exp(lp)))*100, digits = 1)
}

# Define server logic required to generate score
server <- shinyServer(function(input, output) {
  
  output$result <- renderTable({
    resultTable <- data.frame(
      Result = "Diabete Relapse",
      Probability = paste(dm2nfs(input$SURGERY, input$duration.of.DM.Preop, input$MED.PREOP),"%",sep="")
    )
  }, digits=1)
  
})


# Run the application 
shinyApp(ui = ui, server = server)
