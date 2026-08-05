

library(shiny)
shinyServer(function(input, output){
  data <- eventReactive(input$goButton, {
    
    Age      <- as.numeric(input$Age)                                  # continuous age
    Sex       <- factor(input$Sex, levels = c('M', 'F'))
    Race      <- factor(input$Race, levels = c('White', 'Black', 'Other'))
    Education <- as.numeric(input$Education)                            # continuous years
    Smoking   <- factor(input$Smoking, levels = c('Never', 'Quit', 'Current'))
    Surgeon   <- surgeon_volume(input$Surgeon)                          # maps name -> volume category
    
    data.frame(
      Age = Age,
      Sex = Sex,
      Race = Race,
      Education = Education,
      Smoking = Smoking,
      Surgeon = Surgeon,
      stringsAsFactors = FALSE
    )
  })
  
  output$result <- renderDataTable({
    
    data <- data()
    
    ltfu_val <- predict_ltfu(
      Age       = data$Age,
      Sex       = data$Sex,
      Race      = data$Race,
      Education = data$Education,
      Smoking   = data$Smoking,
      Surgeon   = data$Surgeon
    )
    
    risk_cat <- ifelse(ltfu_val >= 37, "High Risk", "Low Risk")
    
    prob.ltfu <- paste(
      ifelse(round(ltfu_val, 2) < 0.01, "<0.01",
             ifelse(round(ltfu_val, 2) > 99.99, ">99.99", round(ltfu_val, 2))),
      "%"
    )
    
    res <- data.frame(
      Result = c("The predicted probability of loss to follow-up (LTFU)",
                 "Risk Category"),
      Probability = c(prob.ltfu, risk_cat),
      stringsAsFactors = FALSE
    )
    
   DT::datatable(res)
  })
  
})