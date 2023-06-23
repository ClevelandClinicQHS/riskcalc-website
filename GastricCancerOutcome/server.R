os = expression({
  -1.8425423 + 0.010846172 * (LocCox == "U") - 0.16749 * (LocCox == "M") + 
    0.050019648 * (LocCox == "Entire") + 0.10269293 * 
    (LocCox == "EGJ") + 0.0014430737 * PreSize + 0.24252436 * 
    (cT == "T1b") + 0.58495043 * (cT == "T2") + 0.96168736 * 
    (cT == "T3") + 1.4407734 * (cT == "T4a") + 1.5651553 * 
    (cT == "T4b") + 0.025207497 * NumRegioLN + 0.18445617 * 
    (cNJPN == "N1") + 0.24524056 * (cNJPN == "N2a") + 0.66597235 * 
    (cNJPN == "N2b") + 0.59722426 * (cNJPN == "NM") + 0.5244548 * 
    (Liver == "Solitary") + 0.70337606 * (Liver == "Multiple") + 
    0.68491897 * (Peritoneum == "Positive") + 0.26087311 * 
    (cM == "Positive") + 0.48301951 * (MacroType == "Type1") + 
    0.0099029446 * (MacroType == "Type2") + 0.25913262 * 
    (MacroType == "Type3") + 0.83252198 * (MacroType == "Type4") + 
    0.07494354 * (Histology == "G2") + 0.31581898 * (Histology == "G3") - 0.002108175 * Age + 
    4.1157608e-05 * max(Age - 51, 0)**3 - 9.6034419e-05 * max(Age - 67, 0)**3 + 5.4876811e-05 * 
    max(Age - 79, 0)**3 + 0.05512007 * (Sex == "M") + 0.37494832 * 
    (ECOGPS == "1") + 0.74113905 * (ECOGPS == "2") + 0.89155126 * 
    (ECOGPS == "3 or 4") + 0.21417678 * SerumCEA.log - 0.027607203 * 
    max(SerumCEA.log + 0.10536052, 0)**3 + 0.044884683 * 
    max(SerumCEA.log - 0.83290912, 0)**3 - 0.017277481 * 
    max(SerumCEA.log - 2.3321439, 0)**3 + 0.029899589 * SerumCA19.log
})

dsm = expression({
  - 0.081076024 * (LocCox == "U") - 0.22570675 * (LocCox == "M") - 0.026996459 * (LocCox == "Entire") + 0.090486084 * 
    (LocCox == "EGJ") + 0.0019839542 * PreSize + 0.95211649 * 
    (cT == "T1b") + 1.7092158 * (cT == "T2") + 2.3470482 * (cT == "T3") + 2.8918279 * (cT == "T4a") + 3.0224211 * (cT == "T4b") + 
    0.022027365 * NumRegioLN + 0.21855975 * (cNJPN == "N1") + 
    0.30546798 * (cNJPN == "N2a") + 0.66233022 * (cNJPN == "N2b") + 
    0.61197993 * (cNJPN == "NM") + 0.69179943 * (Liver == "Solitary") + 
    0.77610227 * (Liver == "Multiple") + 0.66090249 * (Peritoneum == "Positive") + 0.3104542 * (cM == "Positive") + 0.59078268 * 
    (MacroType == "Type1") + 0.15443309 * (MacroType == "Type2") + 
    0.40425807 * (MacroType == "Type3") + 0.89737586 * (MacroType == "Type4") + 0.1561898 * (Histology == "G2") + 0.48878957 * 
    (Histology == "G3") - 0.0034017935 * Age + 0.000017846851 * 
    max(Age - 51, 0)**3 - 0.000041642652 * max(Age - 67, 0)**3 + 
    0.000023795801 * max(Age - 79, 0)**3 + 0.30036273 * (ECOGPS == "1") + 0.61478043 * (ECOGPS == "2") + 
    0.86264688 * (ECOGPS == "3 or 4") + 0.042532939 * SerumCEA.log + 0.028740838 * SerumCA19.log
})



shinyServer(function(input, output, session){
  # input
  data = reactive({
    shiny::validate(
      need(input$Age>=18&input$Age<=90, "Range of Age: 18 - 90"),
      need(input$PreSize>=2&input$PreSize<=250, "Range of Tumor size (mm): 2 - 250"),
      need(input$NumRegioLN>=0&input$NumRegioLN<=42, "Range of cN (number): 0 - 42"),
      need(input$SerumCEA>=0.5&input$SerumCEA<=35000, "Range of Serum CEA (ng/ml): 0.5 - 35,000"),
      need(input$SerumCA>=2&input$SerumCA<=700000, "Range of Serum CA19-9 (U/ml): 2 - 700,000")
    )
    
    Age = input$Age
    PreSize = input$PreSize
    NumRegioLN = input$NumRegioLN
    SerumCEA.log = log(input$SerumCEA)
    SerumCA19.log = log(input$SerumCA)
    LocCox = input$LocCox
    cT = input$cT
    cNJPN = input$cNJPN
    Liver = input$Liver
    Peritoneum = input$Peritoneum
    cM = input$cM
    MacroType = input$MacroType
    Histology = input$Histology
    ECOGPS = input$ECOGPS
    Sex = input$Sex
    
    data = data.frame(
      Age = Age,
      PreSize = PreSize,
      NumRegioLN = NumRegioLN,
      SerumCEA.log = SerumCEA.log,
      SerumCA19.log = SerumCA19.log,
      LocCox = LocCox,
      cT = cT,
      cNJPN = cNJPN,
      Liver = Liver,
      Peritoneum = Peritoneum,
      cM = cM,
      MacroType = MacroType,
      Histology = Histology,
      ECOGPS = ECOGPS,
      Sex = Sex
    )
    data
  })
  
  # output table
  output$result <- DT::renderDataTable({
    data = data()
    os.lp = eval(os, data)
    os.1y = 0.9301595 ** exp(os.lp)
    os.3y = 0.7798749 ** exp(os.lp)
    os.5y = 0.6879258 ** exp(os.lp)
    dsm.lp = eval(dsm, data)
    dsm.1y = 1 - 0.9968752 ** exp(dsm.lp)
    dsm.3y = 1 - 0.9896696 ** exp(dsm.lp)
    dsm.5y = 1 - 0.9859575 ** exp(dsm.lp)
    
    res = data.frame(
      Result = c("Overall survival probability in 1 year",
                 "Overall survival probability in 3 year",
                 "Overall survival probability in 5 year",
                 "Disease-specific mortality probability in 1 year",
                 "Disease-specific mortality probability in 3 year",
                 "Disease-specific mortality probability in 5 year"),
      Probability = c(
        pvalr(os.1y),
        pvalr(os.3y),
        pvalr(os.5y),
        pvalr(dsm.1y),
        pvalr(dsm.3y),
        pvalr(dsm.5y)
      )
    )
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