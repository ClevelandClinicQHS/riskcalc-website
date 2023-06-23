predict.PC.formula <- expression({lp <- ifelse(TotalVolumeMissing != "Yes", 
                                               -1.329203 +
                                                   0.014881529 * AgeYr + 
                                                   0.082519904 * (Race == "Caucasian") - 
                                                   0.67753357 * (Race == "Asian")- 
                                                   0.67753357 * (Race == "Other") +
                                                   1.0571667 * (DRE == "Abnormal") + 
                                                   0.38957908 * log(PSA) - 
                                                   0.029962743 * FPSA/100 +
                                                   7.505949e-005 * max(FPSA/100 - 9, 0)**3 - 
                                                   0.00012509915 * max(FPSA/100 - 17, 0)**3 +
                                                   5.003966e-005 * max(FPSA/100 - 29, 0)**3 + 
                                                   0.0037739821 * Cores -  
                                                   0.0041258674 * TotalVolume
                                               ,
                                               -2.49415819 +
                                                   0.043789882 * AgeYr + 
                                                   0.061112486 * (Race == "Asian") + 
                                                   0.47345107 *(Race == "Caucasian") + 
                                                   0.5661818 * (Race == "African American") + 
                                                   0.32726706 * (Family_hx == "Yes") - 
                                                   0.01271263 * IPSS + 
                                                   0.08978343 * PSA - 
                                                   0.00065843093 * max(PSA - 3.247, 0)**3 + 
                                                   0.00093263103 * max(PSA - 7, 0)**3 - 
                                                   0.0002742001 * max(PSA - 16.012, 0)**3 - 
                                                   13.983077 * FPSA/100 + 
                                                   223.08428 * max(FPSA/100 - 0.065867907, 0)**3 - 
                                                   355.52144 * max(FPSA/100 - 0.14936053, 0)**3 + 
                                                   132.43716 * max(FPSA/100 - 0.29, 0)**3 + 
                                                   0.87485684 * (DRE == "Abnormal")
)
;
1/(1+exp(-lp))})

predict.HGPC.formula <- expression({lp <- ifelse(TotalVolumeMissing != "Yes", 
                                                 -2.011632  +  
                                                     0.014881529 * AgeYr + 
                                                     0.082519904 * (Race == "Caucasian") - 
                                                     0.67753357 * (Race == "Other") - 
                                                     0.67753357 * (Race == "Asian")+
                                                     1.0571667 * (DRE == "Abnormal") + 
                                                     0.38957908 * log(PSA) - 
                                                     0.029962743 * FPSA/100 +
                                                     7.505949e-005 * max(FPSA/100 - 9, 0)**3 - 
                                                     0.00012509915 * max(FPSA/100 - 17, 0)**3 +
                                                     5.003966e-005 * max(FPSA/100 - 29, 0)**3 + 
                                                     0.0037739821 * Cores -  
                                                     0.0041258674 * TotalVolume
                                                 ,
                                                 -3.44097206 +
                                                     0.043789882 * AgeYr + 
                                                     0.061112486 * (Race == "Asian") + 
                                                     0.47345107 * (Race == "Caucasian") + 
                                                     0.56618181 *(Race == "African American")  + 
                                                     0.32726706 * (Family_hx == "Yes")  - 
                                                     0.01271263 * IPSS + 
                                                     0.08978343 * PSA - 
                                                     0.00065843093 * max(PSA - 3.247, 0)**3 + 
                                                     0.00093263103 * max(PSA - 7, 0)**3 - 
                                                     0.0002742001 * max(PSA - 16.012, 0)**3 - 
                                                     13.983077 * FPSA/100 + 
                                                     223.08428 * max(FPSA/100 - 0.065867907, 0)**3 - 
                                                     355.52144 * max(FPSA/100 - 0.14936053, 0)**3 + 
                                                     132.43716 * max(FPSA/100 - 0.29, 0)**3 + 
                                                     0.87485684 * (DRE == "Abnormal")
)
;
1/(1+exp(-lp))})

library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        DRE = factor(input$DRE, levels = c('Normal', 'Abnormal'))
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=0, 'Please input a valid AgeYr'))
        AgeYr= as.numeric(input$AgeYr)
        validate(need(!is.na(as.numeric(input$Cores))& as.numeric(input$Cores)>=0, 'Please input a valid Cores'))
        Cores= as.numeric(input$Cores)
        Family_hx = factor(input$Family_hx, levels = c('No', 'Yes'))
        validate(need(!is.na(as.numeric(input$FPSA))& as.numeric(input$FPSA)>=0& as.numeric(input$FPSA)<=100, 'Please input a valid FPSA'))
        FPSA= as.numeric(input$FPSA)
        validate(need(!is.na(as.numeric(input$PSA))& as.numeric(input$PSA)>=0.2& as.numeric(input$PSA)<=123, 'Please input a valid PSA'))
        PSA= as.numeric(input$PSA)
        Race = factor(input$Race, levels = c('Caucasian', 'African American', 'Asian', 'Other'))
        validate(need(!is.na(as.numeric(input$IPSS))& as.numeric(input$IPSS)>=0& as.numeric(input$IPSS)<=36, 'Please input a valid IPSS'))
        IPSS= as.numeric(input$IPSS)
        TotalVolumeMissing = factor(input$TotalVolumeMissing, levels = c('No', 'Yes'))
        if (TotalVolumeMissing == "No") {
          validate(need(!is.na(as.numeric(input$TotalVolume))& as.numeric(input$TotalVolume)>=0, 'Please input a valid TotalVolume'))
          TotalVolume= as.numeric(input$TotalVolume)
        } else {
          TotalVolume = 0
        }
                
        data <- data.frame(DRE = DRE,
                           AgeYr = AgeYr,
                           Cores = Cores,
                           Family_hx = Family_hx,
                           FPSA = FPSA,
                           PSA = PSA,
                           Race = Race,
                           IPSS = IPSS,
                           TotalVolumeMissing = TotalVolumeMissing,
                           TotalVolume = TotalVolume)
        data})
    output$result <- renderDataTable({data = data()
    prob.hgpc <- paste(ifelse(round(eval(predict.HGPC.formula, data)*100, 1) < 1, "<1", ifelse(round(eval(predict.HGPC.formula, data)*100, 1) > 99, ">99", round(eval(predict.HGPC.formula, data)*100, 0))), "%")
    prob.pc <- paste(ifelse(round(eval(predict.PC.formula, data)*100, 1) < 1, "<1", ifelse(round(eval(predict.PC.formula, data)*100, 1) > 99, ">99", round(eval(predict.PC.formula, data)*100, 0))), "%")
    res = data.frame(Result = c("Prostate Cancer Predict Percent Chance of Having High Grade Prostate Cancer (Gleason Score of 7)","Percent Chance of Having Prostate Cancer"),
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
