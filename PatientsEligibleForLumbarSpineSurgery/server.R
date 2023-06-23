predict.er <- expression({
    lp <- -2.2433713 + 0.56707813 * (Race == "Non-Caucasian") - 0.4230753 * 
        (Married == "Yes") - 0.027747764 * Symptom.Duration + 
        2.0333835e-05 * max(Symptom.Duration - 2, 0)**3 - 2.5175225e-05 * 
        max(Symptom.Duration - 12, 0)**3 + 4.8413894e-06 * max(Symptom.Duration - 
                                                                         54, 0)**3 + 0.32735468 * (Foraminal.Stenosis == "Yes") + 
        0.25145306 * (Herniation == "Yes") + 0.25163291 * (Spondylosis == 
                                                                     "Yes") + 0.38238998 * (Radiculopathy == "Yes") - 0.36063581 * 
        (ALIF == "Yes") - 0.63397625 * (PLIF.TLIF == "Yes") - 
        0.53949688 * (Posterolateral == "Yes") - 0.65573781 * 
        (Decompression == "Yes") + 0.33983028 * Levels - 0.042301668 * 
        max(Levels - 1, 0)**3 + 0.084603337 * max(Levels - 2, 
                                                        0)**3 - 0.042301668 * max(Levels - 3, 0)**3
    
    1/(1+exp(-lp))
})

predict.readmission <- expression({
    lp <- -0.35422101 - 0.06852317 * BMI + 0.00050777627 * max(BMI - 
                                                                         22.73, 0)**3 - 0.00085572981 * max(BMI - 28.63, 0)**3 + 
        0.00034795354 * max(BMI - 37.24, 0)**3 - 0.12503829 * 
        CCI + 0.019112228 * max(CCI - 1, 0)**3 - 0.038224455 * 
        max(CCI - 3, 0)**3 + 0.019112228 * max(CCI - 5, 0)**3 + 
        0.48963073 * (Herniation == "Yes") - 0.90295338 * (Decompression == 
                                                                     "Yes") + 0.59875195 * Levels - 0.10257754 * max(Levels - 
                                                                                                                               1, 0)**3 + 0.20515509 * max(Levels - 2, 0)**3 - 0.10257754 * 
        max(Levels - 3, 0)**3
    1/(1+exp(-lp))
})

predict.infection <- expression({
    lp <- -5.9758214 + 0.10583286 * Age - 2.4842256e-05 * max(Age - 
                                                                        36.45, 0)**3 + 6.1150168e-05 * max(Age - 60.2, 0)**3 - 
        3.6307913e-05 * max(Age - 76.45, 0)**3 - 0.068346555 * 
        BMI + 0.00066939604 * max(BMI - 22.73, 0)**3 - 0.0011280995 * 
        max(BMI - 28.63, 0)**3 + 0.00045870344 * max(BMI - 37.24, 
                                                           0)**3 - 1.2947364 * CCI + 0.058331688 * max(CCI - 1, 
                                                                                                             0)**3 - 0.11666338 * max(CCI - 3, 0)**3 + 0.058331688 * 
        max(CCI - 5, 0)**3 - 0.50728928 * (Spinal.Stenosis == 
                                                     "Yes") - 0.80137706 * (ALIF == "Yes") + 0.91975157 * 
        (Posterolateral == "Yes") + 0.71832438 * Levels - 0.095823923 * 
        max(Levels - 1, 0)**3 + 0.19164785 * max(Levels - 2, 
                                                       0)**3 - 0.095823923 * max(Levels - 3, 0)**3
    1/(1+exp(-lp))
})

predict.eq5d <- expression({
    lp <- 4.720869 - 1.0464668 * (Race == "Non-Caucasian") + 0.11226242 * 
        (Foraminal.Stenosis == "Yes") + 0.34587835 * (Herniation == 
                                                                "Yes") + 0.95399099 * (Spondylosis == "Yes") - 0.59570489 * 
        (Radiculopathy == "Yes") - 7.3166571 * BaseEQ5D - 7.2154241 * 
        max(BaseEQ5D - 0.263, 0)**3 + 11.192601 * max(BaseEQ5D - 
                                                          0.446, 0)**3 - 3.9771765 * max(BaseEQ5D - 0.778, 0)**3 - 
        0.0022018504 * BasePDQ - 4.653024e-06 * max(BasePDQ - 
                                                              46, 0)**3 + 9.8230507e-06 * max(BasePDQ - 86, 0)**3 - 
        5.1700267e-06 * max(BasePDQ - 122, 0)**3
    1/(1+exp(-lp))
})

