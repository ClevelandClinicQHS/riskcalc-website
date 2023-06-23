# Define probability score
dm2nfs <- function(bili, pt, wbc, map){
  lp <- 1.1933 + 0.6137 * log(bili) - 47.2030/pt + 0.0715 * wbc - 0.0198 * map

  round((exp(lp)/(1+exp(lp)))*100, digits = 1)
}

# Define server logic required to generate score
shinyServer(function(input, output) {
  
  output$result <- renderTable({
    resultTable <- data.frame(
      Result = "LIV-4",
      Probability = paste(dm2nfs(input$bili, input$pt, input$wbc, input$map),"%",sep="")
    )
  }, digits=1)
  
})
