predict.chance <- expression({
    lp <- -0.62613936 - 
        3.170787 * (Procedure == "Primary Total Hip Replacement") - 
        2.9693719 * (Procedure == "Primary Total Knee Replacement") - 
        2.8688648 * (Procedure == "Revision Total Hip Replacement") - 
        3.0134282 * (Procedure == "Revision Total Knee Replacement") + 
        0.02310105 * AgeYr + 
        6.3565107e-05 * max(AgeYr - 51, 0)**3 - 
        0.00013167058 * max(AgeYr - 66, 0)**3 + 
        6.8105471e-05 * max(AgeYr - 80, 0)**3 - 
        0.57709746 * (Gender == "Male") + 
        0.027747885 * BMI + 
        8.3517431e-06 * max(BMI - 23.527, 0)**3 - 
        1.4023248e-05 * max(BMI - 30.675, 0)**3 + 
        5.6715048e-06 * max(BMI - 41.201, 0)**3 + 
        0.44551743 * (HeartDisease == "Yes, active monitoring") + 
        0.31760143 * (HeartDisease == "Yes, no active monitoring") + 
        0.50970344 * (Diabetes == "Yes") - 
        0.050698532 * (Hypertension == "Yes") + 
        0.72319153 * (COPD == "Yes") + 
        0.2627684 * (Infection == "Yes") + 
        0.44456122 * (Arthritis == "Yes") + 
        0.48585984 * (PreOpAm == "Impaired Home Distances") - 
        0.37919426 * (PreOpAm == "Independent Community Distances") + 
        0.34849357 * (PreOpAm == "Minimal Ambulation or Wheelchair Bound") + 
        0.062652023 * NumSteps - 
        0.00385497 * max(NumSteps, 0)**3 + 
        0.00770994 * max(NumSteps - 2, 0)**3 - 
        0.00385497 * max(NumSteps - 4, 0)**3 - 
        0.60368469 * (BedLoc == "2nd floor") + 
        0.85758998 * (BathLoc == "2nd floor") + 
        1.8131433 * (Caregiver == "Inconsistent or None") + 
        0.57296662 * (Caregiver == "Occasionally available (2-4 d/wk)") - 
        0.11608513 * (HomeLoc == "More than 150 miles")
    100/(1+exp(-lp))
})
predict.los <- expression({
    lp <- exp(1.349007 - 
                  0.035898704 * (Procedure == "Primary Total Hip Replacement") - 
                  0.016314075 * (Procedure == "Primary Total Knee Replacement") + 
                  0.19095275 * (Procedure == "Revision Total Hip Replacement") + 
                  0.034061432 * (Procedure == "Revision Total Knee Replacement") - 
                  0.0019532707 * AgeYr + 
                  5.9574264e-06 * max(AgeYr - 51, 0)**3 - 
                  1.2340383e-05 * max(AgeYr - 66, 0)**3 + 
                  6.3829569e-06 * max(AgeYr - 80, 0)**3 - 
                  0.00010427186 * (Gender == "Male") + 
                  0.063848519 * log(BMI) + 
                  0.19927087 * (HeartDisease == "Yes, active monitoring") + 
                  0.070466034 * (HeartDisease == "Yes, no active monitoring") + 
                  0.027639259 * (Diabetes == "Yes") + 
                  0.054404594 * (Hypertension == "Yes") + 
                  0.166698 * (COPD == "Yes") + 
                  0.12456521 * (Infection == "Yes") + 
                  0.088039139 * (Arthritis == "Yes") + 
                  0.035231131 * (PreOpAm == "Impaired Home Distances") - 
                  0.0072041117 * (PreOpAm == "Independent Community Distances") + 
                  0.064346681 * (PreOpAm == "Minimal Ambulation or Wheelchair Bound") - 
                  0.0028558802 * (BedLoc == "2nd floor") - 
                  0.01422324 * (BathLoc == "2nd floor") + 
                  0.0066804065 * (Caregiver == "Inconsistent or None") - 
                  0.011863962 * (Caregiver == "Occasionally available (2-4 d/wk)") + 
                  0.047527985 * (HomeLoc == "More than 150 miles")) - 1
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=10& as.numeric(input$AgeYr)<=100, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
Gender = factor(input$Gender, levels = c('Male', 'Female'))
Procedure = factor(input$Procedure, levels = c('Primary Total Hip Replacement', 'Primary Total Knee Replacement', 'Revision Total Hip Replacement', 'Revision Total Knee Replacement', 'Bilateral Total Knee Replacement'))
validate(need(!is.na(as.numeric(input$BMI))& as.numeric(input$BMI)>=15& as.numeric(input$BMI)<=55, 'Please input a valid BMI'))
BMI= as.numeric(input$BMI)
HeartDisease = factor(input$HeartDisease, levels = c('No', 'Yes, active monitoring', 'Yes, no active monitoring'))
Arthritis = factor(input$Arthritis, levels = c('No', 'Yes'))
COPD = factor(input$COPD, levels = c('No', 'Yes'))
Diabetes = factor(input$Diabetes, levels = c('No', 'Yes'))
Hypertension = factor(input$Hypertension, levels = c('No', 'Yes'))
Infection = factor(input$Infection, levels = c('No', 'Yes'))
PreOpAm = factor(input$PreOpAm, levels = c('Independent Community Distances', 'Impaired Community Distances', 'Impaired Home Distances', 'Minimal Ambulation or Wheelchair Bound'))
validate(need(!is.na(as.numeric(input$NumSteps))& as.numeric(input$NumSteps)>=0& as.numeric(input$NumSteps)<=30, 'Please input a valid NumSteps'))
NumSteps= as.numeric(input$NumSteps)
BedLoc = factor(input$BedLoc, levels = c('1st floor', '2nd floor'))
BathLoc = factor(input$BathLoc, levels = c('1st floor', '2nd floor'))
Caregiver = factor(input$Caregiver, levels = c('Consistent/Live in (5-7 d/wk)', 'Occasionally available (2-4 d/wk)', 'Inconsistent or None'))
HomeLoc = factor(input$HomeLoc, levels = c('Up to 150 miles', 'More than 150 miles'))
data <- data.frame(AgeYr = AgeYr,
Gender = Gender,
Procedure = Procedure,
BMI = BMI,
HeartDisease = HeartDisease,
Arthritis = Arthritis,
COPD = COPD,
Diabetes = Diabetes,
Hypertension = Hypertension,
Infection = Infection,
PreOpAm = PreOpAm,
NumSteps = NumSteps,
BedLoc = BedLoc,
BathLoc = BathLoc,
Caregiver = Caregiver,
HomeLoc = HomeLoc)
data})
output$result <- renderDataTable({data = data()
prob.chance <- paste(ifelse(round(eval(predict.chance, data), 0) < 1, "<1", ifelse(round(eval(predict.chance, data), 0) > 99, ">99", round(eval(predict.chance, data), 0))), "%")
pred.los <- paste(ifelse(round(eval(predict.los, data), 1) < 1, "<1", ifelse(round(eval(predict.los, data), 1) > 99, ">99", round(eval(predict.los, data), 1))), "days")
res = data.frame(Result = c("Chance of NOT Returning Home (at discharge)","Predicted Length of Stay"),
                 Value = c(prob.chance, pred.los))

                res}, options = list(
            pageLength = 10,
            lengthMenu = 0,
            
            searching = 0,
            info = 0,
            paging = 0,
                initComplete = I(
                    "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
        })
        