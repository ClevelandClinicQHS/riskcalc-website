pred_test <- expression({
    lp <- -1.2949461 + 0.011134783 * age - 
      4.0050571e-06 * max(age - 44.434378, 0)**3 + 7.8224455e-06 * max(age - 64.356063, 0)**3 - 
      3.8173883e-06 * max(age - 85.257129, 0)**3 - 0.29833144 * 
      Flu_like_symptoms + 0.34032347 * Vomiting + 0.269233 * 
      Copd_emphysema - 0.31723006 * Asthma + 0.2889021 * Diabetes + 
      0.49626073 * Transplant_history + 0.0078891292 * pre_testing_bun + 
      0.11818769 * pre_testing_crp - 0.00067585769 * max(pre_testing_crp - 1.9, 0)**3 + 
      0.00080176262 * max(pre_testing_crp - 4.4, 0)**3 - 0.00012590493 * max(pre_testing_crp - 17.82, 0)**3 - 
      0.28959097 * nsaids - 0.87151248 * carvedilol - 
      0.29770636 * arb - 0.79815895 * DischargedInRecent14Days
    lp
})

`%notin%` <- Negate(`%in%`)

pretty_pred = function(x) {
  x = x * 100
  if (x < 0.1) {
    return("<0.1%")
  } else if (x > 99.9) {
    return(">99.9%")
  } else {
    paste(round(x, 1), "%", sep="")
  }
}

server = function(input, output, session){
    # data <- eventReactive(input$goButton, {
    #     
    #     data})
    # 
    
  observeEvent(input$goButton, {
    shinyjs::show("result_panel")
  })
  
  observeEvent({list(input$age,
                     input$risk, input$comorbidities,
                     input$Smoking, input$flu_shot,
                     input$bun, input$pre_testing_bun,
                     input$crp, input$pre_testing_crp,
                     input$DischargedInRecent14Days)},
               {
                 shinyjs::hide("result_panel")
               })
  
  data <- eventReactive(input$goButton,{
    age = input$age
    DischargedInRecent14Days = ifelse(input$DischargedInRecent14Days == "No", 0, 1)
    Flu_like_symptoms = ifelse("Flu_like_symptoms" %in% input$risk, T, F)  
    Vomiting = ifelse("Vomiting" %in% input$risk, T, F)
    Copd_emphysema = ifelse("Copd_emphysema" %in% input$comorbidities, T, F)
    Asthma = ifelse("Asthma" %in% input$comorbidities, T, F)
    Diabetes = ifelse("Diabetes" %in% input$comorbidities, T, F)
    Transplant_history = ifelse("Transplant_history" %in% input$comorbidities, T, F)
    nsaids = ifelse("nsaids" %in% input$medications, T, F) 
    carvedilol = ifelse("carvedilol" %in% input$medications, T, F) 
    arb = ifelse("arb" %in% input$medications, T, F)
    #colchicine = ifelse("colchicine" %in% input$medications, T, F) 
    validate(
      need(input$pre_testing_bun>=1&input$pre_testing_bun<=60, 'BUN range: 1 - 60 mg/dL'),
      need(input$pre_testing_crp>=0&input$pre_testing_crp<=30, 'CRP range: 0 - 30 mg/L')
    )
    pre_testing_bun = ifelse(input$bun, input$pre_testing_bun, 16)   
    pre_testing_crp = ifelse(input$crp, input$pre_testing_crp, 4.4)
    
    data <- data.frame(
      age = age,
      DischargedInRecent14Days = DischargedInRecent14Days,
      Flu_like_symptoms = Flu_like_symptoms,
      Vomiting = Vomiting,
      Copd_emphysema = Copd_emphysema,
      Asthma = Asthma,
      Diabetes = Diabetes,
      Transplant_history = Transplant_history,
      nsaids = nsaids,
      carvedilol = carvedilol,
      arb = arb,
      pre_testing_bun = pre_testing_bun,
      pre_testing_crp = pre_testing_crp
    )
    data
  })
  
    output$result <- DT::renderDataTable({
        data = data()
        pred = eval(pred_test, envir = data)
        day1 = 1 - 0.7700987 ** exp(pred)
        day3 = 1 - 0.7051746 ** exp(pred)
        day5 = 1 - 0.659287 ** exp(pred)
        result = data.frame(Result = c("Predicted probability in 1 day", "Predicted probability in 3 day", "Predicted probability in 5 day"),
                            Probability = c(pretty_pred(day1), pretty_pred(day3), pretty_pred(day5)))
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