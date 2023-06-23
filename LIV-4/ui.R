library(shiny)


# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel(h1("LIV-4 Score")),
  headerPanel(h3("Predicts the probability of in-hospital death for cirrhotic adult patients admitted to the ICU")),
  
  # Sidebar
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      h3("Risk Factors"),
      
      numericInput('bili', "Bilirubin (mg/dL)", value=4.2, min=0, max=100),
      numericInput('pt', "Prothrombin time (sec)", 
                   value=17, min=0, max=100),
      numericInput('wbc', "White blood cell count (k/uL)", value=7.4, min=0, max=200),
      numericInput('map', "Mean aterial pressure (mmHg)", value=65, min=0, max=250)
    ),
    
    # Main panel where results will appear
    mainPanel(
      # actionButton('run', 'Run calculator'),
      tableOutput('result')      
    )
  )
))
