formula1 <- expression({
    lp <- 2.6354685 - 0.047334221 * AgeYr + 
        1.502323e-05 * max(AgeYr - 26, 0)**3 - 
        3.2697617e-05 * max(AgeYr - 46, 0)**3 + 
        1.7674388e-05 * max(AgeYr - 63, 0)**3 - 
        0.20972289 * (DonGender == "Male") -
        0.2002346 * (RaceCat == "Other") - 
        0.22591491 * (RaceCat == "Caucasian") + 
        0.0298452 * BMI + 
        0.008938473 * DonAge - 
        0.11887323 * (DonGender == "Male") - 
        0.37345868 * (DonRaceCat == "Other") -
        0.36085847 * (DonRaceCat == "Caucasian") - 
        0.0023089567 * DonBMI +         
        0.099802904 * DonCreat - 
        0.8791891 * max(DonCreat - 0.7,0)**3 + 
        1.7583782 * max(DonCreat - 0.9, 0)**3 - 
        0.8791891 * max(DonCreat - 1.1, 0)**3 - 
        0.08007996 * (DonProcec == "open") + 
        0.22654438 * HLAMis - 
        0.0050143239 * max(HLAMis, 0)**3 + 
        0.01253581 * max(HLAMis - 3, 0)**3 - 
        0.0075214858 * max(HLAMis - 5, 0)**3 + 
        0.1351898 * (Diaggrpc == "Glomerulonephritis") +         
        0.11797387 * (Diaggrpc == "Other") + 
        1.1348612 * (Diaggrpc == "Retransplant") + 
        0.200742 * (IMDeple == "Yes") + 
        0.0048359778 * (IMIL2 == "Yes") - 
        0.44089499 * (IMAza == "Yes") -         
        0.54011701 * (IMMyco == "Yes") - 
        0.41226268 * (IMRapa == "Yes") - 
        1.3759462 * (IMCalci == "Yes")
    100 * 0.8995217 ** exp(lp)
})
formula2 <- expression({
    lp <- 102.54334 - 
        0.18087905 * AgeYr + 
        0.00012639412 * max(AgeYr - 26, 0)**3 - 
        0.00027509309 * max(AgeYr - 46, 0)**3 + 
        0.00014869897 * max(AgeYr - 63, 0)**3 + 
        0.71241365 * (Gender == "Male") -
        2.8125976 * (RaceCat == "Other") - 
        3.9937634 * (RaceCat == "Caucasian") - 
        0.47167695 * BMI - 
        0.44129477 * DonAge + 
        5.6703826 * (DonGender == "Male") + 
        3.1446029 * (DonRaceCat == "Other") +
        0.6446233 * (DonRaceCat == "Caucasian") + 
        0.16077083 * DonBMI -
        18.370624 * DonCreat + 
        72.758057 * max(DonCreat - 0.7, 0)**3 - 
        145.51611 * max(DonCreat - 0.9, 0)**3 + 
        72.758057 * max(DonCreat - 1.1, 0)**3 - 
        0.5016086 * (DonProcec == "open") -
        0.72768858 * HLAMis + 
        0.015328731 * max(HLAMis, 0)**3 -
        0.038321827 * max(HLAMis - 3, 0)**3 + 
        0.022993096 * max(HLAMis - 5, 0)**3 - 
        2.62507 * (Diaggrpc == "Glomerulonephritis") - 
        1.8280447 * (Diaggrpc =="Other") - 
        0.734478 * (Diaggrpc == "Retransplant") - 
        0.96651454 * (IMDeple == "Yes") + 
        0.1031327 * (IMIL2 == "Yes") + 
        0.70172376 * (IMAza == "Yes") + 
        2.1688863 * (IMMyco == "Yes") -         
        1.5641884 * (IMRapa == "Yes") + 
        1.7851046 * (IMCalci == "Yes")
})

        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        IMMyco = factor(input$IMMyco, levels = c('No', 'Yes'))
IMAza = factor(input$IMAza, levels = c('No', 'Yes'))
IMCalci = factor(input$IMCalci, levels = c('No', 'Yes'))
Diaggrpc = factor(input$Diaggrpc, levels = c('Glomerulonephritis', 'Other', 'Retransplant', 'Diabetes'))
IMDeple = factor(input$IMDeple, levels = c('No', 'Yes'))
validate(need(!is.na(as.numeric(input$DonAge))& as.numeric(input$DonAge)>=30& as.numeric(input$DonAge)<=60, 'Please input a valid DonAge'))
DonAge= as.numeric(input$DonAge)
validate(need(!is.na(as.numeric(input$DonBMI))& as.numeric(input$DonBMI)>=20& as.numeric(input$DonBMI)<=40, 'Please input a valid DonBMI'))
DonBMI= as.numeric(input$DonBMI)
validate(need(!is.na(as.numeric(input$DonCreat))& as.numeric(input$DonCreat)>=0.1& as.numeric(input$DonCreat)<=2, 'Please input a valid DonCreat'))
DonCreat= as.numeric(input$DonCreat)
DonGender = factor(input$DonGender, levels = c('Male', 'Female'))
DonRaceCat = factor(input$DonRaceCat, levels = c('Caucasian', 'African-American', 'Other'))
IMIL2 = factor(input$IMIL2, levels = c('No', 'Yes'))
DonProcec = factor(input$DonProcec, levels = c('Open', 'Laparoscopic'))
IMRapa = factor(input$IMRapa, levels = c('No', 'Yes'))
validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=30& as.numeric(input$AgeYr)<=90, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
validate(need(!is.na(as.numeric(input$BMI))& as.numeric(input$BMI)>=15& as.numeric(input$BMI)<=50, 'Please input a valid BMI'))
BMI= as.numeric(input$BMI)
Gender = factor(input$Gender, levels = c('Male', 'Female'))
validate(need(!is.na(as.numeric(input$HLAMis))& as.numeric(input$HLAMis)>=0& as.numeric(input$HLAMis)<=6, 'Please input a valid HLAMis'))
HLAMis= as.numeric(input$HLAMis)
RaceCat = factor(input$RaceCat, levels = c('Caucasian', 'African-American', 'Other'))
data <- data.frame(IMMyco = IMMyco,
IMAza = IMAza,
IMCalci = IMCalci,
Diaggrpc = Diaggrpc,
IMDeple = IMDeple,
DonAge = DonAge,
DonBMI = DonBMI,
DonCreat = DonCreat,
DonGender = DonGender,
DonRaceCat = DonRaceCat,
IMIL2 = IMIL2,
DonProcec = DonProcec,
IMRapa = IMRapa,
AgeYr = AgeYr,
BMI = BMI,
Gender = Gender,
HLAMis = HLAMis,
RaceCat = RaceCat)
data})
output$result <- renderDataTable({data = data()
prob1 = eval(formula1, data)
prob2 = eval(formula2, data)
res = data.frame(Result = c("Graft Survival 5-Years Post-Transplant","eGFR 1-Year Post-Transplant"), 
                 Outcome = c(paste("Probability: ", round(prob1, 2), "%", sep = ""), paste(round(prob2, 2), "mL/min per 1.73m", sep = "")))

                res}, options = list(
                initComplete = I(
                    "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
        })
        