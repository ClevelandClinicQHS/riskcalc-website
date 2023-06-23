#2018-04-26 loads objects/packages used by the application
library(shiny);library(shinythemes);library(plyr);library(dplyr);library(ggplot2);library(reshape2);library(rms)

#Loading all of the models (21) stored in RData file
load(file = 'MOON_MODELS.RData')

#Loading factor levels and summaries to display in input objects
load(file = 'variable_summaries.RData')
X <- variable_summaries


#Functions that return predictions for each outcome
######MARX
marx_preds <- function(age,
                       bmi,
                       comp,
                       ed,
                       gender,
                       graft,
                       laxity,
                       prevMedSurgery,
                       subCL,
                       subIL,
                       fixation,
                       marx,
                       timePoint) {
  
  #Depends on time point
  if(timePoint == 'None') {
    #Creating data frame
    new_dat <- data.frame('Age' = age,
                          'BMI0' = bmi,
                          'CompetitionLevel' = comp,
                          'Education' = ed,
                          'Gender' = gender,
                          'GraftType' = graft,
                          'HighGradeLaxity' = laxity,
                          'MARX0' = marx,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'TibialFixation' = fixation)
    predict(MOON_MODELS$MARX$Baseline, newdata = new_dat, type = 'mean')
    
  } else if(timePoint == 'Two') {
    #Creating data frame
    new_dat <- data.frame('Age' = age,
                          'BMI2' = bmi,
                          'CompetitionLevel' = comp,
                          'Education' = ed,
                          'Gender' = gender,
                          'GraftType' = graft,
                          'HighGradeLaxity' = laxity,
                          'MARX2' = marx,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'SubsequentSurgeryContralateral' = ifelse(subCL == 'ACL reconstruction', 'Revision ACL reconstruction/TKA', subCL),
                          'SubsequentSurgeryIpsilateral' = ifelse(subIL == 'Revision ACL reconstruction', 'Revision ACL reconstruction/TKA', subIL),
                          'TibialFixation' = fixation)
    predict(MOON_MODELS$MARX$Year2, newdata = new_dat, type = 'mean')
  } else {
    #Creating data frame
    new_dat <- data.frame('Age' = age,
                          'BMI6' = bmi,
                          'CompetitionLevel' = comp,
                          'Education' = ed,
                          'Gender' = gender,
                          'GraftType' = graft,
                          'HighGradeLaxity' = laxity,
                          'MARX6' = marx,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'SubsequentSurgeryContralateral' = ifelse(subCL == 'ACL reconstruction', 'Revision ACL reconstruction/TKA', subCL),
                          'SubsequentSurgeryIpsilateral' = ifelse(subIL == 'Revision ACL reconstruction', 'Revision ACL reconstruction/TKA', subIL),
                          'TibialFixation' = fixation)
    predict(MOON_MODELS$MARX$Year6, newdata = new_dat, type = 'mean')
  }
}

