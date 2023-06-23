# Define probability score
emalt <- function(urine, glucose, wbc){
  lp <- 1.7028 - 1.2036 * urine - 0.0113 * glucose - 0.8580 * log(wbc)

  round((exp(lp)/(1+exp(lp)))*100, digits = 1)
}

# Define server logic required to generate score
shinyServer(function(input, output) {
  
  output$result <- renderTable({
    resultTable <- data.frame(
      Result = "EMALT",
      Probability = paste(emalt(input$urine, input$glucose, input$wbc),"%",sep="")
    )
  }, digits=1)
  
})
