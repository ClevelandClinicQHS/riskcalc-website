#2018-04-26 functionality for 10-yr MOON outcomes risk calculator
function(input, output, session) {

  #Calculating BMI based on input height/weight
  bmi <- reactive({
    703 * (input$weight / ((input$feet*12 + input$inches)^2))
  })
  
  #Functionality to move to next page when buttons are pressed
  observeEvent(input$start, {
    updateTabsetPanel(session,
                      inputId = 'mainPage',
                      selected = 'demographics')
  })
  
  observeEvent(input$nextPage1, {
    updateTabsetPanel(session,
                      inputId = 'mainPage',
                      selected = 'surgery')
  })
  observeEvent(input$nextPage2, {
    updateTabsetPanel(session,
                       inputId = 'mainPage',
                       selected = 'riskFactors')
  })
  observeEvent(input$nextPage3, {
    updateTabsetPanel(session,
                       inputId = 'mainPage',
                       selected = 'PRO')
  })
  
  
  #####KOOS#####################

  #Calculating current ADL
  adl <- reactive({
    if(input$haveADL == 'Yes') {
      input$inputADL
    } else {
      inds <- names(input)[grepl('ADL_Q', names(input))]
      vals <- c()
      for(i in 1:length(inds)) {
          vals <- c(vals, input[[inds[i]]])
      }
      100 - (mean(as.numeric(vals)) * 100) / 4
    }
  })
  
  #Print it out below survey
  output$adlCalculated <- renderText({
    paste0('Your current ADL score is ', round(adl()))
  })
  
  #Calculating current QOL
  qol <- reactive({
    if(input$haveQOL == 'Yes') {
      input$inputQOL
    } else {
      inds <- names(input)[grepl('QOL_Q', names(input))]
      vals <- c()
      for(i in 1:length(inds)) {
        vals <- c(vals, input[[inds[i]]])
      }
      100 - (mean(as.numeric(vals)) * 100) / 4
    }
  })
  
  #Print it out below survey
  output$qolCalculated <- renderText({
    paste0('Your current quality of life score is ', round(qol()))
  })
  ##############################
  
  #Calculating current PAIN
  pain <- reactive({
    if(input$havePAIN == 'Yes') {
      input$inputPAIN
    } else {
      inds <- names(input)[grepl('PAIN_Q', names(input))]
      vals <- c()
      for(i in 1:length(inds)) {
        vals <- c(vals, input[[inds[i]]])
      }
      100 - (mean(as.numeric(vals)) * 100) / 4
    }
  })
  
  #Print it out below survey
  output$painCalculated <- renderText({
    paste0('Your current pain score is ', round(pain()))
  })
  ##############################
  
  #Calculating current SAR
  sar <- reactive({
    if(input$haveSAR == 'Yes') {
      input$inputSAR
    } else {
      inds <- names(input)[grepl('SAR_Q', names(input))]
      vals <- c()
      for(i in 1:length(inds)) {
        vals <- c(vals, input[[inds[i]]])
      }
      100 - (mean(as.numeric(vals)) * 100) / 4
    }
  })
  
  #Print it out below survey
  output$sarCalculated <- renderText({
    paste0('Your current sports & recreation score is ', round(sar()))
  })
  ##############################
  
  #Calculating current symptom
  symp <- reactive({
    if(input$haveSYMP == 'Yes') {
      input$inputSYMP
    } else {
      inds <- names(input)[grepl('SYMP_Q', names(input))]
      vals <- c()
      for(i in 1:length(inds)) {
        vals <- c(vals, input[[inds[i]]])
      }
      100 - (mean(as.numeric(vals)) * 100) / 4
    }
  })
  
  #Print it out below survey
  output$sympCalculated <- renderText({
    paste0('Your current symptom score is ', round(symp()))
  })
  #######################################
  
  #MARX AND IKDC current values
  ikdc <- reactive({
    if(input$haveIKDC == 'Yes') {
      input$inputIKDC
    } else {
      inds <- names(input)[grepl('ikdc_Q', names(input)) & !(names(input) == 'ikdc_Q18')]
      vals <- c()
      for(i in 1:length(inds)) {
        vals <- c(vals, input[[inds[i]]])
      }
      sum(as.numeric(vals))/87 * 100
    }
  })
  #Print it out below survey
  output$ikdcCalculated <- renderText({
    paste0('Your current IKDC score is ', round(ikdc()))
  })
  
  marx <- reactive({
    if(input$haveMARX == 'Yes') {
      input$inputMARX
    } else {
      inds <- names(input)[grepl('marx_Q', names(input))]
      vals <- c()
      for(i in 1:length(inds)) {
        vals <- c(vals, input[[inds[i]]])
      }
      sum(as.numeric(vals))
    }
  })
  
  #Print it out below survey
  output$marxCalculated <- renderText({
    paste0('Your current marx activity level is ', marx())
  })
  
  
  ####################################
  #Getting all current predicted values
  current_predictions <- reactive({
    
    #MARX
    MARX <- marx_preds(age = input$age,
                       bmi = bmi(),
                       comp = input$competition,
                       ed = input$education,
                       gender = input$gender,
                       graft = input$graft,
                       laxity = input$laxity,
                       prevMedSurgery = input$prevMed,
                       subCL = input$subCL,
                       subIL = input$subIL,
                       fixation = input$fixation,
                       marx = marx(),
                       timePoint = input$timePoint)
    
    #IKDC 
    IKDC <- ikdc_preds(acLat = input$latPath,
                       acMed = input$medPath,
                       acPF = input$pfPath,
                       bmi = bmi(),
                       ed = input$education,
                       gender = input$gender,
                       marx = marx(),
                       prevMedSurgery = input$prevMed,
                       reconType = input$recon,
                       smoking = input$smoking,
                       sport = input$sport,
                       subCL = input$subCL,
                       subIL = input$subIL,
                       ikdc = ikdc(),
                       timePoint = input$timePoint)
    
    #ADL
    ADL <- adl_preds(age = input$age,
                     bmi = bmi(),
                     comp = input$competition,
                     ed = input$education,
                     gender = input$gender,
                     graft = input$graft,
                     marx = marx(),
                     prevACLR = input$prevACLR,
                     prevMedSurgery = input$prevMed,
                     sport = input$sport,
                     subCL = input$subCL,
                     subIL = input$subIL,
                     fixation = input$fixation,
                     adl = adl(),
                     timePoint = input$timePoint)
    
    #QOL
    QOL <- qol_preds(acLatFrac = input$latFracPath,
                     acMed = input$medPath,
                     acPF = input$pfPath,
                     age = input$age,
                     bmi = bmi(),
                     graft = input$graft,
                     latMenPath = input$latMenPath,
                     marx = marx(),
                     prevILknee = input$prevIL,
                     prevMedSurgery = input$prevMed,
                     reconType = input$recon,
                     smoking = input$smoking,
                     sport = input$sport,
                     subCL = input$subCL,
                     subIL = input$subIL,
                     exposure = input$exposure,
                     qol = qol(),
                     timePoint = input$timePoint)
    
    #Pain
    PAIN <- pain_preds(acLat = input$latPath,
                       acMed = input$medPath,
                       acPF = input$pfPath,
                       age = input$age,
                       bmi = bmi(),
                       graft = input$graft,
                       prevMedSurgery = input$prevMed,
                       reconType = input$recon,
                       smoking = input$smoking,
                       sport = input$sport,
                       subCL = input$subCL,
                       subIL = input$subIL,
                       pain = pain(),
                       timePoint = input$timePoint)
    
    #SAR
    SAR <- SAR_preds(acLat = input$latPath,
                     acMed = input$medPath,
                     acPF = input$pfPath,
                     age = input$age,
                     bmi = bmi(),
                     gender = input$gender,
                     prevMedSurgery = input$prevMed,
                     reconType = input$recon,
                     smoking = input$smoking,
                     sport = input$sport,
                     subCL = input$subCL,
                     subIL = input$subIL,
                     sar = sar(),
                     timePoint = input$timePoint)
    
    #Symptom
    SYMP <- symp_preds(acLat = input$latPath,
                       acPF = input$pfPath,
                       age = input$age,
                       bmi = bmi(),
                       ed = input$education,
                       graft = input$graft,
                       prevMedSurgery = input$prevMed,
                       reconType = input$recon,
                       smoking = input$smoking,
                       sport = input$sport,
                       subCL = input$subCL,
                       subIL = input$subIL,
                       symp = symp(),
                       timePoint = input$timePoint)
    
    preds <- data.frame(ADL,
                        QOL,
                        PAIN,
                        SAR,
                        SYMP,
                        IKDC,
                        MARX)
    rownames(preds) <- '10 year predictions'
    preds
  })
  
  #Show the table of current predictions for the ones selected
  output$currentPreds <- renderTable({
    if(length(input$selectedPROs) > 0) {
       current_predictions()[, input$selectedPROs, drop = FALSE]
    }
  },
  rownames = FALSE,
  )
  
  ####################################



}