#####IKDC
ikdc_preds <- function(acLat,
                       acMed,
                       acPF,
                       bmi,
                       ed,
                       gender,
                       marx,
                       prevMedSurgery,
                       reconType,
                       smoking,
                       sport,
                       subCL,
                       subIL,
                       ikdc,
                       timePoint) {
  
  if(timePoint == 'None') {
    
    #Creating data frame
    new_dat <- data.frame('ACLateralPathology' = acLat,
                          'ACMedialPathology' = acMed,
                          'ACPatellofemoralPathology' = acPF,
                          'BMI0' = bmi,
                          'Education' = ed,
                          'Gender' = gender,
                          'MARX0' = marx,
                          'IKDC0' = ikdc,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus0' = smoking,
                          'Sport' = sport)
    predict(MOON_MODELS$IKDC$Baseline, newdata = new_dat, type = 'mean')
    
  } else if(timePoint == 'Two') {
    #Creating data frame
    new_dat <- data.frame('ACLateralPathology' = acLat,
                          'ACMedialPathology' = acMed,
                          'ACPatellofemoralPathology' = acPF,
                          'BMI2' = bmi,
                          'Education' = ed,
                          'Gender' = gender,
                          'MARX2' = marx,
                          'IKDC2' = ikdc,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus2' = smoking,
                          'Sport' = sport,
                          'SubsequentSurgeryContralateral' = subCL,
                          'SubsequentSurgeryIpsilateral' = subIL)
    predict(MOON_MODELS$IKDC$Year2, newdata = new_dat, type = 'mean')
    
  } else {
    
    #Creating data frame
    new_dat <- data.frame('ACLateralPathology' = acLat,
                          'ACMedialPathology' = acMed,
                          'ACPatellofemoralPathology' = acPF,
                          'BMI6' = bmi,
                          'Education' = ed,
                          'Gender' = gender,
                          'MARX6' = marx,
                          'IKDC6' = ikdc,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus6' = smoking,
                          'Sport' = sport,
                          'SubsequentSurgeryContralateral' = subCL,
                          'SubsequentSurgeryIpsilateral' = subIL)
    predict(MOON_MODELS$IKDC$Year6, newdata = new_dat, type = 'mean')
  }
}


#################KOOS
##ADL
adl_preds <- function(age,
                      bmi,
                      comp,
                      ed,
                      gender,
                      graft,
                      marx,
                      prevACLR,
                      prevMedSurgery,
                      sport,
                      subCL,
                      subIL,
                      fixation,
                      adl,
                      timePoint) {
  
  if(timePoint == 'None') {
    
    #Creating data frame
    new_dat <- data.frame('Age' = age,
                          'BMI0' = bmi,
                          'CompetitionLevel' = comp,
                          'Education' = ed,
                          'Gender' = gender,
                          'GraftType' = graft,
                          'MARX0' = marx,
                          'ADL0' = adl,
                          'PreviousACLRContralateralKnee' = prevACLR,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'Sport' = sport,
                          'TibialFixation' = fixation)
    predict(MOON_MODELS$KOOS$ADL$Baseline, newdata = new_dat, type = 'mean')
    
  } else if(timePoint == 'Two') {
    
    #Creating data frame
    new_dat <- data.frame('Age' = age,
                          'BMI2' = bmi,
                          'CompetitionLevel' = comp,
                          'Education' = ed,
                          'Gender' = gender,
                          'GraftType' = graft,
                          'MARX2' = marx,
                          'ADL2' = adl,
                          'PreviousACLRContralateralKnee' = prevACLR,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'Sport' = sport,
                          'SubsequentSurgeryContralateral' = subCL,
                          'SubsequentSurgeryIpsilateral' = subIL,
                          'TibialFixation' = fixation)
    predict(MOON_MODELS$KOOS$ADL$Year2, newdata = new_dat, type = 'mean')
    
  } else {
    
    #Creating data frame
    new_dat <- data.frame('Age' = age,
                          'BMI6' = bmi,
                          'CompetitionLevel' = comp,
                          'Education' = ed,
                          'Gender' = gender,
                          'GraftType' = graft,
                          'MARX6' = marx,
                          'ADL6' = adl,
                          'PreviousACLRContralateralKnee' = prevACLR,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'Sport' = sport,
                          'SubsequentSurgeryContralateral' = subCL,
                          'SubsequentSurgeryIpsilateral' = subIL,
                          'TibialFixation' = fixation)
    predict(MOON_MODELS$KOOS$ADL$Year6, newdata = new_dat, type = 'mean')
  }
}

