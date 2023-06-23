predict.prob <- expression({
    lp <- 12.8194 - 0.1443 * Age - 1.0616 * (Sex == "Male")  - 3.5426* (Race != "African American")
    1 / (1 + exp(-lp))
})

library(shiny)
shinyServer(function(input, output){
    data <- reactive({
        validate(need(!is.na(as.numeric(input$Age))& as.numeric(input$Age)>=50& as.numeric(input$Age)<=100, 'Please input a valid Age between 50 and 100'))
        Age= as.numeric(input$Age)
        data <- data.frame(Age = Age,
                           Sex = input$Sex,
                           Race = input$Race
        )
        data})
    
    output$result <- renderDataTable({
      data = data()
      
      i = round(eval(predict.prob, data) * 100, 0)
      predict.res <-ifelse(i <= 1, "<= 1%", ifelse(i >= 99, ">= 99%", paste(i, "%")))
      
      
      res = data.frame(Outcome = "Having TTR gene mutation associated with ATTRv", 
                       Probability = predict.res)
      res
    }, options = list(
      pageLength = 10,
      lengthMenu = 0,
      processing = 0, 
      
      searching = 0,
      info = 0,
      paging = 0,
      initComplete = I(
        "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")),escape = F)
})
