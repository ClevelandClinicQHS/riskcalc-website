pred = expression({
    lp = -4.1022 + 0.2501 * gender + -0.2583 * smoker + 0.294 * snf + 
        0.3574 * pre_admission + 0.9794 * recent + 0.4595 * paralysis + 
        0.2654 * cpd + 0.6176 * ulcer + 0.3616 * loss + 0.4353 * icu + 
        0.7396 * imv + 0.4856 * vasopressors
  exp(lp)/(1+exp(lp))
})

shinyServer(function(input, output, session){
  # input
  data = reactive({
      gender = input$gender == "Male"
      smoker = input$smoker == "Yes"
      snf = input$snf == "Yes"
      pre_admission = input$pre_admission == "Yes"
      recent = input$recent == "Yes"
      paralysis = input$paralysis == "Yes"
      cpd = input$cpd == "Yes"
      ulcer = input$ulcer == "Yes"
      loss = input$loss == "Yes"
      icu = input$icu == "Yes"
      imv = input$imv == "Yes"
      vasopressors = input$vasopressors == "Yes"
    
    data = data.frame(
        gender = gender,
        smoker = smoker,
        snf = snf,
        pre_admission = pre_admission,
        recent = recent,
        paralysis = paralysis,
        cpd = cpd,
        ulcer = ulcer,
        loss = loss,
        icu = icu,
        imv = imv,
        vasopressors = vasopressors
    )
    data
  })
  
  # output table
  output$result <- DT::renderDataTable({
    data = data()
    prob = eval(pred, data)
    prob = ifelse(prob < 0.001, "<0.1%", ifelse(prob>0.999, ">99.9%", paste(as.character(round(prob*100,1)),"%")))
    
    res = data.frame(
      Result = c("Probability of having an organism resistant to first-line CAP therapy"),
      Probability = c(prob)
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