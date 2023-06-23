predict.pc <- expression({
    if (is.na(PVol)) {
        score = -4.6045408 +
            0.047918635 * AgeYr + 
            0.000017180288 * max(AgeYr - 53, 0) ** 3 -
            0.000032642547 * max(AgeYr - 62, 0) ** 3 + 
            0.000015462259 * max(AgeYr - 72, 0) ** 3 + 
            0.43983666 * (DRE == 'Yes, < 1/2 lobe') + 
            1.2128887 * (DRE == 'Yes, > 1/2 lobe') -
            0.078780242 * NegCores +
            0.00026210791 * max(NegCores - 6, 0) ** 3 -
            0.00034947721 * max(NegCores - 12, 0) ** 3 +
            0.000087369303 * max(NegCores - 30, 0) ** 3 +
            0.46787326 * (PrevPIN == "Yes") +
            0.90858563 * (PrevASAP == "Yes") - 
            0.11089304 * log(PSA) + 
            0.20320404 * max(log(PSA) - 1.3441686, 0) ** 3 -
            0.36400975 * max(log(PSA) - 2.014903, 0) ** 3 +
            0.16080571 * max(log(PSA) - 2.8624846, 0) ** 3 +
            0.022904712 * PSASlope +
            0.54389052 * (FH == "Yes") +
            0.007711361 * Diff -
            0.000015962785 * max(Diff - 3.6666667, 0) ** 3 +
            0.000022881319 * max(Diff - 19.3, 0) ** 3 -
            0.0000069185344 * max(Diff - 55.37, 0) ** 3 +
            0.0023786466 * Months +
            0.000066953466 * max(Months - 3.03, 0) ** 3 -
            0.000090344296 * max(Months - 10.03, 0) ** 3 +
            0.00002339083 * max(Months - 30.066667, 0) ** 3
    } else {
        score = -7.15639 +
            0.064274484 * AgeYr + 
            0.000017180288 * max(AgeYr - 54.780548, 0) ** 3 -
            0.0001777862 * max(AgeYr - 63.290411, 0) ** 3 - 
            0.00014698084 * max(AgeYr - 73.583836, 0) ** 3 -
            0.16034116 * (DRE == 'Yes, < 1/2 lobe') + 
            1.1478035 * (DRE == 'Yes, > 1/2 lobe') +
            0.1093266 * NegCores -
            0.00049772526 * max(NegCores - 8, 0) ** 3 +
            0.00058822076 * max(NegCores - 12, 0) ** 3 -
            0.000090495502 * max(NegCores - 34, 0) ** 3 +
            1.256839 * (PrevPIN == "Yes") +
            0.62802723 * (PrevASAP == "Yes") +
            0.23209391 * log(PSA) +
            0.15368578 * max(log(PSA) - 1.0986123, 0) ** 3 -
            0.29649826 * max(log(PSA) - 1.9315214, 0) ** 3 +
            0.14281248 * max(log(PSA) - 2.8278457, 0) ** 3 -
            0.028290382 * PVol +
            0.014724839 * BMI +
            0.00010423119 * max(BMI - 23.440934, 0) ** 3 -
            0.00016810402 * max(BMI - 27.4502, 0) ** 3 +
            0.000063872826 * max(33.992741, 0) ** 3 +
            0.96077078 * (FH == "Yes") +
            0.018559933 * PSASlope +
            0.006914831 * Diff -
            0.0000053964068 * max(Diff - 6.9266667, 0) ** 3 +
            0.0000080067657 * max(Diff - 27.133333, 0) ** 3 -
            0.0000026103589 * max(Diff - 68.906667, 0) ** 3 -
            0.00084051931 * Months +
            0.000011296533 * max(Months - 5.3566667, 0) ** 3 -
            0.000015837514 * max(Months - 18.35, 0) ** 3 +
            0.0000045409804 * max(Months - 50.673333, 0) ** 3
    }
    1/(1+exp(-score))
})
predict.hgpc <- expression({
    score = -8.763002 +
        0.064274484 * AgeYr -
        0.0001777862 * max(AgeYr - 54.780548, 0) ** 3 +
        0.00032476704 * max(AgeYr - 63.290411, 0) ** 3 - 
        0.00014698084 * max(AgeYr - 73.583836, 0) ** 3 -
        0.16034116 * (DRE == 'Yes, < 1/2 lobe') + 
        1.1478035 * (DRE == 'Yes, > 1/2 lobe') +
        0.1093266 * NegCores -
        0.00049772526 * max(NegCores - 8, 0) ** 3 +
        0.00058822076 * max(NegCores - 12, 0) ** 3 -
        0.000090495502 * max(NegCores - 34, 0) ** 3 +
        1.256839 * (PrevPIN == "Yes") +
        0.62802723 * (PrevASAP == "Yes") +
        0.23209391 * log(PSA) +
        0.15368578 * max(log(PSA) - 1.0986123, 0) ** 3 -
        0.29649826 * max(log(PSA) - 1.9315214, 0) ** 3 +
        0.14281248 * max(log(PSA) - 2.8278457, 0) ** 3 -
        0.028290382 * ifelse(is.na(PVol), 50, PVol) +
        0.014724839 * BMI +
        0.00010423119 * max(BMI - 23.440934, 0) ** 3 -
        0.00016810402 * max(BMI - 27.4502, 0) ** 3 +
        0.000063872826 * max(33.992741, 0) ** 3 +
        0.96077078 * (FH == "Yes") -
        0.018559933 * PSASlope +
        0.006914831 * Diff -
        0.0000053964068 * max(Diff - 6.9266667, 0) ** 3 +
        0.0000080067657 * max(Diff - 27.133333, 0) ** 3 -
        0.0000026103589 * max(Diff - 68.906667, 0) ** 3 -
        0.00084051931 * Months +
        0.000011296533 * max(Months - 5.3566667, 0) ** 3 -
        0.000015837514 * max(Months - 18.35, 0) ** 3 +
        0.0000045409804 * max(Months - 50.673333, 0) ** 3
    1/(1+exp(-score))
})

