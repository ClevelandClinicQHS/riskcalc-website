
predict.risk <- expression({
  lp <- -6.73002468 +
    0.054253509 * Age + 
    1.265696295 * (Gender == "Male") + 
    0.366635377 * (fam == "Yes") +
    0.487202807 * (diabetes == "Yes") +
    0.354801336 * (HYPERTENSION == "Yes") +
    0.569696959 * (HYPERCHOLESTEROL == "Yes") +
    -1.531806425 * (block == "Yes") +
    0.860708328 * (duke == '-10 ~ 4') +
    1.743716178 * (duke == '<= -11') +
    0.641196518 * (duke == "Unknown") +
    0.86212844 * (chest == "Typical") + 
    0.228620539 * (chest == "Unknown") +
    -0.00086018 * exercise +
    -0.013039608 * hdl
  1/(1+exp(-lp))
})


library(shiny)
shinyServer(function(input, output){

  data <- eventReactive(input$goButton, {
    validate(need(!is.na(as.numeric(input$Age))& as.numeric(input$Age)>=18& as.numeric(input$Age)<=90, 'Please input a valid Age'))
    Age= as.numeric(input$Age)
    Gender = factor(input$Gender, levels = c('Female', 'Male'))
    fam = factor(input$fam, levels = c("No", "Yes"))
    diabetes = factor(input$diabetes, levels = c("No", "Yes"))
    HYPERTENSION = factor(input$HYPERTENSION, levels = c("No", "Yes"))
    HYPERCHOLESTEROL = factor(input$HYPERCHOLESTEROL, levels = c("No", "Yes"))
    block = factor(input$block, levels = c("No", "Yes"))
    duke = input$duke
    chest = input$chest
    exercise = input$exercise
    hdl = input$hdl
    
    data <- data.frame(Age = Age,
                       Gender = Gender,
                       fam = fam,
                       diabetes = diabetes,
                       HYPERTENSION = HYPERTENSION,
                       HYPERCHOLESTEROL = HYPERCHOLESTEROL,
                       block = block,
                       duke = duke,
                       chest = chest,
                       exercise = exercise,
                       hdl = hdl)
    data})
  
  output$result <- DT::renderDataTable({
    data = data()
    
    pred = eval(predict.risk, envir = data)
    pred = paste(round(pred * 100, 1), "%", sep='')
    
    res = data.frame(Result = c("Probability of High-Risk Coronary Anatomy"),
                     Probability = pred)
    
    res}, options = list(
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
})
