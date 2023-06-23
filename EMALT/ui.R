library(shiny)


# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel(h1("Early Mortality After Liver Transplantation (EMALT)")),
  headerPanel(h3("Predicts the probability of in-hospital death for adult patients admitted to the ICU immediately following a liver transplantation")),
  
  # Sidebar
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      h3("Risk Factors"),
      
      numericInput('urine', "Urine output (L)", value=1, min=0, max=100),
      numericInput('glucose', "Glucose (mg/dL)", 
                   value=250, min=0, max=2000),
      numericInput('wbc', "White blood cell count (k/uL)", value=6, min=0, max=200)
    ),
    
    # Main panel where results will appear
    mainPanel(
      # actionButton('run', 'Run calculator'),
      tableOutput('result')      
    )
  )
))
