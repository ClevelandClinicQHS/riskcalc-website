# model formula
calculate_bmi <- expression({
  if (data$metric == "English") {
    bmi = data$weight / (data$height)^2 * 703
  } else (
    bmi = data$weight / (data$height/100)^2
  )
  bmi
})

shinyServer(function(input, output) {
  # hide result area when input changes
  observeEvent({list(input$metric, input$height_cm, input$height_cm, 
                     input$weight_pound, input$weight_kg)},
               {
                 shinyjs::hide("result_panel")
               })
  
  observeEvent(input$goButton, {shinyjs::show('result_panel')})
  
  # input
  data <- eventReactive(input$goButton, {
    
    # validate the inputs
    if (input$metric == "English") {
      shiny::validate(need(!is.na(input$height_inch) & input$height_inch>=40 & input$height_inch <=96, 'Please input a valid height'))
      shiny::validate(need(!is.na(input$weight_pound) & input$weight_pound>=60 & input$weight_pound <=500, 'Please input a valid weight'))
    } else {
      shiny::validate(need(!is.na(input$height_cm) & input$height_cm>=80 & input$height_cm <=240, 'Please input a valid height'))
      shiny::validate(need(!is.na(input$weight_kg) & input$weight_kg>=30 & input$weight_kg <=250, 'Please input a valid weight'))
    }
    
    # create data frame from input
    data <- data.frame(
      metric = input$metric,
      height = ifelse(input$metric == "English", input$height_inch, input$height_cm),
      weight = ifelse(input$metric == "English", input$weight_pound, input$weight_kg)
    )
    print(data)
    data})
  
  # output table
  output$result <- DT::renderDataTable({
    # calculate outcome
    data = data()
    bmi = eval(calculate_bmi, data)
    # output table
    res = data.frame(
      Result = c("BMI"),
      Value = c(round(bmi, 3))
    )
    res
    
  }, options = list(
    pageLength = 10,
    lengthMenu = 0,
    
    searching = 0,
    processing = 0,
    info = 0,
    paging = 0,
    initComplete = I(
      "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
})