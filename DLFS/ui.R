library(shiny)
library(shinythemes)

# Define UI for application
shinyUI(fluidPage(theme = shinytheme("flatly"),
  
  # Application title
  titlePanel("Diabetes Liver Fibrosis Score (DLFS)"),
  headerPanel(h3("Predicts the probability of advanced fibrosis in adult patients with diabetes type II and non-alcoholic fatty liver")),
  
  # Sidebar
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      h3("Risk Factors"),
      
      numericInput('age', "Age (years)", value=50, min=18, max=100),
      radioButtons('htn', "History of hypertension", choices=list("No", "Yes"), 
                   selected="No", inline=TRUE),
      radioButtons('ckd', "History of chronic kidney disease", choices=list("No", "Yes"), 
                  selected="Yes", inline=TRUE),
      radioButtons('antihpl', "Use of antilipidemic medications in the prior 24 months", 
                  choices=list("No", "Yes"), selected="No", inline=TRUE),
      numericInput('plt', HTML(paste("Platelet count (x10", tags$sup(9),"/L)"),sep=""), 
                   value=180, min=0, max=100000),
      numericInput('ast', "AST (U/L)", value=45, min=0, max=1000)
    ),
    
    # Main panel where results will appear
    mainPanel(
      # actionButton('run', 'Run calculator'),
      dataTableOutput('result'),
      br(),
      wellPanel(h3('Disclaimer'),
                p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site."))
      
    )
  )
))
