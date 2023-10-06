# server side
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
                      selected = 'PRO')
  })
  
  
  #####PSS#####################
  ##############################
  
  #Calculating current PSS Total
  pss_total <- reactive({
    if(input$havePSS == 'Yes') {
      input$inputPSS
    } else {
      inds <- names(input)[grepl('PSS_Q', names(input))]
      vals <- c()
      for(i in 1:length(inds)) {
        vals <- c(vals, input[[inds[i]]])
      }
      sum(as.numeric(vals), na.rm = T)
    }
  })
  
  #Print it out below survey
  output$pssCalculated <- renderText({
    paste0('Your current PSS Total score is ', round(pss_total()))
  })
  
  ####################################
  #Getting all current predicted values
  current_predictions <- reactive({
    
    #PSS Total
    PSS_TOTAL <- pss_total_preds(age = input$age/12, # rescale data by iqr
                       gender = input$gender,
                       race = input$race,
                       bmi = bmi()/7.5,
                       cci = input$cci/2,
                       smoking = input$smoking,
                       education = input$education/4,
                       adi = input$adi/35,
                       insurance = input$insurance,
                       mcs0 = input$mcs0/16.88,
                       psydx = input$psydx,
                       opioid = input$opioid,
                       chronicpain = input$chronicpain,
                       priorsurgery = input$priorsurgery,
                       dximplant = input$dximplant,
                       gbl = input$gbl,
                       hcomp = input$hcomp,
                       sprotatorcuff = input$sprotatorcuff,
                       pss0 = pss_total()/20.92)
    
    # PSS Pain
    PSS_PAIN <- pss_pain_preds(age = input$age/12, # rescale data by iqr
                                 gender = input$gender,
                                 race = input$race,
                                 bmi = bmi()/7.5,
                                 cci = input$cci/2,
                                 smoking = input$smoking,
                                 education = input$education/4,
                                 adi = input$adi/35,
                                 insurance = input$insurance,
                                 mcs0 = input$mcs0/16.88,
                                 psydx = input$psydx,
                                 opioid = input$opioid,
                                 chronicpain = input$chronicpain,
                                 priorsurgery = input$priorsurgery,
                                 dximplant = input$dximplant,
                                 gbl = input$gbl,
                                 hcomp = input$hcomp,
                                 sprotatorcuff = input$sprotatorcuff,
                                 pss0 = pss_total()/20.92)
    # PSS Function
    PSS_FUNC <- pss_func_preds(age = input$age/12, # rescale data by iqr
                               gender = input$gender,
                               race = input$race,
                               bmi = bmi()/7.5,
                               cci = input$cci/2,
                               smoking = input$smoking,
                               education = input$education/4,
                               adi = input$adi/35,
                               insurance = input$insurance,
                               mcs0 = input$mcs0/16.88,
                               psydx = input$psydx,
                               opioid = input$opioid,
                               chronicpain = input$chronicpain,
                               priorsurgery = input$priorsurgery,
                               dximplant = input$dximplant,
                               gbl = input$gbl,
                               hcomp = input$hcomp,
                               sprotatorcuff = input$sprotatorcuff,
                               pss0 = pss_total()/20.92)
    # PSS Satisfaction
    PSS_SAT <- pss_sat_preds(age = input$age, 
                              gender = input$gender,
                              race = input$race,
                              bmi = bmi(),
                              cci = input$cci,
                              smoking = input$smoking,
                              education = input$education,
                              adi = input$adi,
                              insurance = input$insurance,
                              mcs0 = input$mcs0,
                              psydx = input$psydx,
                              opioid = input$opioid,
                              chronicpain = input$chronicpain,
                              priorsurgery = input$priorsurgery,
                              dximplant = input$dximplant,
                              gbl = input$gbl,
                              hcomp = input$hcomp,
                              sprotatorcuff = input$sprotatorcuff,
                              pss0 = pss_total())
    
    preds <- data.frame(
      `Item` = c("Predicted 1-Year PSS Total",
                 "Predicted 1-Year PSS Pain",
                 "Predicted 1-Year PSS Function",
                 "Predicted 1-Year PSS Satisfaction"),
      Result = c(PSS_TOTAL, PSS_PAIN, PSS_FUNC, PSS_SAT))
    preds
  })
  
  output$currentPreds <- renderTable({
    current_predictions()
  }
  ,
  rownames = FALSE
  )
  
  ####################################



}