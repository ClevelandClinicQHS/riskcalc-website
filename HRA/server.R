HRA = expression({
  lp = 0.0466 * age + 1.31 * male + 0.528 * diabetes + 0.455 * hypertension +
      0.516 * hypercholesterolemia + -0.0168 * HDL + -0.064 * exercise_time + 
      0.838 * (duke_treadmill_score == "<= -11") + 1.63 * (duke_treadmill_score == "-10 to 4") + 0.74 * (duke_treadmill_score == "Not available") + 
      0.838 * (chestpain=="Cardiac chest pain") + 0.25 * (chestpain=="Unavailable") + 0.354 * FMHx_CAD - 6.0225  
  
  1/(1+exp(-lp))
})


shinyServer(function(input, output, session){
  # input
  data = reactive({
    shiny::validate(
      need(input$age>=18&input$age<=90, "Range of age: 18 - 90"),
      need(input$HDL>=0&input$HDL<=100, "Range of HDL: 0 - 100 mg/dl"),
      need(input$exercise_time>=0&input$exercise_time<=20, "Range of total exercise time: 0 - 20 min")
    )
    
    data = data.frame(
        age = input$age,
        male = input$male == "Male",
        diabetes = input$diabetes == "Yes",
        hypertension = input$hypertension == "Yes",
        hypercholesterolemia = input$hypercholesterolemia == "Yes",
        HDL = input$HDL,
        exercise_time = input$exercise_time,
        duke_treadmill_score = input$duke_treadmill_score,
        chestpain = input$chestpain,
        FMHx_CAD = input$FMHx_CAD == "Yes"
    )
    data
  })
  
  # output table
  output$result <- DT::renderDataTable({
    data = data()
    pred.hra = eval(HRA, data)
    
    pred.hra = ifelse(pred.hra<0.001,"<0.1%", ifelse(pred.hra>0.999, ">99.9%", paste(round(pred.hra*100,1), "%", sep="")))
    
    res = data.frame(
      Result = c("High-risk coronary artery disease anatomy probability"),
      Probability = c(pred.hra)
    )
  }, escape = FALSE, options = list(
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

pvalr <- function(pvals, sig.limit = .001, digits = 3, html = FALSE) {
  
  roundr <- function(x, digits = 1) {
    res <- sprintf(paste0('%.', digits, 'f'), x)
    zzz <- paste0('0.', paste(rep('0', digits), collapse = ''))
    res[res == paste0('-', zzz)] <- zzz
    res
  }
  
  sapply(pvals, function(x, sig.limit) {
    if (x < sig.limit)
      if (html)
        return(sprintf('&lt; %s', format(sig.limit))) else
          return(sprintf('< %s', format(sig.limit)))
    if (x > .1)
      return(roundr(x, digits = 2)) else
        return(roundr(x, digits = digits))
  }, sig.limit = sig.limit)
}