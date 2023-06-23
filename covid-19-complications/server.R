pred_test <- expression({
    lp <- -4.0065  + 0.0826 * Age + 0.4595 * (Gender == "Male") -3.4506 * lymphocyte_109_L +
      1.7684 * (CT_severity_level == "Moderate") + 3.4429 * (CT_severity_level == "Severe") 
    1/(1+exp(-lp))
})

server = function(input, output, session){

  observeEvent(input$goButton, {
    shinyjs::show("result_panel")
  })
  
  observeEvent({list(input$Age, input$Gender, input$CT_severity_level, input$lymphocyte_109_L)},
               {
                 shinyjs::hide("result_panel")
               })
  
  data <- eventReactive(input$goButton, {
    validate(
      need(input$Age >= 20 & input$Age <= 80, "Age range: 20 - 80"),
      need(input$lymphocyte_109_L >= 0.2 & input$lymphocyte_109_L <= 3.2, "Lymphocyte count range: 0.2 - 3.2 * 10^9/L")
    )
    Age = input$Age
    Gender = input$Gender
    CT_severity_level = input$CT_severity_level
    lymphocyte_109_L = input$lymphocyte_109_L
    
    data <- data.frame(
      Age = Age,
      Gender = Gender,
      CT_severity_level = CT_severity_level,
      lymphocyte_109_L = lymphocyte_109_L
    )
    data
  })
  
  output$result <- DT::renderDataTable({
    data = data()
    pred = eval(pred_test, envir = data)
    result = data.frame(Result = c("Predicted probability"),
                        Probability = c(paste(round(pred*100, 2), "%", sep="")))
    result
  }, rownames= FALSE,
  options = list(
    pageLength = 10,
    lengthMenu = 0,
    
    searching = 0,
    info = 0,
    paging = 0,
    processing = 0,
    initComplete = I(
      "function(settings, json) {
                $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
}")))
}