library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$Age))& as.numeric(input$Age)>=10 & as.numeric(input$Age)<=99, 'Please input a valid Age'))
        validate(need(!is.na(as.numeric(input$BMI))& as.numeric(input$BMI)>=15& as.numeric(input$BMI)<=70, 'Please input a valid BMI'))
        validate(need(!is.na(as.numeric(input$CCI))& as.numeric(input$CCI)>=0& as.numeric(input$CCI)<=30, 'Please input a valid CCI'))
        validate(need(!is.na(as.numeric(input$Symptom.Duration))& as.numeric(input$Symptom.Duration)>=0& as.numeric(input$Symptom.Duration)<=365, 'Please input a valid Symptom.Duration'))
        validate(need(!is.na(as.numeric(input$Levels))& as.numeric(input$Levels)>=1& as.numeric(input$Levels)<=14, 'Please input a valid Levels'))
        validate(need(is.na(as.numeric(input$BaseEQ5D))|(!is.na(as.numeric(input$BaseEQ5D))& as.numeric(input$BaseEQ5D)>=-0.1& as.numeric(input$BaseEQ5D)<=1), 'Please input a valid Preoperative EQ5D'))
        validate(need(is.na(as.numeric(input$BasePDQ))|(!is.na(as.numeric(input$BasePDQ))& as.numeric(input$BasePDQ)>=0& as.numeric(input$BasePDQ)<=150), 'Please input a valid Preoperative PDQ'))
        
        Age= as.numeric(input$Age)
        BMI = as.numeric(input$BMI)
        CCI = as.numeric(input$CCI)
        Symptom.Duration = as.numeric(input$Symptom.Duration)
        Race = as.character(factor(input$Race, levels = c('Caucasian', 'Non-Caucasian')))
        Married = as.character(factor(input$Married, levels = c('No', 'Yes')))
        Foraminal.Stenosis = as.character(factor(input$Foraminal.Stenosis, levels = c('No', 'Yes')))
        Spinal.Stenosis = as.character(factor(input$Spinal.Stenosis, levels = c('No', 'Yes')))
        Herniation = as.character(factor(input$Herniation, levels = c('No', 'Yes')))
        Spondylosis = as.character(factor(input$Spondylosis, levels = c('No', 'Yes')))
        Radiculopathy = as.character(factor(input$Radiculopathy, levels = c('No', 'Yes')))
        ALIF = as.character(factor(input$ALIF, levels = c('No', 'Yes')))
        PLIF.TLIF = as.character(factor(input$PLIF.TLIF, levels = c('No', 'Yes')))
        Posterolateral = as.character(factor(input$Posterolateral, levels = c('No', 'Yes')))
        Decompression = as.character(factor(input$Decompression, levels = c('No', 'Yes')))
        Levels= as.numeric(input$Levels)
        BaseEQ5D= as.numeric(input$BaseEQ5D)
        BasePDQ= as.numeric(input$BasePDQ)

        data <- data.frame(Age = Age,
                           Race = Race,
                           Married = Married,
                           BMI = BMI,
                           CCI = CCI,
                           Symptom.Duration = Symptom.Duration,
                           Foraminal.Stenosis = Foraminal.Stenosis,
                           Spinal.Stenosis = Spinal.Stenosis,
                           Herniation = Herniation,
                           Spondylosis = Spondylosis,
                           Radiculopathy = Radiculopathy,
                           ALIF = ALIF,
                           PLIF.TLIF = PLIF.TLIF,
                           Posterolateral = Posterolateral,
                           Decompression = Decompression,
                           Levels = Levels,
                           BaseEQ5D = BaseEQ5D,
                           BasePDQ = BasePDQ)
       
        data})
    
    
    output$result <- DT::renderDataTable({
        data = data()
        prob.er <- round(eval(predict.er, data) * 100, 1)
        prob.er <- paste(ifelse(prob.er < 0.1, "<0.1", ifelse(prob.er > 99.9, ">99.9", prob.er)), "%")
        prob.readmission <- round(eval(predict.readmission, data) * 100, 1)
        prob.readmission <- paste(ifelse(prob.readmission < 0.1, "<0.1", ifelse(prob.readmission > 99.9, ">99.9", prob.readmission)), "%")
        prob.infection <- round(eval(predict.infection, data) * 100, 1)
        prob.infection <- paste(ifelse(prob.infection < 0.1, "<0.1", ifelse(prob.infection > 99.9, ">99.9", prob.infection)), "%")
        if (is.na(data$BaseEQ5D) | is.na(data$BasePDQ)) {
          res = data.frame(Result = c("Predicted Probability of Emergency Department Visit within 30 Days",
                                      "Predicted Probability of Readmission within 30 Days",
                                      "Predicted Probability of Reoperation for Infection within 90 Days"),
                           Probability = c(prob.er, prob.readmission, prob.infection))
        } else {
          prob.eq5d <- round(eval(predict.eq5d, data) * 100, 1)
          prob.eq5d <- paste(ifelse(prob.eq5d < 0.1, "<0.1", ifelse(prob.eq5d > 99.9, ">99.9", prob.eq5d)), "%")
          res = data.frame(Result = c("Predicted Probability of Emergency Department Visit within 30 Days",
                                      "Predicted Probability of Readmission within 30 Days",
                                      "Predicted Probability of Reoperation for Infection within 90 Days",
                                      "Predicted Probability of 1 Year Improvement in EQ-5D Greater than 0.1"),
                           Probability = c(prob.er, prob.readmission, prob.infection, prob.eq5d))
        }
        
        
        res}, options = list(
            pageLength = 10,
            lengthMenu = 0,
            
            searching = 0,
            info = 0,
            paging = 0,
            processing = 0,
            initComplete = I(
                "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
})
