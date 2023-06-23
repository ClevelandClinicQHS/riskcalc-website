pred = expression({
    r = -5.8410 + 0.2672*northeast +0.1014*west +0.1638*south+1.2162*recent -
        0.6935*CHRNLUNG  +1.1916*Hyponatremia+0.8780*smoker+1.2429*Summer6_10 +
        0.4417*male+0.6668*Diarrhea-1.0550*p6m_adm+ 0.2783*northeast*Summer6_10 -
        0.4452*Summer6_10*south -0.7639*Summer6_10*west 
    exp(r)/(1+exp(r))
})

shinyServer(function(input, output, session){
  # input
  data = reactive({
      region = input$region
      northeast = as.numeric(region == "Northeast")
      west = as.numeric(region == 'West')
      south = as.numeric(region == 'South')
      Summer6_10 = as.numeric(input$Summer6_10 == "Yes")
      recent = as.numeric(input$recent == "Yes")
      male = as.numeric(input$male == "Male")
      CHRNLUNG = as.numeric(input$CHRNLUNG == "Yes")
      smoker = as.numeric(input$smoker == "Yes")
      Hyponatremia = as.numeric(input$Hyponatremia == "Yes")
      Diarrhea = as.numeric(input$Diarrhea == "Yes")
      p6m_adm = as.numeric(input$p6m_adm == "Yes")
    
    data = data.frame(
        northeast = northeast,
        west = west,
        south = south,
        Summer6_10 = Summer6_10,
        recent = recent,
        male = male,
        CHRNLUNG = CHRNLUNG,
        smoker = smoker,
        Hyponatremia = Hyponatremia,
        Diarrhea = Diarrhea,
        p6m_adm = p6m_adm
    )
    print(data)
    data
  })
  
  # output table
  output$result <- DT::renderDataTable({
    data = data()
    prob = eval(pred, data)
    prob = ifelse(prob < 0.001, "<0.1%", ifelse(prob>0.999, ">99.9%", paste(as.character(round(prob*100,1)),"%")))
    
    res = data.frame(
      Result = c("Probability of positive Legionella test"),
      Score = c(prob)
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