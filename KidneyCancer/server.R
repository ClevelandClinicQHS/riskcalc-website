predict.5yr.recurrence <- expression({
    lp <- -2.2663667 + 
        0.3495471 * TumorSize  - 
        0.0048203249 * max(TumorSize  - 2, 0)**3 + 
        0.0070686107 * max(TumorSize  - 4.5, 0)**3 - 
        0.0022482858 * max(TumorSize - 9.8600001, 0)**3 + 
        0.76804599 * (x002pT == "T1B") + 
        1.2224612 * (x002pT == "T2") + 
        0.6072083 * (x002pT ==  "T3A") + 
        1.2256599 * (x002pT == "T3B") - 
        0.027493306 *(Grade == "2") + 
        0.77953063 * (Grade == "3") + 
        1.7837761 * (Grade == "4") - 
        0.4571629 * (Necrosis == "Yes") + 
        1.055646 * (VascInv == "Yes") + 
        0.10020175 * (Symptoms == "Local") + 
        0.91678454 * (Symptoms == "Systemic")
    100 * 0.9268816 ** exp(lp)
})
predict.5yr.free <- expression({
    lp <- -1.8397306 - 
        0.010522791 * (Symptoms == "Local") + 
        0.85698406 * (Symptoms == "Systemic") + 
        1.0831942 * (Histology == "Conventional") + 
        0.2448591 * (Histology == "Papillary") + 
        0.13834412 * TumorSize + 
        0.52675363 * (PStage97 == "P2") + 
        0.19334187 * (PStage97 == "P3A") + 
        0.86140642 * (PStage97 == "P3B/C")
    100 * 0.9047495 ** exp(lp)
})
predict.7yr <- expression({
    lp <- -15.425512 + 
        0.047061823 * AgeYr + 
        0.95896167 * (Gender == "Male") + 
        0.76099693 * (ASA == "2") + 
        0.80715679 * (ASA == "3,4") + 
        10.669886 * PreOpCR - 
        14.13484 * max(PreOpCR - 0.7, 0)**3 + 
        22.615745 * max(PreOpCR - 1, 0)**3 - 
        8.4809043 * max(PreOpCR - 1.5, 0)**3 + 
        0.012251195 * PerDecreaseKidneyVolume 
    100 * 0.917657 ** exp(lp)
})

        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        Symptoms = factor(input$Symptoms, levels = c('Local', 'Systemic', 'Incidental', 'Unknown'))
Histology = factor(input$Histology, levels = c('Conventional', 'Papillary', 'Chromophobe', 'Unknown'))
validate(need(!is.na(as.numeric(input$TumorSize))& as.numeric(input$TumorSize)>=0.5& as.numeric(input$TumorSize)<=21, 'Please input a valid TumorSize'))
TumorSize= as.numeric(input$TumorSize)
PStage97 = factor(input$PStage97, levels = c('P1', 'P2', 'P3A', 'P3B/C', 'Unknown'))
validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=14& as.numeric(input$AgeYr)<=92, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
Gender = factor(input$Gender, levels = c('Female', 'Male'))
ASA = factor(input$ASA, levels = c('0,1', '2', '3,4', 'Unknown'))
validate(need(!is.na(as.numeric(input$PreOpCR))& as.numeric(input$PreOpCR)>=0& as.numeric(input$PreOpCR)<=8.4, 'Please input a valid PreOpCR'))
PreOpCR= as.numeric(input$PreOpCR)
validate(need(!is.na(as.numeric(input$PerDecreaseKidneyVolume))& as.numeric(input$PerDecreaseKidneyVolume)>=-97& as.numeric(input$PerDecreaseKidneyVolume)<=100, 'Please input a valid PerDecreaseKidneyVolume'))
PerDecreaseKidneyVolume= as.numeric(input$PerDecreaseKidneyVolume)
x002pT = factor(input$x002pT, levels = c('T1A', 'T1B', 'T2', 'T3A', 'T3B', 'Unknown'))
Grade = factor(input$Grade, levels = c('1', '2', '3', '4', 'Unknown'))
Necrosis = factor(input$Necrosis, levels = c('No', 'Yes', 'Unknown'))
VascInv = factor(input$VascInv, levels = c('No', 'Yes', 'Unknown'))
data <- data.frame(Symptoms = Symptoms,
Histology = Histology,
TumorSize = TumorSize,
PStage97 = PStage97,
AgeYr = AgeYr,
Gender = Gender,
ASA = ASA,
PreOpCR = PreOpCR,
PerDecreaseKidneyVolume = PerDecreaseKidneyVolume,
x002pT = x002pT,
Grade = Grade,
Necrosis = Necrosis,
VascInv = VascInv)
data})
output$result <- renderDataTable({data = data()
yr5.recurrence <- paste(ifelse(round(eval(predict.5yr.recurrence, data), 0) < 1, "<1", ifelse(round(eval(predict.5yr.recurrence, data), 0) > 99, ">99", round(eval(predict.5yr.recurrence, data), 0))), "%")
yr5.free <- paste(ifelse(round(eval(predict.5yr.free, data), 0) < 1, "<1", ifelse(round(eval(predict.5yr.free, data), 0) > 99, ">99", round(eval(predict.5yr.free, data), 0))), "%")
yr7 <- paste(ifelse(round(eval(predict.7yr, data), 0) < 1, "<1", ifelse(round(eval(predict.7yr, data), 0) > 99, ">99", round(eval(predict.7yr, data), 0))), "%")
res = data.frame(Result = c("5-year Freedom from Recurrence[2]","5-year Recurrence-Free Survival[1]","7-year Freedom from Renal Insufficiency"),
                 Probability = c(yr5.recurrence, yr5.free, yr7))

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
        