##QOL
qol_preds <- function(acLatFrac,
                      acMed,
                      acPF,
                      age,
                      bmi,
                      graft,
                      latMenPath,
                      marx,
                      prevILknee, 
                      prevMedSurgery,
                      reconType,
                      smoking,
                      sport,
                      subCL,
                      subIL,
                      exposure,
                      qol,
                      timePoint) {
  
  if(timePoint == 'None') {
    #Creating data frame
    new_dat <- data.frame('ACLateralFracturePathology' = acLatFrac,
                          'ACMedialPathology' = acMed,
                          'ACPatellofemoralPathology' = acPF,
                          'Age' = age,
                          'BMI0' = bmi,
                          'GraftType' = graft,
                          'LateralMeniscalPathology' = latMenPath,
                          'MARX0' = marx,
                          'QOL0' = qol,
                          'PreviousILKneeSurgery' = prevILknee,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus0' = smoking,
                          'Sport' = sport,
                          'SurgicalExposure' = exposure)
    predict(MOON_MODELS$KOOS$QOL$Baseline, newdata = new_dat, type = 'mean')
    
  } else if(timePoint == 'Year2') {
    #Creating data frame
    new_dat <- data.frame('ACLateralFracturePathology' = acLatFrac,
                          'ACMedialPathology' = acMed,
                          'ACPatellofemoralPathology' = acPF,
                          'Age' = age,
                          'BMI2' = bmi,
                          'GraftType' = graft,
                          'LateralMeniscalPathology' = latMenPath,
                          'MARX2' = marx,
                          'QOL2' = qol,
                          'PreviousILKneeSurgery' = prevILknee,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus2' = smoking,
                          'Sport' = sport,
                          'SubsequentSurgeryContralateral' = ifelse(subCL == 'ACL reconstruction', 'Revision ACL reconstruction/TKA', subCL),
                          'SubsequentSurgeryIpsilateral' = ifelse(subIL == 'Revision ACL reconstruction', 'Revision ACL reconstruction/TKA', subIL),
                          'SurgicalExposure' = exposure)
    predict(MOON_MODELS$KOOS$QOL$Year2, newdata = new_dat, type = 'mean')
  } else {
    #Creating data frame
    new_dat <- data.frame('ACLateralFracturePathology' = acLatFrac,
                          'ACMedialPathology' = acMed,
                          'ACPatellofemoralPathology' = acPF,
                          'Age' = age,
                          'BMI6' = bmi,
                          'GraftType' = graft,
                          'LateralMeniscalPathology' = latMenPath,
                          'MARX6' = marx,
                          'QOL6' = qol,
                          'PreviousILKneeSurgery' = prevILknee,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus6' = smoking,
                          'Sport' = sport,
                          'SubsequentSurgeryContralateral' = ifelse(subCL == 'ACL reconstruction', 'Revision ACL reconstruction/TKA', subCL),
                          'SubsequentSurgeryIpsilateral' = ifelse(subIL == 'Revision ACL reconstruction', 'Revision ACL reconstruction/TKA', subIL),
                          'SurgicalExposure' = exposure)
    predict(MOON_MODELS$KOOS$QOL$Year6, newdata = new_dat, type = 'mean')
  }
}

