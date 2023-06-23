#Comparing the risk of all cause mortality, prostate-cancer specific mortality, and prostate cancer diagnosis for patients screened vs. those unscreened (MODELS)
#Risk of same three evens but only patients who have previously had a PSA done (MODELS_SCREENED)

#Server file gives the functionality to the application
require(shiny)
require(ggplot2)
#Need this option for it to run (not sure why?)
options(bitmapType = 'cairo')
require(rms)
require(QHScrnomo)
require(cmprsk)
require(dplyr)
require(faceplot)

#######risk, risks, risk2, risks2 are all functions that give predictions and are used by other functions#########
###################################
#'risk' and 'risks' are functions for the models on both screened and unscreened patients, 
#This function takes a single model and gives the prediction back for the specified time point with the new data
#Returns a length 2 vector with the risk if screened and risk if not screened
risk <- function(model, row, time) {
  #For competing risks predictions
  if(class(model)[1] == 'cmprsk') {
    screen <- predict.cmprsk(model, newdata = cbind(row, "arm" = "1"), time = time)
    control <- predict.cmprsk(model, newdata = cbind(row, "arm" = "2"), time = time)
  } else {
    #For the Cox PH predictions
    screen <- (1-survest(model, newdata = cbind(row, "arm" = "1"), times = time)$surv)
    control <- (1-survest(model, newdata = cbind(row, "arm" = "2"), times = time)$surv)
  }
  c(screen, control)
}

#This function is called after the user inputs information
#It translates the inputs to syntax for model predictions
#And calls 'risk' for each model in MODELS (screened and unscreened patients)
risks <- function(age, ethnicity, cci, marital, education, famhx, time) {
  ethnicity <- ifelse(ethnicity == 'White/Non-hispanic', "0",
                      ifelse(ethnicity == 'Black/Non-hispanic', "1", "2"))
  cci <- ifelse(cci == '3+', '3', cci)
  marital <- ifelse(marital == 'Married', "0",
                    ifelse(marital == 'Divorced/Separated', '1',
                           ifelse(marital == 'Widowed', '2', '3')))
  education <- ifelse(education == 'Less than high school', '0',
                      ifelse(education == 'High school/Some college', '1', '2'))
  famhx <- ifelse(famhx == 'None', '0',
                  ifelse(famhx == '1 family member', '1', '2'))
  row <- data.frame(age, ethnicity, cci, marital, education, famhx)
  t(simplify2array(lapply(MODELS, risk, row, time)))
}
#########################################

#Does the same thing as 'risk' but only for patients with prior PSA (MODELS_SCREENED)
#Therefore there is NO 'arm' predictor variable
risk2 <- function(model, row, time) {
  if(class(model)[1] == 'cmprsk') {
    predict.cmprsk(model, newdata = row, time = time)
  } else {
    (1-survest(model, newdata = row, times = time)$surv)
  }
}

#Does the same thing as 'risks' but calls the 'risk2' function instead. (Applied to MODELS_SCREENED)
risks2 <- function(age, ethnicity, cci, marital, education, famhx, prior_psa, time) {
  ethnicity <- ifelse(ethnicity == 'White/Non-hispanic', "0",
                      ifelse(ethnicity == 'Black/Non-hispanic', "1", "2"))
  cci <- ifelse(cci == '3+', '3', cci)
  marital <- ifelse(marital == 'Married', "0",
                    ifelse(marital == 'Divorced/Separated', '1',
                           ifelse(marital == 'Widowed', '2', '3')))
  education <- ifelse(education == 'Less than high school', '0',
                      ifelse(education == 'High school/Some college', '1', '2'))
  famhx <- ifelse(famhx == 'None', '0',
                  ifelse(famhx == '1 family member', '1', '2'))
  row <- data.frame(age, ethnicity, cci, marital, education, famhx, "psa_level0" = prior_psa)
  unlist(lapply(MODELS_screened, risk2, row, time))
}


function(input, output, session) {
  
  #'get_risks' takes the inputs from the user and actually calls the 'risks' --> 'risk' functions above (for MODELS)
  #Returns a data frame of the form displayed in the application when prior PSA = 'No'
  get_risks <- reactive({
    cics <- risks(age = as.numeric(Sys.Date() - input$dob)/365.25,
          ethnicity = input$ethnicity,
          cci = input$cci,
          marital = input$marital,
          education = input$education,
          famhx = input$famhx,
          time = input$times)
    rownames(cics) <- c("All-cause mortality", "PC specific mortality","PC Diagnosis")
    cics <- data.frame(cics[c(1,3,2),])
    cics
  })
  
  #'get_risks2' does the same as 'get_risks' but only displays a single row single its only screened patients (MODELS_screened)
  get_risks2 <- reactive({
    cics <- risks2(age = as.numeric(Sys.Date() - input$dob)/365.25,
                   ethnicity = input$ethnicity,
                   cci = input$cci,
                   marital = input$marital,
                   education = input$education,
                   famhx = input$famhx,
                   prior_psa = input$prior_psa,
                   time = input$times)
    cics <- matrix(cics, nrow = 1)
    cics
  })
  
  #Depending on the prediction horizon, displays text of how many years predictions are for
  output$riskTime <- renderText({
    paste0(input$times, "-year risks")
  })
  
  #Tidy's up data frame returned by get_risks, and attaches '%' symbols for display
  output$riskTable <- renderTable({
    diag_table <- get_risks()
    names(diag_table) <- c("Screened", "Not Screened")
    diag_table$Screened <- paste0(round(diag_table$Screened*100,1), "%")
    diag_table$`Not Screened` <- paste0(round(diag_table$`Not Screened`*100,1), "%")
    diag_table
  }, rownames = TRUE, spacing = "l", width = "500", align = 'lcc')
  
  #Similar to riskTable but only has a single row; '%' symbols were attached in 'get_risks2'
  output$riskTable3 <- renderTable({
    diag_table <- get_risks2()
    diag_table <- data.frame("All-cause mortality" = paste0(round(diag_table[,1]*100,1), "%"), 
                       "PC Diagnosis" = paste0(round(diag_table[,3]*100,1), "%"), 
                       "PC specific mortality" = paste0(round(diag_table[,2]*100, 1), "%"))
    names(diag_table) <- c("All-cause mortality", "PC Diagnosis", "PC specific mortality")
    diag_table
  }, spacing = "l", width = "500", align = 'c')
  
  output$faceplot1 <- renderFaceplot({
      diag_table = get_risks()
      meh = round(diag_table$X1[2] * 1000, 0)
      sad = round(diag_table$X1[3] * 1000, 0)
      frown = round(diag_table$X1[1] * 1000, 0) - sad
      smile = 1000 - meh - frown - sad
      faceplot(smile = smile, meh = meh, frown = frown, sad = sad)
  })
  
  output$faceplot2 <- renderFaceplot({
      diag_table = get_risks()
      meh = round(diag_table$X2[2] * 1000, 0)
      sad = round(diag_table$X2[3] * 1000, 0)
      frown = round(diag_table$X2[1] * 1000, 0) - sad
      smile = 1000 - meh - frown - sad
      faceplot(smile = smile, meh = meh, frown = frown, sad = sad)
  })
  
  output$faceplot3 <- renderFaceplot({
      diag_table = get_risks2()
      meh = round(diag_table[,3] * 1000, 0)
      frown = round(diag_table[,1] * 1000, 0)
      sad = round(diag_table[,2] * 1000, 0)
      smile = 1000 - meh - frown - sad
      faceplot(smile = smile, meh = meh, frown = frown, sad = sad)
  })

}