library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=0, 'Please input a valid AgeYr'))
        AgeYr= as.numeric(input$AgeYr)
        DRE = factor(input$DRE, levels = c('No', 'Yes, < 1/2 lobe', 'Yes, > 1/2 lobe'))
        validate(need(!is.na(as.numeric(input$PSA))& as.numeric(input$PSA)>0& as.numeric(input$PSA)<=100, 'Please input a valid PSA'))
        PSA= as.numeric(input$PSA)
        PrevASAP = factor(input$PrevASAP, levels = c('No', 'Yes'))
        PrevPIN = factor(input$PrevPIN, levels = c('No', 'Yes'))
        FH = factor(input$FH, levels = c('No', 'Yes'))
        validate(need(!is.na(as.numeric(input$Height))& as.numeric(input$Height)>=1& as.numeric(input$Height)<=3, 'Please input a valid Height'))
        Height= as.numeric(input$Height)
        validate(need(!is.na(as.numeric(input$Weight))& as.numeric(input$Weight)>=10& as.numeric(input$Weight)<=300, 'Please input a valid Weight'))
        Weight= as.numeric(input$Weight)
        validate(need(!is.na(as.numeric(input$NegCores))& as.numeric(input$NegCores)>=0, 'Please input a valid NegCores'))
        NegCores= as.numeric(input$NegCores)
        VolumeMissing = factor(input$VolumeMissing, levels = c('No', 'Yes'))
        validate(need(is.na(as.numeric(input$PVol))|(!is.na(as.numeric(input$PVol))& as.numeric(input$PVol)>=0), 'Please input a valid PVol'))
        PVol= ifelse(is.na(as.numeric(input$PVol)), NA, as.numeric(input$PVol))
        validate(need(!is.na(as.numeric(input$PSASlope))& as.numeric(input$PSASlope)>=0, 'Please input a valid PSASlope'))
        PSASlope= as.numeric(input$PSASlope)
        validate(need(!is.na(as.numeric(input$Diff))& as.numeric(input$Diff)>=0, 'Please input a valid Diff'))
        Diff= as.numeric(input$Diff)
        validate(need(!is.na(as.numeric(input$Months))& as.numeric(input$Months)>=0, 'Please input a valid Months'))
        Months= as.numeric(input$Months)
        data <- data.frame(AgeYr = AgeYr,
                           DRE = DRE,
                           PSA = PSA,
                           PrevASAP = PrevASAP,
                           PrevPIN = PrevPIN,
                           FH = FH,
                           BMI = Weight / Height ^ 2,
                           NegCores = NegCores,
                           VolumeMissing = VolumeMissing,
                           PVol = PVol,
                           PSASlope = PSASlope,
                           Diff = Diff,
                           Months = Months)
        data})
    output$result <- renderDataTable({data = data()
    prob.pc <- paste(ifelse(round(eval(predict.pc, data) * 100, 0) < 1, "<1", ifelse(round(eval(predict.pc, data) * 100, 0) > 99, ">99", round(eval(predict.pc, data) * 100, 0))), "%")
    prob.hgpc <- paste(ifelse(round(eval(predict.hgpc, data) * 100, 0) < 1, "<1", ifelse(round(eval(predict.hgpc, data) * 100, 0) > 99, ">99", round(eval(predict.hgpc, data) * 100, 0))), "%")
    res = data.frame(Result = c("Percent Chance of Having High Grade Prostate Cancer (Gleason Score of 7+) (Including Prostate Volume)","Percent Chance of Having Prostate Cancer (Including Prostate Volume)"),
                     Probability = c(prob.hgpc, prob.pc))
    
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