##Pain
pain_preds <- function(acLat,
                       acMed,
                       acPF,
                       age,
                       bmi,
                       graft,
                       prevMedSurgery,
                       reconType,
                       smoking,
                       sport,
                       subCL,
                       subIL,
                       pain,
                       timePoint) {
  
  if(timePoint == 'None') {
    #Creating data frame
    new_dat <- data.frame('ACLateralPathology' = acLat,
                          'ACMedialPathology' = acMed,
                          'ACPatellofemoralPathology' = acPF,
                          'Age' = age,
                          'BMI0' = bmi,
                          'GraftType' = graft,
                          'Pain0' = pain,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus0' = smoking,
                          'Sport' = sport)
    predict(MOON_MODELS$KOOS$PAIN$Baseline, newdata = new_dat, type = 'mean')
    
  } else if(timePoint == 'Two') {
    
    #Creating data frame
    new_dat <- data.frame('ACLateralPathology' = acLat,
                          'ACMedialPathology' = acMed,
                          'ACPatellofemoralPathology' = acPF,
                          'Age' = age,
                          'BMI2' = bmi,
                          'GraftType' = graft,
                          'Pain2' = pain,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus2' = smoking,
                          'Sport' = sport,
                          'SubsequentSurgeryContralateral' = subCL,
                          'SubsequentSurgeryIpsilateral' = subIL)
    predict(MOON_MODELS$KOOS$PAIN$Year2, newdata = new_dat, type = 'mean')
    
  } else {
    
    #Creating data frame
    new_dat <- data.frame('ACLateralPathology' = acLat,
                          'ACMedialPathology' = acMed,
                          'ACPatellofemoralPathology' = acPF,
                          'Age' = age,
                          'BMI6' = bmi,
                          'GraftType' = graft,
                          'Pain6' = pain,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus6' = smoking,
                          'Sport' = sport,
                          'SubsequentSurgeryContralateral' = subCL,
                          'SubsequentSurgeryIpsilateral' = subIL)
    predict(MOON_MODELS$KOOS$PAIN$Year6, newdata = new_dat, type = 'mean')
    
  }
}

##SAR
SAR_preds <- function(acLat,
                      acMed,
                      acPF,
                      age,
                      bmi,
                      gender,
                      prevMedSurgery,
                      reconType,
                      smoking,
                      sport,
                      subCL,
                      subIL,
                      sar,
                      timePoint) {

  if(timePoint == 'None') {
    
    #Creating data frame
    new_dat <- data.frame('ACLateralPathology' = acLat,
                          'ACMedialPathology' = acMed,
                          'ACPatellofemoralPathology' = acPF,
                          'Age' = age,
                          'BMI0' = bmi,
                          'Gender' = gender,
                          'SAR0' = sar,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus0' = smoking,
                          'Sport' = sport)
    predict(MOON_MODELS$KOOS$SAR$Baseline, newdata = new_dat, type = 'mean')
    
    
  } else if(timePoint == 'Two') {
    
    #Creating data frame
    new_dat <- data.frame('ACLateralPathology' = acLat,
                          'ACMedialPathology' = acMed,
                          'ACPatellofemoralPathology' = acPF,
                          'Age' = age,
                          'BMI2' = bmi,
                          'Gender' = gender,
                          'SAR2' = sar,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus2' = smoking,
                          'Sport' = sport,
                          'SubsequentSurgeryContralateral' = subCL,
                          'SubsequentSurgeryIpsilateral' = subIL)
    predict(MOON_MODELS$KOOS$SAR$Year2, newdata = new_dat, type = 'mean')
    
  } else {
    
    #Creating data frame
    new_dat <- data.frame('ACLateralPathology' = acLat,
                          'ACMedialPathology' = acMed,
                          'ACPatellofemoralPathology' = acPF,
                          'Age' = age,
                          'BMI6' = bmi,
                          'Gender' = gender,
                          'SAR6' = sar,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus6' = smoking,
                          'Sport' = sport,
                          'SubsequentSurgeryContralateral' = subCL,
                          'SubsequentSurgeryIpsilateral' = subIL)
    predict(MOON_MODELS$KOOS$SAR$Year6, newdata = new_dat, type = 'mean')
    
  }
}

