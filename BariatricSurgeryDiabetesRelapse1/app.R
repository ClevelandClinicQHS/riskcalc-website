library(shiny)


# Define UI for application
ui <- shinyUI(fluidPage(
    tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
    tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
    
  # Application title
  titlePanel("Individualized Diabetes Relapse (IDR) Risk Score after Bariatric Surgery (Model 1)"),
  headerPanel(h3("Predicts late relapse of type 2 diabetes following initial remission after bariatric surgery based on preoperative data")),
  
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
      tableOutput('result'),
      wellPanel(
        h3("Reference"),
        br(),
        a("Aminian A, Vidal J, Salminen P, Still CD, Nor Hanipah Z, Sharma G, Tu C, Wood GC, Ibarzabal A, Jimenez A, Brethauer SA, Schauer PR, Mahawar k. Late Relapse of Diabetes after Bariatric Surgery: Not Rare, but not a Failure", href="https://www.soard.org/article/S1550-7289(18)30641-5/fulltext")
      )
    )
  )
))



# Define probability score
dm2nfs <- function(SURGERY, duration.of.DM.Preop, MED.PREOP){
  lp <- -1.6993 - 0.7929 * (SURGERY == "Roux-en-Y Gastric Bypass") + 0.0790*duration.of.DM.Preop + 0.7139 * MED.PREOP
  
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
