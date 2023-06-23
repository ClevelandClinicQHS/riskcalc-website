predict.prob <- expression({
    lp <- 3.4379047 - 
        0.0033013351 * AgeYr + 
        0.000019282785 * max(AgeYr - 42.398, 0)**3 - 
        0.000051212975 * max(AgeYr - 67.19, 0)**3 + 
        0.00003193019 * max(AgeYr - 82.162, 0)**3 - 
        0.1588519 * BMI + 
        0.00080837864 * max(BMI - 21, 0)**3 - 
        0.0013472977 * max(BMI - 27, 0)**3 + 
        0.00053891909 * max(BMI - 36, 0)**3 - 
        0.36147776 * Hemoglobin - 
        0.00030765748 * max(Hemoglobin - 9.4, 0)**3 + 
        0.00072607165 * max(Hemoglobin - 12.8, 0)**3 - 
        0.00041841417 * max(Hemoglobin - 15.3, 0)**3 + 
        1.7299587 * (ESRD == "Yes") - 
        0.015235664 * EF + 
        0.59159242 * (NYHA == "III or IV") + 
        0.91137649 * (Lead == "Yes") - 
        0.0027597965 * PriorProcedure + 
        0.000000003694394 * max(PriorProcedure - 71, 0)**3 - 
        0.0000000042436543 * max(PriorProcedure - 293, 0)**3 + 
        0.00000000054926029 * max(PriorProcedure - 1786.2, 0)**3 + 
        1.0220745 * (DCICD == "Yes")
    100 / (1 + exp(-lp))
})
library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=20& as.numeric(input$AgeYr)<=90, 'Please input a valid AgeYr'))
        AgeYr= as.numeric(input$AgeYr)
        validate(need(!is.na(as.numeric(input$BMI))& as.numeric(input$BMI)>=15& as.numeric(input$BMI)<=50, 'Please input a valid BMI'))
        BMI= as.numeric(input$BMI)
        validate(need(!is.na(as.numeric(input$Hemoglobin))& as.numeric(input$Hemoglobin)>=1& as.numeric(input$Hemoglobin)<=16, 'Please input a valid Hemoglobin'))
        Hemoglobin= as.numeric(input$Hemoglobin)
        validate(need(!is.na(as.numeric(input$EF))& as.numeric(input$EF)>=10& as.numeric(input$EF)<=70, 'Please input a valid Ejection Fraction'))
        EF= as.numeric(input$EF)
        validate(need(!is.na(as.numeric(input$PriorProcedure))& as.numeric(input$PriorProcedure)>=0& as.numeric(input$PriorProcedure)<=1000, 'Please input a valid PriorProcedure'))
        PriorProcedure= as.numeric(input$PriorProcedure)
        ESRD = factor(input$ESRD, levels = c('No', "Yes"))
        NYHA = factor(input$NYHA, levels = c('I or II', "III or IV"))
        Lead = factor(input$Lead, levels = c('No', "Yes"))
        DCICD = factor(input$DCICD, levels = c('No', "Yes"))
        data <- data.frame(AgeYr = AgeYr,
                           BMI = BMI,
                           Hemoglobin = Hemoglobin,
                           EF = EF,
                           PriorProcedure = PriorProcedure,
                           ESRD = ESRD,
                           NYHA = NYHA,
                           Lead = Lead,
                           DCICD = DCICD)
        data})
    output$result <- renderDataTable({data = data()
    prob <- paste(ifelse(round(eval(predict.prob, data), 0) < 1, "<1", ifelse(round(eval(predict.prob, data), 0) > 99, ">99", round(eval(predict.prob, data), 0))), "%")
    res = data.frame(Result = c("Predicted Probability of 30-Day All-Causes Mortality"),
                     Probability = c(prob))
    
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