#Symp
symp_preds <- function(acLat,
                       acPF,
                       age,
                       bmi,
                       ed,
                       graft,
                       prevMedSurgery,
                       reconType,
                       smoking,
                       sport,
                       subCL,
                       subIL,
                       symp,
                       timePoint) {
  
  if(timePoint == 'None') {
    
    #Creating data frame
    new_dat <- data.frame('ACLateralPathology' = acLat,
                          'ACPatellofemoralPathology' = acPF,
                          'Age' = age,
                          'BMI0' = bmi,
                          'Education' = ed,
                          'GraftType' = graft,
                          'SYMP0' = symp,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus0' = smoking,
                          'Sport' = sport)
    predict(MOON_MODELS$KOOS$SYMP$Baseline, newdata = new_dat, type = 'mean')
    
    
  } else if(timePoint == 'Two') {
    
    #Creating data frame
    new_dat <- data.frame('ACLateralPathology' = acLat,
                          'ACPatellofemoralPathology' = acPF,
                          'Age' = age,
                          'BMI2' = bmi,
                          'Education' = ed,
                          'GraftType' = graft,
                          'SYMP2' = symp,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus2' = smoking,
                          'Sport' = sport,
                          'SubsequentSurgeryContralateral' = subCL,
                          'SubsequentSurgeryIpsilateral' = subIL)
    predict(MOON_MODELS$KOOS$SYMP$Year2, newdata = new_dat, type = 'mean')
    
  } else {
    
    #Creating data frame
    new_dat <- data.frame('ACLateralPathology' = acLat,
                          'ACPatellofemoralPathology' = acPF,
                          'Age' = age,
                          'BMI6' = bmi,
                          'Education' = ed,
                          'GraftType' = graft,
                          'SYMP6' = symp,
                          'PreviousMedialMeniscusSurgery' = prevMedSurgery,
                          'ReconstructionType' = reconType,
                          'SmokingStatus6' = smoking,
                          'Sport' = sport,
                          'SubsequentSurgeryContralateral' = subCL,
                          'SubsequentSurgeryIpsilateral' = subIL)
    predict(MOON_MODELS$KOOS$SYMP$Year6, newdata = new_dat, type = 'mean')
    
  }
}

#Functions used to generate buttons on questionaires
adlQuestion <- function(inputId, label) {
  radioButtons(inputId = inputId,
               label = span(label,
                            style = 'font-size:16px'),
               choices = c('None' = 0,
                           'Mild' = 1, 
                           'Moderate' = 2, 
                           'Severe' = 3, 
                           'Extreme' = 4),
               inline = TRUE)
}
qolQuestion <- function(inputId, label, choices) {
  radioButtons(inputId = inputId,
               label = span(label,
                            style = 'font-size:16px'),
               choices = choices,
               inline = TRUE)
}

painQuestion <- function(inputId, label) {
  radioButtons(inputId = inputId,
               label = span(label,
                            style = 'font-size:16px'),
               choices = c('None' = 0,
                           'Mild' = 1, 
                           'Moderate' = 2, 
                           'Severe' = 3, 
                           'Extreme' = 4),
               inline = TRUE)
}
sarQuestion <- function(inputId, label) {
  radioButtons(inputId = inputId,
               label = span(label,
                            style = 'font-size:16px'),
               choices = c('None' = 0,
                           'Mild' = 1, 
                           'Moderate' = 2, 
                           'Severe' = 3, 
                           'Extreme' = 4),
               inline = TRUE)
}
sympQuestion <- function(inputId, label) {
  radioButtons(inputId = inputId,
               label = span(label,
                            style = 'font-size:16px'),
               choices = c('Never' = 0,
                           'Rarely' = 1,
                           'Sometimes' = 2,
                           'Often' = 3,
                           'Always' = 4),
               inline = TRUE)
}
ikdcQuestion <- function(inputId, label) {
  radioButtons(inputId = inputId,
               label = span(label,
                            style = 'font-size:16px'),
               choices = c('Not difficult at all' = 4,
                           'Minimally difficult' = 3,
                           'Moderately difficult' = 2,
                           'Extremely difficult' = 1,
                           'Unable to do' = 0),
               inline = TRUE)
}
marxQuestion <- function(inputId, label) {
  radioButtons(inputId = inputId,
               label = span(label,
                            style = 'font-size:16px'),
               choices = c('Less than one time in a month' = 0,
                           'One time in a month' = 1,
                           'One time in a week' = 2,
                           '2 or 3 times in a week' = 3,
                           '4 or more times in a week' = 4),
               inline = TRUE)
}













