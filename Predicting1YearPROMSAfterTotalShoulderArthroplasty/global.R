# load 1-year TSA model object - 10/9/2023
library(shiny);library(shinythemes);library(plyr);library(dplyr);library(ggplot2);library(reshape2);library(rms);library(betareg)

#Loading all of the models stored in RData file
load(file = 'TSA_MODELS.RData')

#Functions that return predictions
##PSS Total
pss_total_preds <- function(age,
                       gender,
                       race,
                       bmi,
                       cci,
                       smoking,
                       education,
                       adi,
                       insurance,
                       mcs0,
                       psydx,
                       opioid,
                       chronicpain,
                       priorsurgery,
                       dximplant,
                       gbl,
                       hcomp,
                       sprotatorcuff,
                       pss0
                       ) {
  
    #Creating data frame
    new_dat <- data.frame('Age_c' = age,
                          'Sex' = gender,
                          'Race' = race,
                          'BMI_c' = bmi,
                          'CCI_c' = cci,
                          'Smoking' = smoking,
                          'Education_c' = education,
                          'ADI_c' = adi,
                          'Insurance' = insurance,
                          'MCS0_c' = mcs0,
                          'PsyDx' = psydx,
                          'Opioid' = opioid,
                          'ChronicPain' = chronicpain,
                          'PriorSurg' = priorsurgery,
                          'DxImplant' = dximplant,
                          'GBL' = gbl,
                          'HComp' = hcomp,
                          'SPRotatorCuff' = sprotatorcuff,
                          'PSS0_c' = pss0)
    round(100*colMeans(do.call(rbind.data.frame, lapply(pss1_mod_beta, predict, newdata = new_dat, type = "link"))), digits = 1)
}

pss_pain_preds <- function(age,
                            gender,
                            race,
                            bmi,
                            cci,
                            smoking,
                            education,
                            adi,
                            insurance,
                            mcs0,
                            psydx,
                            opioid,
                            chronicpain,
                            priorsurgery,
                            dximplant,
                            gbl,
                            hcomp,
                            sprotatorcuff,
                            pss0
) {
  
  #Creating data frame
  new_dat <- data.frame('Age_c' = age,
                        'Sex' = gender,
                        'Race' = race,
                        'BMI_c' = bmi,
                        'CCI_c' = cci,
                        'Smoking' = smoking,
                        'Education_c' = education,
                        'ADI_c' = adi,
                        'Insurance' = insurance,
                        'MCS0_c' = mcs0,
                        'PsyDx' = psydx,
                        'Opioid' = opioid,
                        'ChronicPain' = chronicpain,
                        'PriorSurg' = priorsurgery,
                        'DxImplant' = dximplant,
                        'GBL' = gbl,
                        'HComp' = hcomp,
                        'SPRotatorCuff' = sprotatorcuff,
                        'PSS0_c' = pss0)
  round(30*colMeans(do.call(rbind.data.frame, lapply(pain1_mod_beta, predict, newdata = new_dat, type = "link"))), digits = 1)
}

pss_func_preds <- function(age,
                            gender,
                            race,
                            bmi,
                            cci,
                            smoking,
                            education,
                            adi,
                            insurance,
                            mcs0,
                            psydx,
                            opioid,
                            chronicpain,
                            priorsurgery,
                            dximplant,
                            gbl,
                            hcomp,
                            sprotatorcuff,
                            pss0
) {
  
  #Creating data frame
  new_dat <- data.frame('Age_c' = age,
                        'Sex' = gender,
                        'Race' = race,
                        'BMI_c' = bmi,
                        'CCI_c' = cci,
                        'Smoking' = smoking,
                        'Education_c' = education,
                        'ADI_c' = adi,
                        'Insurance' = insurance,
                        'MCS0_c' = mcs0,
                        'PsyDx' = psydx,
                        'Opioid' = opioid,
                        'ChronicPain' = chronicpain,
                        'PriorSurg' = priorsurgery,
                        'DxImplant' = dximplant,
                        'GBL' = gbl,
                        'HComp' = hcomp,
                        'SPRotatorCuff' = sprotatorcuff,
                        'PSS0_c' = pss0)
  round(60*colMeans(do.call(rbind.data.frame, lapply(func1_mod_beta, predict, newdata = new_dat, type = "link"))), digits = 1)
}

pss_sat_preds <- function(age,
                           gender,
                           race,
                           bmi,
                           cci,
                           smoking,
                           education,
                           adi,
                           insurance,
                           mcs0,
                           psydx,
                           opioid,
                           chronicpain,
                           priorsurgery,
                           dximplant,
                           gbl,
                           hcomp,
                           sprotatorcuff,
                           pss0
) {
  
  #Creating data frame
  new_dat <- data.frame('Age' = age,
                        'Sex' = gender,
                        'Race' = race,
                        'BMI' = bmi,
                        'CCI' = cci,
                        'Smoking' = smoking,
                        'Education' = education,
                        'ADI' = adi,
                        'Insurance' = insurance,
                        'MCS0' = mcs0,
                        'PsyDx' = psydx,
                        'Opioid' = opioid,
                        'ChronicPain' = chronicpain,
                        'PriorSurg' = priorsurgery,
                        'DxImplant' = dximplant,
                        'GBL' = gbl,
                        'HComp' = hcomp,
                        'SPRotatorCuff' = sprotatorcuff,
                        'PSS0' = pss0)
  round(predict(sat, newdata = new_dat, type = "mean"), digits = 1)
}

#Functions used to generate buttons on questionaires
pssQuestion <- function(inputId, label) {
  radioButtons(inputId = inputId,
               label = span(label,
                            style = 'font-size:16px'),
               choices = c('No difficulty' = 3,
                           'Some difficulty' = 2,
                           'Much difficulty' = 1,
                           "Can't do at all" = 0,
                           "Did not do before injury" = NA),
               inline = TRUE)
}
