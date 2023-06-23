formula <- expression({
    lp <- -2.1264314 + 
        0.034072352 * (Gender == "Male") + 
        0.0041362795 * AgeYr + 
        7.4691198e-06 * max(AgeYr - 44, 0)**3 - 
        1.6432063e-05 * max(AgeYr - 62, 0)**3 + 
        8.9629437e-06 * max(AgeYr - 77, 0)**3 + 
        1.0188265 * (Stage97 == "pT1") + 
        1.2332424 * (Stage97 == "pT2") + 
        1.8741757 * (Stage97 == "pT3") + 
        2.4566641 * (Stage97 == "pT4") + 
        0.87060903 * (Stage97 == "pTa") + 
        0.55456587 * (Stage97 == "pTis") + 
        0.34940226 * (Histology == "SCC") + 
        0.72706351 * (Histology == "TCC") - 
        0.29095514 * (NodeResult == "Negative") + 
        0.87448703 * (NodeResult == "Positive") - 
        0.0061038768 * DxToRC + 
        2.9994932e-05 * max(DxToRC - 0.45996875, 0)**3 - 
        3.3813355e-05 * max(DxToRC - 3.5483304, 0)**3 + 
        3.8184231e-06 * max(DxToRC - 27.808397, 0)**3 - 
        0.17941245 * (Grade == "High") - 
        0.69780658 * (Grade == "Low")
    100 * 0.7524126 ** exp(lp)
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        Gender = factor(input$Gender, levels = c('Female', 'Male'))
validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=20& as.numeric(input$AgeYr)<=100, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
Stage97 = factor(input$Stage97, levels = c('pT0', 'pTa', 'pTis', 'pT1', 'pT2', 'pT3', 'pT4'))
Histology = factor(input$Histology, levels = c('TCC', 'SCC', 'ADENOCARCINOMA'))
Grade = factor(input$Grade, levels = c('High', 'Low', 'GX'))
NodeResult = factor(input$NodeResult, levels = c('Negative', 'Positive', 'NX'))
validate(need(!is.na(as.numeric(input$DxToRC)), 'Please input a valid DxToRC'))
DxToRC= as.numeric(input$DxToRC)
data <- data.frame(Gender = Gender,
AgeYr = AgeYr,
Stage97 = Stage97,
Histology = Histology,
Grade = Grade,
NodeResult = NodeResult,
DxToRC = DxToRC)
data})
output$result <- renderDataTable({data = data()
prob = eval(formula, data)
res = data.frame(Result = c("Percentage of 5-Year Recurrence-Free Survival"),
                 Probability = c(paste(ifelse(round(prob, 0) < 1, "<1", ifelse(round(prob, 0) > 99, ">99", round(prob, 0))), "%")))
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
        