

pred_test <- expression({
  lp <- 0.7551 * gtc + 0.0011 * PreopMonthlyseizurefrequency - 0.3278 * mts +
    -0.0218 * normalmri + 0.4283 * nonlocal +
    -0.1314 * (bilateral == "Bilateral") +  -1.2614 * (bilateral == "No Epileptiform Discharges") +
    -0.4442 * temporal + 
    0.6571 * temporal * (bilateral == "Bilateral") + -0.3739 * normalmri * (bilateral == "Bilateral") +
    1.1084 * temporal * (bilateral == "No Epileptiform Discharges") + 0.4832 * normalmri * (bilateral == "No Epileptiform Discharges") 
  exp(-0.39 * exp(lp))
})


server = function(input, output, session){

  data <- eventReactive(input$goButton,{
    gtc = input$gtc == "Present"
    PreopMonthlyseizurefrequency = input$PreopMonthlyseizurefrequency
    mts = input$mts == "Mesial Temporal Sclerosis"
    normalmri = input$normalmri == "Normal"
    nonlocal = input$nonlocal == "Sometimes non-localizable"
    bilateral = input$bilateral
    temporal = input$temporal == "Temporal"
    
    data <- data.frame(
      gtc = gtc,
      PreopMonthlyseizurefrequency = PreopMonthlyseizurefrequency,
      mts = mts,
      normalmri = normalmri,
      nonlocal = nonlocal,
      bilateral = bilateral,
      temporal = temporal
    )
    data
  })
  
  output$result <- DT::renderDataTable({
    data = data()
    print(data)
    pred = eval(pred_test, envir = data)
    
    pred = ifelse(pred<0.001, "<0.1%", ifelse(pred>0.999, ">99.9%", paste(round(pred*100,1),"%",sep="")))
    result = data.frame(Result = c("Predicted probability of seizure freedom at 2 years"),
                        Probability = c(pred))
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