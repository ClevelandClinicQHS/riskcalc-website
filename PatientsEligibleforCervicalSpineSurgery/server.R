predict.er <- expression({
    lp <- -4.1935525 - 0.079445857 * Age + 0.00012663761 * max(Age - 
                                                                   38, 0)**3 - 0.00024483271 * max(Age - 52, 0)**3 + 0.0001181951 * 
        max(Age - 67, 0)**3 - 1.4992937 * (Race == "Non-Black") + 
        0.10207611 * BMI - 0.00026873778 * max(BMI - 22.2, 0)**3 + 
        0.00045716312 * max(BMI - 28.3, 0)**3 - 0.00018842534 * 
        max(BMI - 37, 0)**3 - 0.86110289 * (Smoking == "never") + 
        4.8556835e-05 * MedianIncome - 2.2942575e-14 * max(MedianIncome - 
                                                               35189, 0)**3 + 3.3969467e-14 * max(MedianIncome - 49407, 
                                                                                                  0)**3 - 1.1026892e-14 * max(MedianIncome - 78989, 0)**3 + 
        1.5492212 * (Surgery == "PCF") - 0.30460784 * (Surgery == 
                                                          "Post Decomp") - 0.6394636 * (spondylosis == "Yes") + 
        0.81299638 * (TerminalLevel == "Yes")
    
    1/(1+exp(-lp))
})

predict.readmission <- expression({
    lp <- -1.6143402 - 0.062487118 * Age + 9.7725238e-05 * max(Age - 
                                                                   38, 0)**3 - 0.00018893546 * max(Age - 52, 0)**3 + 9.1210222e-05 * 
        max(Age - 67, 0)**3 - 1.5194717 * (Race == "Non-Black") + 
        0.090141054 * BMI - 7.6574035e-05 * max(BMI - 22.2, 
                                                0)**3 + 0.00013026387 * max(BMI - 28.3, 0)**3 - 5.368984e-05 * 
        max(BMI - 37, 0)**3 - 0.41276205 * (UENumbness == "Yes") + 
        1.4292945 * (Surgery == "PCF") + 0.93032484 * (Surgery == 
                                                          "Post Decomp") - 1.3518555 * (herniation == "Yes") + 
        0.44439097 * (myelopathy == "Yes") + 0.01713277 * Levels + 
        0.075713544 * max(Levels - 3, 0)**3 - 0.15142709 * max(Levels - 
                                                                   4, 0)**3 + 0.075713544 * max(Levels - 5, 0)**3 + 0.32664713 * 
        (DM == "Yes");
    
    1/(1+exp(-lp))
})

predict.infection <- expression({
    lp <- -8.8017589 + 0.1132821 * BMI + 0.00023766098 * max(BMI - 
                                                                 22.2, 0)**3 - 0.00040429684 * max(BMI - 28.3, 0)**3 + 
        0.00016663586 * max(BMI - 37, 0)**3 - 1.2712064 * (NeckPain == 
                                                               "Yes") - 1.2896334 * (UENumbness == "Yes") + 1.8524487 * 
        (UEWeakness == "Yes") + 2.4303965 * (Surgery == "PCF") + 
        2.6020474 * (Surgery == "Post Decomp") - 2.3143696 * 
        (herniation == "Yes") + 1.8107038 * (DM == "Yes");
    
    1/(1+exp(-lp))
})

predict.eq5d <- expression({
    0.61452579 + 
        0.055871956 * (herniation == "Yes") - 
        0.032047505 * (myelopathy == "Yes") - 
        0.070951516 * (Surgery == "PCF") + 
        0.041851946 * (Surgery == "Post Decomp") + 
        0.054898788 * (DM == "Yes") - 
        1.1070162 * BaseEQ5D + 
        0.99958313 * max(BaseEQ5D - 0.211, 0)**3 - 
        2.7178237 * max(BaseEQ5D - 0.6, 0)**3 + 
        1.7182406 * max(BaseEQ5D - 0.8263, 0)**3 + 
        0.0018650679 * BasePDQ - 
        2.6379538e-07 * max(BasePDQ - 5, 0)**3 + 
        7.3347984e-07 * max(BasePDQ - 78, 0)**3 - 
        4.6968446e-07 * max(BasePDQ - 119, 0)**3
})

predict.phq9 <- expression({
    8.8042137 - 0.082186378 * Age - 1.4942097 * (herniation == 
                                                     "Yes") + 1.9822603 * (Surgery == "PCF") + 0.13512278 * 
        (Surgery == "Post Decomp") - 1.8689147 * (DM == "Yes") - 
        0.63974387 * BasePHQ9
    
})

