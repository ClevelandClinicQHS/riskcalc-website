predict.prob <- expression({
    lp <- -2.5604597 + 
        0.082241127 * AgeYr + 
        0.0000087800091 * max(AgeYr - 39, 0)**3 - 
        0.000015494134 * max(AgeYr - 52, 0)**3 + 
        0.0000067141246  * max(AgeYr - 69, 0)**3 + 
        0.60202653 * (Gender == "Yes") + 
        0.1801972 * (TypAngina  ==  "Yes") + 
        0.27240049 * (Diabetes == "Yes - Oral agents only") +  
        0.61430074 * (Diabetes== "Yes - Treatment includes Insulin") + 
        0.6304089 * (SMKNow == "Yes") - 
        0.01563817 * (Hypertension == "Yes") - 
        2.4888205 * PctPredMet +  
        2.0707735 * max(PctPredMet - 0.70348432, 0)**3 - 
        4.1135493 * max(PctPredMet - 1.0331374, 0)**3 + 
        2.0427758 *  max(PctPredMet - 1.3673086, 0)**3 + 
        0.042006575 * STChange*(STChange >= 1) - 
        0.25819009 * (TestAngina == "Yes") +  
        0.37711652 * (LowRec == "Yes") + 
        0.20714374 * (FreqVeaRec == "Yes")
    exp(lp)
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        LowRec = factor(input$LowRec, levels = c('No', 'Yes'))
validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=30& as.numeric(input$AgeYr)<=93, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
Diabetes = factor(input$Diabetes, levels = c('No', 'Yes - Oral agents only', 'Yes - Treatment includes Insulin'))
FreqVeaRec = factor(input$FreqVeaRec, levels = c('No', 'Yes'))
SMKNow = factor(input$SMKNow, levels = c('No', 'Yes'))
Hypertension = factor(input$Hypertension, levels = c('No', 'Yes'))
Gender = factor(input$Gender, levels = c('No', 'Yes'))
validate(need(!is.na(as.numeric(input$PctPredMet))& as.numeric(input$PctPredMet)>=0.2& as.numeric(input$PctPredMet)<=2.4, 'Please input a valid PctPredMet'))
PctPredMet= as.numeric(input$PctPredMet)
validate(need(!is.na(as.numeric(input$STChange))& as.numeric(input$STChange)>=0& as.numeric(input$STChange)<=8, 'Please input a valid STChange'))
STChange= as.numeric(input$STChange)
TestAngina = factor(input$TestAngina, levels = c('No', 'Yes'))
TypAngina = factor(input$TypAngina, levels = c('No', 'Yes'))
data <- data.frame(LowRec = LowRec,
AgeYr = AgeYr,
Diabetes = Diabetes,
FreqVeaRec = FreqVeaRec,
SMKNow = SMKNow,
Hypertension = Hypertension,
Gender = Gender,
PctPredMet = PctPredMet,
STChange = STChange,
TestAngina = TestAngina,
TypAngina = TypAngina)
data})
output$result <- renderDataTable({data = data()
prob.3yr <- paste(ifelse(round(0.991842 ** eval(predict.prob, data) * 100, 0) < 1, "<1", ifelse(round(0.991842 ** eval(predict.prob, data) * 100, 0) > 99, ">99", round(0.991842 ** eval(predict.prob, data) * 100, 0))), "%")
prob.5yr <- paste(ifelse(round(0.985802 ** eval(predict.prob, data) * 100, 0) < 1, "<1", ifelse(round(0.985802 ** eval(predict.prob, data) * 100, 0) > 99, ">99", round(0.985802 ** eval(predict.prob, data) * 100, 0))), "%")
prob.10yr <- paste(ifelse(round(0.965966 ** eval(predict.prob, data) * 100, 0) < 1, "<1", ifelse(round(0.965966 ** eval(predict.prob, data) * 100, 0) > 99, ">99", round(0.965966 ** eval(predict.prob, data) * 100, 0))), "%")
res = data.frame(Result = c("3-Year Survival Percentage","5-Year Survival Percentage","10-Year Survival Percentage"),
                 Probability = c(prob.3yr, prob.5yr, prob.10yr))

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
        