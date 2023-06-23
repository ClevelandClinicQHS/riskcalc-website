formula.5yr <- expression({
    lp <- -1.4593168 + 
        0.005103099 * AgeYr + 
        0.066405299 * (Gender == "Male") -
        0.016328607 * (Location == "Rectosigmoid") + 
        0.052927499 *(Location == "Right") + 
        0.10461893 * (Location == "Sigmoid") +  
        0.37980253 * (Location == "Transverse") + 
        0.070577716 *CEA - 
        0.00060340647 * max(CEA - 1.2, 0)**3 + 
        0.00067213982 *max(CEA - 3.1, 0)**3 - 
        0.000068733351 * max(CEA - 19.78,0)**3 + 
        0.048783782 * (Differentiation == "Poor/Undiff") -         
        0.73733461 * (Differentiation == "Well") - 
        0.022493911 *         NegativeNodes + 
        0.41867287 * (LVI == "Yes") + 
        0.45769526 *         (PNI == "Yes") + 
        0.55160313 * (TStage == "2") + 
        1.0538036 *(TStage == "3") + 
        1.4717941 * (TStage == "4") - 
        0.19140398 *(PostOpChemo == "Yes") + 
        0.50837307 * sqrt(PositiveNodes + 0.001) +         
        (PostOpChemo == "Yes") * (0.29237398 * (TStage == "2") +
        0.46677547 * (TStage == "3") - 
        0.14022148 * (TStage == "4")) - 
        0.19318134 * (PostOpChemo == "Yes") * sqrt(PositiveNodes + 0.001)
    100 * 0.8516949 ** exp(lp)
})
formula.10yr <- expression({
    lp <- -1.4593168 + 
        0.005103099 * AgeYr + 
        0.066405299 * (Gender == "Male") - 
        0.016328607 * (Location == "Rectosigmoid") + 
        0.052927499 * (Location == "Right") + 
        0.10461893 * (Location == "Sigmoid") + 
        0.37980253 * (Location == "Transverse") + 
        0.070577716 * CEA - 
        0.00060340647 * max(CEA - 1.2, 0)**3 + 
        0.00067213982 * max(CEA - 3.1, 0)**3 - 
        0.000068733351 * max(CEA - 19.78,0)**3 + 
        0.048783782 * (Differentiation == "Poor/Undiff") - 
        0.73733461 * (Differentiation == "Well") - 
        0.022493911 *NegativeNodes + 
        0.41867287 * (LVI == "Yes") + 
        0.45769526 *(PNI == "Yes") + 
        0.55160313 * (TStage == "2") + 
        1.0538036 *(TStage == "3") + 
        1.4717941 * (TStage == "4") - 
        0.19140398 * (PostOpChemo == "Yes") + 
        0.50837307 * sqrt(PositiveNodes + 0.001) + 
        (PostOpChemo == "Yes") * (0.29237398 * (TStage == "2") +
        0.46677547 * (TStage == "3") - 
        0.14022148 * (TStage == "4")) - 
        0.19318134 * (PostOpChemo == "Yes") * sqrt(PositiveNodes + 0.001)
    100 * 0.8008246 ** exp(lp)
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=23& as.numeric(input$AgeYr)<=93, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
Gender = factor(input$Gender, levels = c('Male', 'Female'))
Location = factor(input$Location, levels = c('Rectosigmoid', 'Right', 'Sigmoid', 'Transverse', 'Left'))
validate(need(!is.na(as.numeric(input$CEA))& as.numeric(input$CEA)>=0.2& as.numeric(input$CEA)<=798, 'Please input a valid CEA'))
CEA= as.numeric(input$CEA)
Differentiation = factor(input$Differentiation, levels = c('Poor/Undiff', 'Moderate', 'Well'))
LVI = factor(input$LVI, levels = c('No', 'Yes'))
PNI = factor(input$PNI, levels = c('No', 'Yes'))
TStage = factor(input$TStage, levels = c('1', '2', '3', '4'))
validate(need(!is.na(as.numeric(input$PositiveNodes))& as.numeric(input$PositiveNodes)>=0& as.numeric(input$PositiveNodes)<=23, 'Please input a valid PositiveNodes'))
PositiveNodes= as.numeric(input$PositiveNodes)
validate(need(!is.na(as.numeric(input$NegativeNodes))& as.numeric(input$NegativeNodes)>=0& as.numeric(input$NegativeNodes)<=146, 'Please input a valid NegativeNodes'))
NegativeNodes= as.numeric(input$NegativeNodes)
PostOpChemo = factor(input$PostOpChemo, levels = c('No', 'Yes'))
data <- data.frame(AgeYr = AgeYr,
Gender = Gender,
Location = Location,
CEA = CEA,
Differentiation = Differentiation,
LVI = LVI,
PNI = PNI,
TStage = TStage,
PositiveNodes = PositiveNodes,
NegativeNodes = NegativeNodes,
PostOpChemo = PostOpChemo)
data})
output$result <- renderDataTable({data = data()
prob1 <- eval(formula.5yr, data)
prob2 <- eval(formula.10yr, data)
res = data.frame(Result = c("5-Year Recurrence-Free Survival Percentage", "10-Year Recurrence-Free Survival Percentage"),
                 Probability = c(paste(ifelse(round(prob1, 0) < 1, "<1", ifelse(round(prob1, 0) > 99, ">99", round(prob1, 0))), "%"), paste(ifelse(round(prob2, 0) < 1, "<1", ifelse(round(prob2, 0) > 99, ">99", round(prob2, 0))), "%")))

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
        