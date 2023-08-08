library(shiny)


# Define UI for application
ui <- shinyUI(fluidPage(
    tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
    tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
    
  # Application title
  titlePanel("Individualized Diabetes Relapse (IDR) Risk Score after Bariatric Surgery (Model 2)"),
  headerPanel(h3("Predicts late relapse of type 2 diabetes to be used 1-year after bariatric surgery in patients with early postoperative diabetes remission")),
  
  # Sidebar
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      
      numericInput('duration.of.DM.Preop', "Preop Duration of Diabetes (years)", 
                   value=17, min=0, max=100),
      numericInput('MED.PREOP', "Preop Number of Diabetes Medications (oral and injectable drugs including insulin)", value=2, min=0, max=10),
      numericInput("X.shortterm.wt.loss", "Percent weight lost in 1-year after surgery", value=5, min=-3.87, max=50),
      radioButtons("gain_group", "Late weight gain (>5% weight gain from the weight recorded at 1-year after surgery)", choices=c("Yes","No"),selected = "Yes"),
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
      ),
      p(
        a("Source Code", 
          href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/BariatricSurgeryDiabetesRelapse2", 
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        style = "text-align: center;"
      )
    )
  )
))



# Define probability score
dm2nfs <- function(duration.of.DM.Preop, MED.PREOP, X.shortterm.wt.loss,gain_group ){
  lp <- -0.7290 + 0.0919 *duration.of.DM.Preop + 0.7565 * MED.PREOP - 0.0877*X.shortterm.wt.loss + 1.3059*(gain_group == "Yes")
  
  round((exp(lp)/(1+exp(lp)))*100, digits = 1)
}

# Define server logic required to generate score
server <- shinyServer(function(input, output) {
  
  output$result <- renderTable({
    resultTable <- data.frame(
      Result = "Late Diabete Relapse",
      Probability = paste(dm2nfs(input$duration.of.DM.Preop, input$MED.PREOP, input$X.shortterm.wt.loss, input$gain_group),"%",sep="")
    )
  }, digits=1)
  
})


# Run the application 
shinyApp(ui = ui, server = server)
