predict.free <- expression({
    lp <- -3.1830084 - 
        0.00065242845 * AgeYr + 
        0.10166342 * (Gender == "Male") + 
        0.56585476 * (SymptomaticAtDiagnosis == "Local Symptoms") + 
        2 * 0.56585476 * (SymptomaticAtDiagnosis == "Systemic Symptoms") + 
        1.0072686 * (LymphadenopathyByImaging == 'Yes') + 
        0.26592168 * (EvidenceNecrosisByImaging == 'Yes') + 
        0.65408506 * CTSize - 
        0.0086883408 * max(CTSize - 2, 0)**3 + 
        0.013366678 * max(CTSize - 4.8, 0)**3 - 
        0.0046783373 * max(CTSize - 10, 0)**3
    0.8700548 ** exp(lp) * 100
})
predict.aggressive <- expression({
    lp <- -2.3067327 + 
        0.020540099 * AgeYr - 
        0.04426925 * (SymptomaticAtDiagnosis == "Local Symptoms") - 
        0.11588907 * (SmokeHist == 'Yes') + 
        0.091394962 * CTSize - 
        0.11047445 * (Gender == "Female")
    100/(1+exp(-lp))
})
predict.cancerous <- expression({
    lp <- 3.6989875 - 
        0.050309858 * AgeYr - 
        0.0029136151 * (SymptomaticAtDiagnosis == "Local Symptoms") + 
        0.45279501 * (SmokeHist == 'Yes') + 
        0.27515485 * CTSize - 
        4.3405363 * (Gender == "Female") + 
        0.063671549 * AgeYr * (Gender == "Female")
    100/(1+exp(-lp))
})
library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=19& as.numeric(input$AgeYr)<=92, 'Please input a valid AgeYr'))
        AgeYr= as.numeric(input$AgeYr)
        validate(need(!is.na(as.numeric(input$CTSize))& as.numeric(input$CTSize)>=0.5& as.numeric(input$CTSize)<=7, 'Please input a valid CTSize'))
        CTSize= as.numeric(input$CTSize)
        EvidenceNecrosisByImaging = factor(input$EvidenceNecrosisByImaging, levels = c('Yes', 'No'))
        Gender = factor(input$Gender, levels = c('Female', 'Male'))
        SmokeHist = factor(input$SmokeHist, levels = c('Yes', 'No'))
        LymphadenopathyByImaging = factor(input$LymphadenopathyByImaging, levels = c('Yes', 'No'))
        SymptomaticAtDiagnosis = factor(input$SymptomaticAtDiagnosis, levels = c('Local Symptoms', 'Systemic Symptoms', 'No Symptoms'))
        data <- data.frame(AgeYr = AgeYr,
                           CTSize = CTSize,
                           EvidenceNecrosisByImaging = EvidenceNecrosisByImaging,
                           Gender = Gender,
                           SmokeHist = SmokeHist,
                           LymphadenopathyByImaging = LymphadenopathyByImaging,
                           SymptomaticAtDiagnosis = SymptomaticAtDiagnosis)
        data})
    output$result <- renderDataTable({data = data()
    prob.metastasis <- paste(ifelse(round(eval(predict.free, data), 0) < 1, "<1", ifelse(round(eval(predict.free, data), 0) > 99, ">99", round(eval(predict.free, data), 0))), "%")
    prob.aggressive <- paste(ifelse(round(eval(predict.aggressive, data), 0) < 1, "<1", ifelse(round(eval(predict.aggressive, data), 0) > 99, ">99", round(eval(predict.aggressive, data), 0))), "%")
    prob.cancerous <- paste(ifelse(round(eval(predict.cancerous, data), 0) < 1, "<1", ifelse(round(eval(predict.cancerous, data), 0) > 99, ">99", round(eval(predict.cancerous, data), 0))), "%")
    res = data.frame(Result = c("Percent Chance of 12-Year Freedom from Metastasis[2]","Percent Chance of Aggressive Cancer Renal Mass[1]","Percent Chance of Cancerous Renal Mass[1]"),
                     Probability = c(prob.metastasis, prob.aggressive, prob.cancerous))
    
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