predict.pdq <- expression({
    39.4437 + 
        0.48691281 * BMI - 
        6.317508 * (Smoking == "never") - 
        6.2809001 * (spondylosis == "Yes") + 
        11.620923 * (Surgery == "PCF") + 
        5.4156593 * (Surgery == "Post Decomp") - 
        19.536014 * BaseEQ5D - 
        1.3265977 * BasePDQ + 
        5.7029125e-05 * max(BasePDQ - 5, 0)**3 - 
        0.00015856879 * max(BasePDQ - 78, 0)**3 + 
        0.00010153966 * max(BasePDQ - 119, 0)**3
})

load("data.RData")
library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$Age))& as.numeric(input$Age)>=10 & as.numeric(input$Age)<=99, 'Please input a valid Age'))
        Age= as.numeric(input$Age)
        Race = factor(input$Race, levels = c('Non-Black', 'Black'))
        validate(need(!is.na(as.numeric(input$BMI))& as.numeric(input$BMI)>=15& as.numeric(input$BMI)<=70, 'Please input a valid BMI'))
        BMI = as.numeric(input$BMI)
        ZIP = input$ZIP
        validate(need(input$ZIP %in% MedianZIP$Zip, 'Please input a valid ZIP'))
        MedianIncome = MedianZIP[which(MedianZIP$Zip==input$ZIP), ]$Median
        Smoking = factor(input$Smoking, levels = c('Never', 'Former/Current'))
        NeckPain = factor(input$NeckPain, levels = c('No', 'Yes'))
        UENumbness = factor(input$UENumbness, levels = c('No', 'Yes'))
        UEWeakness = factor(input$UEWeakness, levels = c('No', 'Yes'))
        herniation = factor(input$herniation, levels = c('No', 'Yes'))
        myelopathy = factor(input$myelopathy, levels = c('No', 'Yes'))
        spondylosis = factor(input$spondylosis, levels = c('No', 'Yes'))
        Surgery = factor(input$Surgery, levels = c('ACF', 'PCF', "Post Decomp"))
        validate(need(!is.na(as.numeric(input$Levels))& as.numeric(input$Levels)>=2& as.numeric(input$Levels)<=6, 'Please input a valid Levels'))
        Levels= as.numeric(input$Levels)
        TerminalLevel = factor(input$TerminalLevel, levels = c('No', 'Yes'))
        DM = factor(input$DM, levels = c('No', 'Yes'))
        Cancer = factor(input$Cancer, levels = c('No', 'Yes'))
        validate(need(!is.na(as.numeric(input$BaseEQ5D))& as.numeric(input$BaseEQ5D)>=-0.1& as.numeric(input$BaseEQ5D)<=1, 'Please input a valid Preoperative EQ5D'))
        BaseEQ5D= as.numeric(input$BaseEQ5D)
        validate(need(!is.na(as.numeric(input$BasePHQ9))& as.numeric(input$BasePHQ9)>=0& as.numeric(input$BasePHQ9)<=27, 'Please input a valid Preoperative PHQ9'))
        BasePHQ9= as.numeric(input$BasePHQ9)
        validate(need(!is.na(as.numeric(input$BasePDQ))& as.numeric(input$BasePDQ)>=0& as.numeric(input$BasePDQ)<=150, 'Please input a valid Preoperative PDQ'))
        BasePDQ= as.numeric(input$BasePDQ)

        data <- data.frame(Age = Age,
                           Race = Race,
                           BMI = BMI,
                           MedianIncome = MedianIncome,
                           Smoking = Smoking,
                           NeckPain = NeckPain,
                           UENumbness = UENumbness,
                           UEWeakness = UEWeakness,
                           herniation = herniation,
                           myelopathy = myelopathy,
                           spondylosis = spondylosis,
                           Surgery = Surgery,
                           Levels = Levels,
                           TerminalLevel = TerminalLevel,
                           DM = DM,
                           Cancer = Cancer,
                           BaseEQ5D = BaseEQ5D,
                           BasePHQ9 = BasePHQ9,
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
        eq5d <- round(eval(predict.eq5d, data), 2)
        phq9 <- round(eval(predict.phq9, data), 2)
        pdq <- round(eval(predict.pdq, data), 2)
        res = data.frame(Result = c("Predicted Probability of Emergency Department Visit within 30 Days",
                                    "Predicted Probability of Readmission within 30 Days",
                                    "Predicted Probability of Reoperation for Infection within 90 Days",
                                    "Predicted Change in EQ-5D",
                                    "Predicted Change in PHQ-9",
                                    "Predicted Change in PDQ"),
                         Probability = c(prob.er, prob.readmission, prob.infection, eq5d, phq9, pdq))
        
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
